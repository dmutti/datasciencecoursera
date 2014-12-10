run_analysis <- function(directory) {
    features = read.table(paste(directory, "/", "/features.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
    mean_cols = find_mean_columns(features)
    std_dev_cols = find_std_dev_columns(features)

    train_subjects = read.table(paste(directory, "/", "/train/subject_train_head.txt", sep = ""), header=FALSE)
    train_data = read.fwf(paste(directory, "/", "/train/X_train_head.txt", sep = ""), header=FALSE, widths = rep(16, 561))

    complete_train_data = filter_data(mean_cols, std_dev_cols, train_subjects, train_data)
    colnames(complete_train_data) = column_names(mean_cols, std_dev_cols, filtered_train_data)
    complete_train_data
}

find_mean_columns <- function(features) {
    rows = grep("mean()", features$V2)
    features[rows,]
}

find_std_dev_columns <- function(features) {
    rows = grep("std()", features$V2)
    features[rows,]
}

filter_data <- function(mean_cols, std_dev_cols, subjects, data) {
    filtered = data[c(mean_cols$V1, std_dev_cols$V1)]
    cbind(subjects, filtered)
}

column_names <- function(mean_cols, std_dev_cols, data) {
    c("subject", mean_cols$V2, std_dev_cols$V2)
}
