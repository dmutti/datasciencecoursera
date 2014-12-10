#write.table(run_analysis(), "c:/output.txt", col.names=FALSE, row.names=FALSE)
run_analysis <- function() {
    prepare()
    features = read.table(paste(getwd(), "/", "features.txt", sep=""), header=FALSE, stringsAsFactors=FALSE, col.names=c("index", "name"))
    mean_cols = find_mean_columns(features)
    std_dev_cols = find_std_dev_columns(features)
    extract_features = c(mean_cols$index, std_dev_cols$index)

    train_data = get_train_data(getwd(), features, extract_features)
    test_data = get_test_data(getwd(), features, extract_features)

    complete_data = rbind(train_data, test_data)
    summary_data = aggregate(complete_data, by=list(complete_data$subject), FUN=mean)
    summary_data[,2:length(summary_data)]
}

prepare <- function() {
    if (length(grep("LaF", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("LaF")
    }
    if (length(grep("data.table", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("data.table")
    }
    library(LaF)
    library(data.table)
}

find_mean_columns <- function(features) {
    rows = grep(".*mean\\(\\).*", features$name)
    features[rows,]
}

find_std_dev_columns <- function(features) {
    rows = grep(".*std\\(\\).*", features$name)
    features[rows,]
}

get_train_data <- function(directory, features, extract_features) {
    get_data(directory, "train/subject_train.txt", "train/X_train.txt", features, extract_features)
}

get_test_data <- function(directory, features, extract_features) {
    get_data(directory, "test/subject_test.txt", "test/X_test.txt", features, extract_features)
}

get_data <- function(directory, subject_file, data_file, features, extract_features) {
    subjects = read.table(paste(directory, "/", subject_file, sep=""), header=FALSE, col.names=c("subject"))
    data = laf_open_fwf(paste(directory, "/", data_file, sep=""), column_widths=rep(16, 561), column_types=rep("numeric", 561), column_names=sub("\\(\\)", "", features$name))
    data = data[,]
    complete_data = filter_data(extract_features, subjects, data)
    complete_data = cbind(subjects, complete_data)
    complete_data
}

filter_data <- function(extract_features, subjects, data) {
    data[extract_features]
}
