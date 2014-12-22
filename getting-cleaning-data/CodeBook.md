# Tidy Dataset - The CodeBook

This dataset is derived from the Human Activity Recognition Using Smartphones" dataset, which contains data collected from the accelerometers from the Samsung Galaxy S smartphone. An in-depth explanation is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and the original dataset, [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Original Dataset

The original dataset had 10299 records, splitted between train and test. For each record, it is provided:
* a 561-feature vector with time and frequency domain variables;
* an activity label;
* an identifier of the subject who carried out the experiment.

### Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

## Tidy Dataset

The derived dataset contains **solely** the average of measurements related to the mean and standard deviation for each measurement, grouped by activity and by subject. To extract those, the script extracts the fields whose names match the regular expression `.*(mean|std)\(\).*` and substitutes `[(),-]` with nothing; finally, it applies the `tolower` function in the remaining strings. This results in measurements that refer to the mean contain the substring `mean` in their name. In the same way, measurements that refer to the standard deviation contain the the substring `std`.

To generate the tidy dataset, the script combines the train and test datasets into a single **merged** structure. It then executes the `aggregate` function with the arguments `by=list("subject"=merged$subject, "activity"=merged$activity), FUN=mean`, which calculates the mean of every measurement for each combination of subject and activity. This results in a dataset with 68 columns, explained in what follows.

## The Data

The table below lists the field index, its name, and the range of values it holds.

|Field Index | Field Name | Value Range |
|------------|------------|-------------|
| 01 | subject | [1,30] |
| 02 | activity | {laying, sitting, standing, walking, walking_downstairs, walking_upstairs} |
| 03 | tbodyaccmeanx | [-1,1] |
| 04 | tbodyaccmeany | [-1,1] |
| 05 | tbodyaccmeanz | [-1,1] |
| 06 | tbodyaccstdx | [-1,1] |
| 07 | tbodyaccstdy | [-1,1] |
| 08 | tbodyaccstdz | [-1,1] |
| 09 | tgravityaccmeanx | [-1,1] |
| 10 | tgravityaccmeany | [-1,1] |
| 11 | tgravityaccmeanz | [-1,1] |
| 12 | tgravityaccstdx | [-1,1] |
| 13 | tgravityaccstdy | [-1,1] |
| 14 | tgravityaccstdz | [-1,1] |
| 15 | tbodyaccjerkmeanx | [-1,1] |
| 16 | tbodyaccjerkmeany | [-1,1] |
| 17 | tbodyaccjerkmeanz | [-1,1] |
| 18 | tbodyaccjerkstdx | [-1,1] |
| 19 | tbodyaccjerkstdy | [-1,1] |
| 20 | tbodyaccjerkstdz | [-1,1] |
| 21 | tbodygyromeanx | [-1,1] |
| 22 | tbodygyromeany | [-1,1] |
| 23 | tbodygyromeanz | [-1,1] |
| 24 | tbodygyrostdx | [-1,1] |
| 25 | tbodygyrostdy | [-1,1] |
| 26 | tbodygyrostdz | [-1,1] |
| 27 | tbodygyrojerkmeanx | [-1,1] |
| 28 | tbodygyrojerkmeany | [-1,1] |
| 29 | tbodygyrojerkmeanz | [-1,1] |
| 30 | tbodygyrojerkstdx | [-1,1] |
| 31 | tbodygyrojerkstdy | [-1,1] |
| 32 | tbodygyrojerkstdz | [-1,1] |
| 33 | tbodyaccmagmean | [-1,1] |
| 34 | tbodyaccmagstd | [-1,1] |
| 35 | tgravityaccmagmean | [-1,1] |
| 36 | tgravityaccmagstd | [-1,1] |
| 37 | tbodyaccjerkmagmean | [-1,1] |
| 38 | tbodyaccjerkmagstd | [-1,1] |
| 39 | tbodygyromagmean | [-1,1] |
| 40 | tbodygyromagstd | [-1,1] |
| 41 | tbodygyrojerkmagmean | [-1,1] |
| 42 | tbodygyrojerkmagstd | [-1,1] |
| 43 | fbodyaccmeanx | [-1,1] |
| 44 | fbodyaccmeany | [-1,1] |
| 45 | fbodyaccmeanz | [-1,1] |
| 46 | fbodyaccstdx | [-1,1] |
| 47 | fbodyaccstdy | [-1,1] |
| 48 | fbodyaccstdz | [-1,1] |
| 49 | fbodyaccjerkmeanx | [-1,1] |
| 50 | fbodyaccjerkmeany | [-1,1] |
| 51 | fbodyaccjerkmeanz | [-1,1] |
| 52 | fbodyaccjerkstdx | [-1,1] |
| 53 | fbodyaccjerkstdy | [-1,1] |
| 54 | fbodyaccjerkstdz | [-1,1] |
| 55 | fbodygyromeanx | [-1,1] |
| 56 | fbodygyromeany | [-1,1] |
| 57 | fbodygyromeanz | [-1,1] |
| 58 | fbodygyrostdx | [-1,1] |
| 59 | fbodygyrostdy | [-1,1] |
| 60 | fbodygyrostdz | [-1,1] |
| 61 | fbodyaccmagmean | [-1,1] |
| 62 | fbodyaccmagstd | [-1,1] |
| 63 | fbodybodyaccjerkmagmean | [-1,1] |
| 64 | fbodybodyaccjerkmagstd | [-1,1] |
| 65 | fbodybodygyromagmean | [-1,1] |
| 66 | fbodybodygyromagstd | [-1,1] |
| 67 | fbodybodygyrojerkmagmean | [-1,1] |
| 68 | fbodybodygyrojerkmagstd | [-1,1] |
