# The code should work as long as the Samsung data is in your working directory. 
# Source of data for this project: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# The output should be the tidy data set you submitted for part 1. 
# You should include a README.md in the repo describing how the script works 
# and the code book describing the variables.

library(data.table)
library(dplyr)
library(reshape2)
setwd("F:/Documents/R")

# This R script does the following:
# process UCI HAR Dataset, producing a tidy dataset with the mean of all 
# -mean() and -std() variables, as well as a codebook with all column names.

# Prerequisite: download and unpack the contents of "UCI HAR Dataset" 
# into your working directory.

# import data labels
labels <- read.table("activity_labels.txt", col.names=c("labelcode","label"))
# import features
features <- read.table("features.txt")

# determine important features (those containing -mean() or -std())
wanted_feature_indices <- grep("mean\\(|std\\(", features[,2])

# import training set, choose only important items
training_subject <- read.table("train/subject_train.txt", col.names = "subject")
training_data <- read.table("train/X_train.txt", 
                            col.names = features[,2], check.names=FALSE)
training_data <- training_data[,wanted_feature_indices]
training_labels <- read.table("train/y_train.txt", col.names = "labelcode")
dftraining = cbind(training_labels, training_subject, training_data)

# import test set, choose only important items
test_subject <- read.table("test/subject_test.txt", col.names = "subject")
test_data <- read.table("test/X_test.txt",
                        col.names = features[,2], check.names=FALSE)
test_data <- test_data[,wanted_feature_indices]
test_labels <- read.table("test/y_test.txt", col.names = "labelcode")
dftest = cbind(test_labels, test_subject, test_data)

# merge datasets
df <- rbind(dftraining, dftest)

# replace label codes with the label (labels the data set with descriptive variable names)
df = merge(labels, df, by.x="labelcode", by.y="labelcode")
df <- df[,-1]

# reshape the array
molten <- melt(df, id = c("label", "subject"))

# produce the tidy dataset with mean of each variable 
# for each activity and each subject
tidy <- dcast(molten, label + subject ~ variable, mean)

# write tidy dataset to disk
write.table(tidy, file="tidy_means.txt", quote=FALSE, row.names=FALSE, sep="\t")

# write codebook to disk
write.table(paste("* ", names(tidy), sep=""), file="CodeBook.md", quote=FALSE,
            row.names=FALSE, col.names=FALSE, sep="\t")
