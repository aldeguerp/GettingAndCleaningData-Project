# Code Book

## Information about the variables in the data set not contained in the tidy data

Information in tidy data:
* subjectId: Identification of the person who collaborated in the activity. Only a number to 1 to 30
* activityDescription: Activity the person was doing: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

Average for the means and Standar desviations of the measures recorded by each person and activity for the following features:
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

More information about this information is available in Code book of the original data in file features_info.txt

## Information about the summary choices you made

Steps to get TidyData from the raw file provided in the original study.

1. Download data file from Internet
2. Unzip the file
3. Read X and Y files from test and training
4. Merge X files in one file, and the same for Y files
5. Read features mesured and use those descriptions for labels in X information
6. Select only mean() and std() from X and dismiss other features. At this point the tidyData is created
7. Read activities and assign descriptions to Y file (restoring original order)
8. Include subjectId and activityDescription to tidyData (with all selected features)
9. Melt tidyData and summarise to obtain 1 row for each subject, activity, feature
10. Reshape data to create final tidy data: tidyData2Cols
11. Write to file: export_data.txt


## Information about the experimental study you used

Original data is from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original info of the data is as follows:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Webpage: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
