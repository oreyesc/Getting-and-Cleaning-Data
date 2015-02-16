
#
#       @autor: Oscar Reyes
#       @title: Course Project - Getting Cleaning Data 
#       @description:
#  The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a 
# series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as 
# described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code 
# book that describes the variables, the data, and any transformations or work that you performed to clean up 
# the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo  
# explains how all of the scripts work and how they are connected.  
#
#  One of the most exciting areas in all of data science right now is wearable computing - see for example this 
# article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to 
# attract new users. The data linked to from the course website represent data collected from the accelerometers 
# from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
#        
#               http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
#  Here are the data for the project: 
#        
#               https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
#   You should create one R script called run_analysis.R that does the following. 
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data set with the average 
#     of each variable for each activity and each subject.
#

# Loading packages
library (dplyr)
library (epicalc)
library (Hmisc)
library (httr)
library (knitr)
library (memisc)
library (R.utils)
library (tidyr)

# Verifies if the folder "data" exists, if not exist it is created
if (!file.exists("./data/")){
        dir.create("./data")
}

# Download the .zip
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file (fileUrl, destfile = "./data/UCI HAR Dataset.zip", method = "curl")

# unzip the file, the files are unzipped in 'UCI HAR Dataset' folder
unzip (zipfile = "./data/UCI HAR Dataset.zip", exdir = "./data")

# Creating the new url
unzipFolder <- file.path ("./data", "UCI HAR Dataset")

# Loading files/data --> loading data from files
# Files to use in the project, and a brief descripction of each one
# - 'train/X_train.txt': Training set.
# - 'train/y_train.txt': Training labels.
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.
# The following files are available for the train and test data. Their descriptions are 
#   equivalent. 
# - 'train/subject_train.txt': Each row identifies the subject who performed the activity for #      each window sample. Its range is from 1 to 30.

# Reading X_test.txt and Y_test.txt
X_test_Data  <- read.table (file.path (unzipFolder, "test", "X_test.txt"), header = FALSE)
Y_test_Data  <- read.table (file.path (unzipFolder, "test", "y_test.txt"), header = FALSE)
        
# Reading X_train.txt and Y_train.txt
X_train_Data <- read.table (file.path (unzipFolder, "train", "X_train.txt"), header = FALSE)
Y_train_Data <- read.table (file.path (unzipFolder, "train", "y_train.txt"), header = FALSE)
        
# Reading subject_test.txt and subject_train.txt
subject_test_Data <- read.table (file.path (unzipFolder, "test", "subject_test.txt"), header = FALSE)
subject_train_Data <- read.table (file.path (unzipFolder, "train", "subject_train.txt"), header = FALSE)

# Readind features.txt
features_Data <- read.table (file.path (unzipFolder, "features.txt"), header = FALSE)

# Reading activiy_labels.txt
activity_labels_Data <- read.table (file.path (unzipFolder, "activity_labels.txt"), header = FALSE)

# Verification
str (X_test_Data)
str (Y_test_Data)

str (X_train_Data)
str (Y_train_Data)

str (subject_test_Data)
str (subject_train_Data)

str (features_Data)
str (activity_labels_Data)
        
# Points to develop:
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data set with the
#     average of each variable for each activity and each subject.

#  1. Merges the training and the test sets to create one data set.
        # Mergin SET by ROWS and assign column names
        X_test_train <- rbind (X_test_Data, X_train_Data)
        names (X_test_train) <- features_Data$V2

        # Mergin LABEL by ROWS ans assign column name
        Y_test_train <- rbind (Y_test_Data, Y_train_Data)
        names (Y_test_train) <- c("label")

        # Mergin SUBJECT by ROWS and assign column name
        subject_test_train <- rbind (subject_test_Data, subject_train_Data)
        names (subject_test_train) <- c ("subject")

        # Combine all data.tables mergin by column, to create one data set --> dataSet
        Y_subject_test_train <- cbind (Y_test_train, subject_test_train)
        dataSet <- cbind (Y_subject_test_train, X_test_train)

        # Verification
        str (dataSet)
        head (dataSet, 10)
        names (dataSet)

#  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
        # Reading the FEATURES with MEAN and STD
        mean_std_Features <- features_Data$V2 [grep ("mean\\(\\)|std\\(\\)", features_Data$V2)]

        # Extract only mean and standard devitation from dataSet
        dataSet_mean_std_Features <- subset (dataSet, select = c(as.character(mean_std_Features), "label", "subject"))

        # Verification
        str (dataSet_mean_std_Features)
        head (dataSet_mean_std_Features, 10)
        names (dataSet_mean_std_Features)

#  3. Uses descriptive activity names to name the activities in the data set
        # Replace activity names with names of activity_labels
        dataSet_mean_std_Features$label <- activity_labels_Data[dataSet_mean_std_Features$label, 2]

        # Verification
        head (dataSet_mean_std_Features$label, 40)
        str (dataSet_mean_std_Features$label)
        names (dataSet_mean_std_Features$label)

#  4. Appropriately labels the data set with descriptive variable names. 
        # Remove parentheses
        names (dataSet_mean_std_Features) <- gsub ("\\()", "", names (dataSet_mean_std_Features))
        # Remove dashes
        names (dataSet_mean_std_Features) <- gsub ("\\-", "", names (dataSet_mean_std_Features))

        # Replace assigned letters to its complete name: 
        #       Gyro = Gyroscope
        #       t = Time
        #       Acc = Accelerometer 
        #       f = Frequency 
        #       Mag = Magnitude 
        #       BodyBody = Body
        names (dataSet_mean_std_Features) <- gsub ("Gyro", "Gyroscope_", names (dataSet_mean_std_Features))        
        names (dataSet_mean_std_Features) <- gsub ("^t", "Time_", names (dataSet_mean_std_Features))
        names (dataSet_mean_std_Features) <- gsub ("Acc", "Accelerometer_", names (dataSet_mean_std_Features))
        names (dataSet_mean_std_Features) <- gsub ("^f", "Frequency_", names (dataSet_mean_std_Features))
        names (dataSet_mean_std_Features) <- gsub ("Mag", "Magnitude_", names (dataSet_mean_std_Features))
        names (dataSet_mean_std_Features) <- gsub ("BodyBody", "Body_", names (dataSet_mean_std_Features))

        # Verification
        str (dataSet_mean_std_Features)
        head (dataSet_mean_std_Features, 40)
        names (dataSet_mean_std_Features)

#  5. From the data set in step 4, creates a second, independent tidy data set with the
#     average of each variable for each activity and each subject.
        # tidyDataSet --> New dataSet with the average (mean)   
        #               of each variable for each activity and each subject
        tidyDataSet <- stats:::aggregate.formula ( .~subject + label, data = dataSet_mean_std_Features, mean)
        # Save the data in a file
        write.table (tidyDataSet, file = "./data/tidyDataSet.txt", row.names = FALSE)
