# Introduction

This repository describes how the script **run_analysis.R**, created as part of the requisites to complete the course "Getting and Cleaning Data".

The script is targeted to process the "Human Activity Recognition Using Smartphones" dataset, which contains data collected from the accelerometers from the Samsung Galaxy S smartphone. An in-depth explanation is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and the dataset, [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

# Working Directory

To execute the script, one is required to download the zip file, then extract its contents into the working directory of R (obtained calling `getwd()`). The **run_analysis.R** file must also be placed inside the working directory.

In the example below, we will assume that the the result of the function `getwd()` is "c:\dev\rwd\". This way, the directory should look like the following. Folders are indicated by an ending "\". Files required by the script are surrounded by brackets.

* c:\dev\rwd\
    * run_analysis.R
    * UCI HAR Dataset\
        * [activity_labels.txt]
        * [features.txt]
        * features_info.txt
        * README.txt
        * test\
            * [subject_test.txt]
            * [X_test.txt]
            * [y_test.txt]
            * Inertial Signals\
        * train\
            * [subject_train.txt]
            * [X_train.txt]
            * [y_train.txt]
            * Inertial Signals\

# The Script

The script does the following:

1. It reads the "Human Activity Recognition Using Smartphones Data Set" from the directory `getwd()/UCI Har Dataset`;
2. It merges the training and the test sets to create one dataset;
3. It extracts only the measurements on the mean and standard deviation for each measurement;
4. It gives descriptive activity names to name the activities in the dataset;
5. It labels the dataset with descriptive variable names;
6. It creates a second, independent tidy dataset with the average of each variable for each activity and each subject;
7. Finally, it saves the resulting dataset as a file called `getwd()/UCI Har Dataset/tidy.txt`

# Code Book

The [CodeBook.md](https://github.com/dmutti/getting-cleaning-data/blob/master/CodeBook.md) file, available in this repository, offers a detailed explanation about the steps performed by the script and the resulting data and variables.
