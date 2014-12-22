# this script does the following
# 1. reads the "Human Activity Recognition Using Smartphones Data Set" from the directory [getwd()/UCI Har Dataset]
# 2. merges the training and the test sets to create one data set
# 3. extracts only the measurements on the mean and standard deviation for each measurement
# 4. gives descriptive activity names to name the activities in the data set
# 5. labels the data set with descriptive variable names
# 6. it creates a second, independent tidy data set with the average of each variable for each activity and each subject
# 7. it saves the resulting data set as a file called [getwd()/UCI Har Dataset/tidy.txt]
run_analysis <- function() {
    root_dir = paste(getwd(), "/UCI HAR Dataset", sep="")

    #install and load required packages: LaF, data.table
    prepare()

    #read feature names from text file
    features = read.table(paste(root_dir, "/features.txt", sep=""), header=FALSE, stringsAsFactors=FALSE, col.names=c("index", "name"))

    #create the vector of features of interest
    extract_features = get_columns_of_interest(features)

    #get actual data
    train_data = get_train_data(root_dir, features, extract_features)
    test_data = get_test_data(root_dir, features, extract_features)

    #merge test and train data
    complete_data = rbind(train_data, test_data)

    #calculate the average of extracted measures by subject and by activity
    tidy = aggregate(complete_data[,3:length(complete_data)], by=list("subject"=complete_data$subject, "activity"=complete_data$activity), FUN=mean)

    #order by subject
    tidy_ordered = tidy[order(tidy$subject),]

    #remove the column "row.names"
    row.names(tidy_ordered) = NULL
    write.table(tidy_ordered, paste(root_dir, "/tidy.txt", sep=""), col.names=FALSE, row.names=FALSE)
    tidy_ordered
}

#install and load required packages
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

#mean() or std()
get_columns_of_interest <- function(features) {
    rows = grep(".*(mean\\(\\)|std\\(\\)).*", features$name)
    features[rows,1]
}

get_train_data <- function(directory, features, extract_features) {
    get_data(directory, "/train/subject_train.txt", "/train/X_train.txt", "/train/y_train.txt", "/activity_labels.txt", features, extract_features)
}

get_test_data <- function(directory, features, extract_features) {
    get_data(directory, "/test/subject_test.txt", "/test/X_test.txt", "/test/y_test.txt", "/activity_labels.txt", features, extract_features)
}

get_data <- function(directory, subject_file, data_file, activity_file, activity_label_file, features, extract_features) {
    subjects = read.table(paste(directory, subject_file, sep=""), header=FALSE, col.names=c("subject"))
    activity_labels = get_activity_data(directory, activity_file, activity_label_file)

    data = laf_open_fwf(paste(directory, "/", data_file, sep=""), column_widths=rep(16, 561), column_types=rep("numeric", 561), column_names=tolower(gsub("[\\(\\),-]","",features$name)))
    data = data[,]
    complete_data = filter_data(extract_features, subjects, data)
    cbind(subjects, activity_labels, complete_data)
}

#maps an array of activity codes into an array of descriptions
get_activity_data <- function(directory, activity_file, activity_label_file) {
    activity = read.table(paste(directory, activity_file, sep=""), header=FALSE, col.names=c("activity_code"))
    labels = read.table(paste(directory, activity_label_file, sep=""), header=FALSE, col.names=c("code", "label"), sep=" ", stringsAsFactors=FALSE)

    result = character()
    for (i in 1:length(activity)) {
        result <- c(result, tolower(labels[activity[[i]],2]))
    }
    data.frame("activity" = result)
}

filter_data <- function(extract_features, subjects, data) {
    data[extract_features]
}
