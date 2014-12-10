run_analysis <- function(directory) {
    features = read.table(paste(directory, "/", "/features.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
    mean_cols = find_mean_columns(features)
    std_dev_cols = find_std_dev_columns(features)

    train_data = get_train_data(directory, mean_cols, std_dev_cols)
    test_data = get_test_data(directory, mean_cols, std_dev_cols)

    complete_data = rbind(train_data, test_data)
    complete_data
}

find_mean_columns <- function(features) {
    rows = grep("mean()", features$V2)
    features[rows,]
}

find_std_dev_columns <- function(features) {
    rows = grep("std()", features$V2)
    features[rows,]
}

get_train_data <- function(directory, mean_cols, std_dev_cols) {
    get_data(directory, "/train/subject_train_head.txt", "/train/X_train_head.txt", mean_cols, std_dev_cols)
}

get_test_data <- function(directory, mean_cols, std_dev_cols) {
    get_data(directory, "/test/subject_test_head.txt", "/test/X_test_head.txt", mean_cols, std_dev_cols)
}

get_data <- function(directory, subject_file, data_file, mean_cols, std_dev_cols) {
    subjects = read.table(paste(directory, "/", subject_file, sep = ""), header=FALSE)
    data = read.fwf(paste(directory, "/", data_file, sep = ""), header=FALSE, widths = rep(16, 561))
    complete_data = filter_data(mean_cols, std_dev_cols, subjects, data)
    colnames(complete_data) = column_names(mean_cols, std_dev_cols)
    complete_data
}

filter_data <- function(mean_cols, std_dev_cols, subjects, data) {
    filtered = data[c(mean_cols$V1, std_dev_cols$V1)]
    cbind(subjects, filtered)
}

column_names <- function(mean_cols, std_dev_cols) {
    c("subject", mean_cols$V2, std_dev_cols$V2)
}
