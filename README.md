# Getting and Cleaning Data Course Project

## Original instructions:
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Prerequisite:
* Download and unpack the content of the UCI HAR Dataset into your work directory.

## Steps in run_analysis.R:
1. Load the label codes key from activity_labels.txt
2. Load the feature key from features.txt
3. Determine the indices of desired features (those containing -mean() or -std())
4. Load the training and test data sets and only retain data columns determined by indices from step #3
5. Merge the training and test data sets
6. Replace label codes in the dataset with text labels determined by step #1
7. Reshape data to use label and subject as identifiers
8. Produce a tidy data set (tidy_means.txt) with the average of each variable for each activity/subject combination
9. Produce CodeBook.md with a list of column names (which were taken from features.txt)

## Notes:
* For descriptions of data types and how data was collected, check these files included with the original data: README.txt, features_info.txt
