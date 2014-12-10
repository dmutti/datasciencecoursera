#http://stackoverflow.com/questions/24715894/faster-way-to-read-fixed-width-files-in-r
run_analysis <- function(directory) {
    prepare    
    features = read.table(paste(directory, "/", "features.txt", sep=""), header=FALSE, stringsAsFactors=FALSE, col.names=c("index", "name"))
    mean_cols = find_mean_columns(features)
    std_dev_cols = find_std_dev_columns(features)
    
    train_data = get_train_data(directory, features, c(mean_cols$index, std_dev_cols$index))
    test_data = get_test_data(directory, features, c(mean_cols$index, std_dev_cols$index))
    
    complete_data = rbind(train_data, test_data)
    complete_data
}

prepare <- function {
    if (length(grep("LaF", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("LaF")
    }
    library(LaF)
}

find_mean_columns <- function(features) {
    rows = grep("mean()", features$name)
    features[rows,]
}

find_std_dev_columns <- function(features) {
    rows = grep("std()", features$name)
    features[rows,]
}

get_train_data <- function(directory, features, extract_features) {
    get_data(directory, "train/subject_train.txt", "train/X_train.txt", features, extract_features)
}

get_test_data <- function(directory, features, extract_features) {
    get_data(directory, "test/subject_test_head.txt", "test/X_test_head.txt", features, extract_features)
}

get_data <- function(directory, subject_file, data_file, features, extract_features) {
    subjects = read.table(paste(directory, "/", subject_file, sep = ""), header=FALSE, col.names=c("subject"))
    data = read.fwf(paste(directory, "/", data_file, sep = ""), header=FALSE, widths=rep(16, 561), col.names=features$name)
    complete_data = filter_data(extract_features, subjects, data)
    complete_data = cbind(subjects, complete_data)
    complete_data
}

filter_data <- function(extract_features, subjects, data) {
    data[extract_features]
}
