---
title: "CodeBook"
author: "Oscar Reyes"
date: "February 16, 2015"
output:
  html_document:
    css: styles.css
---
*******

#Project Objectives    
<font face="arial" size="4">
        The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.    
        One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.     
        A full description is available at the site where the data was obtained:  
        
</font>
*<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>*


<font face="arial" size="4">Here are the data for the project: </font>    

*<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>*


<font face="arial" size="4">
        <br><font color="darkblue"><b>run_analysis.R</b></font> is a script that does the following:
</font>

1. Merges the training and the test sets to create one data set:
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Variables    
Table containing variables and its definition:   

Var Names       |       Definition      |       Comments/Function
------------------------------------------------------------------



<table >
        <caption><b>Table of Variables</b></caption>
         <thead>
                <tr>
                        <th >Var Name</th>
                        <th >Definition</th>
                        <th >Comments/Function</th>
                </tr>
        </thead>
        <tbody>
                <tr>
                        <td colspan="3" bgcolor="#ADD8E6"><b>To Load Information</b></td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td>fileUrl</td>
                        <td>URL where the project data are.</td>
                        <td>String</td>
                </tr>
                <tr>
                        <td>unzipFolder</td>
                        <td>Path where is stored the zip file and the unzipped files.</td>
                        <td>Path: `./data/UCI HAR Dataset`</td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td>X_test_Data</td>
                        <td>Contains `Test Set`.</td>
                        <td>File source: `X_test.txt`</td>
                </tr>
                <tr>
                        <td>Y_test_Data</td>
                        <td>Contains `Test Labels`.</td>
                        <td>File source: `Y_test.txt`</td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td>X_train_Data</td>
                        <td>Contains `Train Set`.</td>
                        <td>File source: `X_train.txt`</td>
                </tr>
                <tr>
                        <td>Y_train_Data</td>
                        <td>Contains `Train Labels`.</td>
                        <td>File source: `y_test.txt`</td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td>subject_test_Data</td>
                        <td>Each row identifies the subject who performed the activity for # each window sample. Its range is from 1 to 30.</td>
                        <td>File source: `X_test.txt`</td>
                </tr>
                <tr>
                        <td>subject_train_Data</td>
                        <td>Each row identifies the subject who performed the activity for # each window sample. Its range is from 1 to 30.</td>
                        <td>File source: `Y_test.txt`</td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td>features_Data</td>
                        <td>List of all features.</td>
                        <td> - o -</td>
                </tr>
                <tr>
                        <td>activity_labels_Data</td>
                        <td>Links the class labels with their activity name</td>
                        <td> - o -</td>
                </tr>
                <tr>
	                <td colspan="3" bgcolor="#ADD8E6"><b>To Merge Data</b></td>
	        </tr>
                <tr bgcolor="#DCDCDC">
                        <td>X_test_train</td>
                        <td>Contains merge by rows of X_test_Data and X_train_Data.</td>
                        <td>`rbind (X_test_Data, X_train_Data)`</td>
                </tr>
                <tr>
                        <td>Y_test_train</td>
                        <td>Contains merge by rows of Y_test_Data and Y_train_Data.</td>
                        <td>`rbind (Y_test_Data, Y_train_Data)`</td>
                </tr>
		<tr bgcolor="#DCDCDC">
                        <td>subject_test_train</td>
                        <td>Contains merge by rows of subject_test_Data and subject_train_Data.</td>
                        <td>`rbind (subject_test_Data, subject_train_Data)`</td>
                </tr>
                <tr>
                        <td>Y_subject_test_train</td>
                        <td>Contains merge by columns of Y_test_train and subject_test_train.</td>
                        <td>`cbind (Y_test_train, subject_test_train)`</td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td><b>dataSet</b></td>
                        <td>Contains merge by columns of Y_subject_test_train and subject_test_train.</td>
                        <td>`cbind (Y_subject_test_train, subject_test_train)`.
	                        <br>Contains the answer to Point `1. Merges the training and the test sets to create one data set.`</td>
                </tr>
                <tr>
	                <td colspan="3" bgcolor="#ADD8E6"><b>Transforming Data</b></td>
	        </tr>
                <tr>
                        <td>mean_std_Features</td>
                        <td>Extracts the column names that contains MEAN or STD.</td>
                        <td>`features_Data$V2 [grep ("mean\\(\\)|std\\(\\)", features_Data$V2)]`</td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td>dataSet_mean_std_Features</td>
                        <td>Contains a subsegment of `dataSet` that contains all the columns that contains MEAN or STD, and the columns `label` and `subject`.
	                        <br>Contains the answer to point `2.  Extracts only the measurements on the mean and standard deviation`
	                        `for each measurement.`</td>
                        <td>`subset (dataSet, select = c(as.character(mean_std_Features),`
                        <br>`label", "subject"))`</td>
                </tr>
                <tr>
	                <td>dataSet_mean_std_Features&#36;label</td>
	                <td>Contains the replacement of the activity names with names of `activity_labels`
		                <br>Contains the answer to point `3. Uses descriptive activity names to name the activities in the data set.`
	                </td>
	                <td>`activity_labels_Data[dataSet_mean_std_Features$label, 2]`</td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td>dataSet_mean_std_Features</td>
                        <td>Modify the labels of the data with a descriptive variable names.
	                        <br>Contains the answer to point `4. Appropriately labels the data set with descriptive variable names.`</td>
                        <td>Eliminate parentheses: <br>`gsub ("\\()", "", names (dataSet_mean_std_Features))`
	                        <br>Eliminate dashes: <br>`gsub ("\\-", "", names (dataSet_mean_std_Features))`
	                        <br>Replace short names and letters by large names:
	                        <br>`gsub ("Gyro", "Gyroscope_", names (dataSet_mean_std_Features))`
	                        <br>`gsub ("^t", "Time_", names (dataSet_mean_std_Features))`
	                        <br>`gsub ("Acc", "Accelerometer_", names (dataSet_mean_std_Features))`
	                        <br>`gsub ("^f", "Frequency_", names (dataSet_mean_std_Features))`
	                        <br>`gsub ("Mag", "Magnitude_", names (dataSet_mean_std_Features))`
	                        <br>`gsub ("BodyBody", "Body_", names (dataSet_mean_std_Features))`
                        </td>
                </tr>
                <tr>
                        <td>dataSet_mean_std_Features&#36;label</td>
                        <td>Contains the replacement of the activity names with names of activity_labels.
	                        Contains the answer to point `3. Uses descriptive activity names to name the activities in the data set.`</td>
                        <td>`activity_labels_Data[dataSet_mean_std_Features$label, 2]`</td>
                </tr>
                <tr bgcolor="#DCDCDC">
                        <td><b>tidydataSet</b></td>
                        <td>Splits the `dataSet_mean_std_Features` into subsets, computes the `mean` for each, and returns the result.
	                        <br>Contains the answer to point `5. From the data set in step 4, creates a second, independent tidy data set` `with the average of each variable for each activity and each subject.`</td>
                        <td>`subset (dataSet, select = c(as.character(mean_std_Features),`
                        <br>`"label", "subject"))`</td>
                </tr>
                <tr>
	                <td colspan="3" bgcolor="#ADD8E6"><b>Tidy Data</b></td>
	        </tr>
                <tr>
	                <td>tidyDataSet.txt</td>
	                <td>Contains the `tidyData`
	                </td>
	                <td>`write.table (tidyDataSet, file = "./data/tidyDataSet.txt", row.names = FALSE)`</td>
                </tr>
        </tbody>
</table>      
**********    

##Summary of the Result of Each Point

####1. Merges the training and the test sets to create one data set: 
```
str (dataSet)
```
```
## 'data.frame':        10299 obs. of  563 variables:
##  $ label                               : int  5 5 5 5 5 5 5 5 5 5 ...
##  $ subject                             : int  2 2 2 2 2 2 2 2 2 2 ...
##  $ tBodyAcc-mean()-X                   : num  0.257 0.286 0.275 0.27 0.275 ...
##  $ tBodyAcc-mean()-Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
##  $ tBodyAcc-mean()-Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
##  $ tBodyAcc-std()-X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
##  $ tBodyAcc-std()-Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
##  $ tBodyAcc-std()-Z                    : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
##  $ tBodyAcc-mad()-X                    : num  -0.953 -0.987 -0.994 -0.995 -0.994 ...
##  $ tBodyAcc-mad()-Y                    : num  -0.925 -0.968 -0.971 -0.974 -0.966 ...
##  $ tBodyAcc-mad()-Z                    : num  -0.674 -0.946 -0.963 -0.969 -0.977 ...
##  $ tBodyAcc-max()-X                    : num  -0.894 -0.894 -0.939 -0.939 -0.939 ...
##  $ tBodyAcc-max()-Y                    : num  -0.555 -0.555 -0.569 -0.569 -0.561 ...
##  $ tBodyAcc-max()-Z                    : num  -0.466 -0.806 -0.799 -0.799 -0.826 ...
##  $ tBodyAcc-min()-X                    : num  0.717 0.768 0.848 0.848 0.849 ...
##  $ tBodyAcc-min()-Y                    : num  0.636 0.684 0.668 0.668 0.671 ...
##  $ tBodyAcc-min()-Z                    : num  0.789 0.797 0.822 0.822 0.83 ...
##  $ tBodyAcc-sma()                      : num  -0.878 -0.969 -0.977 -0.974 -0.975 ...
##  $ tBodyAcc-energy()-X                 : num  -0.998 -1 -1 -1 -1 ...
##  $ tBodyAcc-energy()-Y                 : num  -0.998 -1 -1 -0.999 -0.999 ...
##  $ tBodyAcc-energy()-Z                 : num  -0.934 -0.998 -0.999 -0.999 -0.999 ...
##  $ tBodyAcc-iqr()-X                    : num  -0.976 -0.994 -0.993 -0.995 -0.993 ...
##  $ tBodyAcc-iqr()-Y                    : num  -0.95 -0.974 -0.974 -0.979 -0.967 ...
##  $ tBodyAcc-iqr()-Z                    : num  -0.83 -0.951 -0.965 -0.97 -0.976 ...
##  $ tBodyAcc-entropy()-X                : num  -0.168 -0.302 -0.618 -0.75 -0.591 ...
##  $ tBodyAcc-entropy()-Y                : num  -0.379 -0.348 -0.695 -0.899 -0.74 ...
##  $ tBodyAcc-entropy()-Z                : num  0.246 -0.405 -0.537 -0.554 -0.799 ...
##  $ tBodyAcc-arCoeff()-X,1              : num  0.521 0.507 0.242 0.175 0.116 ...
##  $ tBodyAcc-arCoeff()-X,2              : num  -0.4878 -0.1565 -0.115 -0.0513 -0.0289 ...
##  $ tBodyAcc-arCoeff()-X,3              : num  0.4823 0.0407 0.0327 0.0342 -0.0328 ...
##  $ tBodyAcc-arCoeff()-X,4              : num  -0.0455 0.273 0.1924 0.1536 0.2943 ...
##  $ tBodyAcc-arCoeff()-Y,1              : num  0.21196 0.19757 -0.01194 0.03077 0.00063 ...
##  $ tBodyAcc-arCoeff()-Y,2              : num  -0.1349 -0.1946 -0.0634 -0.1293 -0.0453 ...
##  $ tBodyAcc-arCoeff()-Y,3              : num  0.131 0.411 0.471 0.446 0.168 ...
##  $ tBodyAcc-arCoeff()-Y,4              : num  -0.0142 -0.3405 -0.5074 -0.4195 -0.0682 ...
##  $ tBodyAcc-arCoeff()-Z,1              : num  -0.106 0.0776 0.1885 0.2715 0.0744 ...
##  $ tBodyAcc-arCoeff()-Z,2              : num  0.0735 -0.084 -0.2316 -0.2258 0.0271 ...
##  $ tBodyAcc-arCoeff()-Z,3              : num  -0.1715 0.0353 0.6321 0.4164 -0.1459 ...
##  $ tBodyAcc-arCoeff()-Z,4              : num  0.0401 -0.0101 -0.5507 -0.2864 -0.0502 ...
##  $ tBodyAcc-correlation()-X,Y          : num  0.077 -0.105 0.3057 -0.0638 0.2352 ...
##  $ tBodyAcc-correlation()-X,Z          : num  -0.491 -0.429 -0.324 -0.167 0.29 ...
##  $ tBodyAcc-correlation()-Y,Z          : num  -0.709 0.399 0.28 0.545 0.458 ...
##  $ tGravityAcc-mean()-X                : num  0.936 0.927 0.93 0.929 0.927 ...
##  $ tGravityAcc-mean()-Y                : num  -0.283 -0.289 -0.288 -0.293 -0.303 ...
##  $ tGravityAcc-mean()-Z                : num  0.115 0.153 0.146 0.143 0.138 ...
##  $ tGravityAcc-std()-X                 : num  -0.925 -0.989 -0.996 -0.993 -0.996 ...
##  $ tGravityAcc-std()-Y                 : num  -0.937 -0.984 -0.988 -0.97 -0.971 ...
##  $ tGravityAcc-std()-Z                 : num  -0.564 -0.965 -0.982 -0.992 -0.968 ...
##  $ tGravityAcc-mad()-X                 : num  -0.93 -0.989 -0.996 -0.993 -0.996 ...
##  $ tGravityAcc-mad()-Y                 : num  -0.938 -0.983 -0.989 -0.971 -0.971 ...
##  $ tGravityAcc-mad()-Z                 : num  -0.606 -0.965 -0.98 -0.993 -0.969 ...
##  $ tGravityAcc-max()-X                 : num  0.906 0.856 0.856 0.856 0.854 ...
##  $ tGravityAcc-max()-Y                 : num  -0.279 -0.305 -0.305 -0.305 -0.313 ...
##  $ tGravityAcc-max()-Z                 : num  0.153 0.153 0.139 0.136 0.134 ...
##  $ tGravityAcc-min()-X                 : num  0.944 0.944 0.949 0.947 0.946 ...
##  $ tGravityAcc-min()-Y                 : num  -0.262 -0.262 -0.262 -0.273 -0.279 ...
##  $ tGravityAcc-min()-Z                 : num  -0.0762 0.149 0.145 0.1421 0.1309 ...
##  $ tGravityAcc-sma()                   : num  -0.0178 0.0577 0.0406 0.0461 0.0554 ...
##  $ tGravityAcc-energy()-X              : num  0.829 0.806 0.812 0.809 0.804 ...
##  $ tGravityAcc-energy()-Y              : num  -0.865 -0.858 -0.86 -0.854 -0.843 ...
##  $ tGravityAcc-energy()-Z              : num  -0.968 -0.957 -0.961 -0.963 -0.965 ...
##  $ tGravityAcc-iqr()-X                 : num  -0.95 -0.988 -0.996 -0.992 -0.996 ...
##  $ tGravityAcc-iqr()-Y                 : num  -0.946 -0.982 -0.99 -0.973 -0.972 ...
##  $ tGravityAcc-iqr()-Z                 : num  -0.76 -0.971 -0.979 -0.996 -0.969 ...
##  $ tGravityAcc-entropy()-X             : num  -0.425 -0.729 -0.823 -0.823 -0.83 ...
##  $ tGravityAcc-entropy()-Y             : num  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
##  $ tGravityAcc-entropy()-Z             : num  0.219 -0.465 -0.53 -0.7 -0.302 ...
##  $ tGravityAcc-arCoeff()-X,1           : num  -0.43 -0.51 -0.295 -0.343 -0.482 ...
##  $ tGravityAcc-arCoeff()-X,2           : num  0.431 0.525 0.305 0.359 0.539 ...
##  $ tGravityAcc-arCoeff()-X,3           : num  -0.432 -0.54 -0.315 -0.375 -0.596 ...
##  $ tGravityAcc-arCoeff()-X,4           : num  0.433 0.554 0.326 0.392 0.655 ...
##  $ tGravityAcc-arCoeff()-Y,1           : num  -0.795 -0.746 -0.232 -0.233 -0.493 ...
##  $ tGravityAcc-arCoeff()-Y,2           : num  0.781 0.733 0.169 0.176 0.463 ...
##  $ tGravityAcc-arCoeff()-Y,3           : num  -0.78 -0.737 -0.155 -0.169 -0.465 ...
##  $ tGravityAcc-arCoeff()-Y,4           : num  0.785 0.749 0.164 0.185 0.483 ...
##  $ tGravityAcc-arCoeff()-Z,1           : num  -0.984 -0.845 -0.429 -0.297 -0.536 ...
##  $ tGravityAcc-arCoeff()-Z,2           : num  0.987 0.869 0.44 0.304 0.544 ...
##  $ tGravityAcc-arCoeff()-Z,3           : num  -0.989 -0.893 -0.451 -0.311 -0.553 ...
##  $ tGravityAcc-arCoeff()-Z,4           : num  0.988 0.913 0.458 0.315 0.559 ...
##  $ tGravityAcc-correlation()-X,Y       : num  0.981 0.945 0.548 0.986 0.998 ...
##  $ tGravityAcc-correlation()-X,Z       : num  -0.996 -0.911 -0.335 0.653 0.916 ...
##  $ tGravityAcc-correlation()-Y,Z       : num  -0.96 -0.739 0.59 0.747 0.929 ...
##  $ tBodyAccJerk-mean()-X               : num  0.072 0.0702 0.0694 0.0749 0.0784 ...
##  $ tBodyAccJerk-mean()-Y               : num  0.04575 -0.01788 -0.00491 0.03227 0.02228 ...
##  $ tBodyAccJerk-mean()-Z               : num  -0.10604 -0.00172 -0.01367 0.01214 0.00275 ...
##  $ tBodyAccJerk-std()-X                : num  -0.907 -0.949 -0.991 -0.991 -0.992 ...
##  $ tBodyAccJerk-std()-Y                : num  -0.938 -0.973 -0.971 -0.973 -0.979 ...
##  $ tBodyAccJerk-std()-Z                : num  -0.936 -0.978 -0.973 -0.976 -0.987 ...
##  $ tBodyAccJerk-mad()-X                : num  -0.916 -0.969 -0.991 -0.99 -0.991 ...
##  $ tBodyAccJerk-mad()-Y                : num  -0.937 -0.974 -0.973 -0.973 -0.977 ...
##  $ tBodyAccJerk-mad()-Z                : num  -0.949 -0.979 -0.975 -0.978 -0.985 ...
##  $ tBodyAccJerk-max()-X                : num  -0.903 -0.915 -0.992 -0.992 -0.994 ...
##  $ tBodyAccJerk-max()-Y                : num  -0.95 -0.981 -0.975 -0.975 -0.986 ...
##  $ tBodyAccJerk-max()-Z                : num  -0.891 -0.978 -0.962 -0.962 -0.986 ...
##  $ tBodyAccJerk-min()-X                : num  0.898 0.898 0.994 0.994 0.994 ...
##  $ tBodyAccJerk-min()-Y                : num  0.95 0.968 0.976 0.976 0.98 ...
##  $ tBodyAccJerk-min()-Z                : num  0.946 0.966 0.966 0.97 0.985 ...
##  $ tBodyAccJerk-sma()                  : num  -0.931 -0.974 -0.982 -0.983 -0.987 ...
##  $ tBodyAccJerk-energy()-X             : num  -0.995 -0.998 -1 -1 -1 ...
##   [list output truncated]
```
####2. Extracts only the measurements on the mean and standard deviation for each measurement:   
```   
   names (dataSet_mean_std_Features)
```
```
##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
##  [3] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
##  [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
##  [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
##  [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
## [11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
## [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
## [15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
## [17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
## [19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
## [21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
## [23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
## [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
## [27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
## [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
## [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
## [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
## [35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
## [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
## [39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
## [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
## [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
## [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
## [47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
## [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
## [51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
## [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
## [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
## [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
## [59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
## [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
## [63] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
## [65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 
## [67] "label"                       "subject"
```
####3. Uses descriptive activity names to name the activities in the data set:    
```   
   head (dataSet_mean_std_Features$label, 40)
```
```
##  [1] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
## [10] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
## [19] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
## [28] STANDING STANDING STANDING STANDING SITTING  SITTING  SITTING  SITTING  SITTING 
## [37] SITTING  SITTING  SITTING  SITTING 
## Levels: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
```
####4. Appropriately labels the data set with descriptive variable names:   
```
   names (dataSet_mean_std_Features)
```
```
##  [1] "Time_BodyAccelerometer_meanX"                   
##  [2] "Time_BodyAccelerometer_meanY"                   
##  [3] "Time_BodyAccelerometer_meanZ"                   
##  [4] "Time_BodyAccelerometer_stdX"                    
##  [5] "Time_BodyAccelerometer_stdY"                    
##  [6] "Time_BodyAccelerometer_stdZ"                    
##  [7] "Time_GravityAccelerometer_meanX"                
##  [8] "Time_GravityAccelerometer_meanY"                
##  [9] "Time_GravityAccelerometer_meanZ"                
## [10] "Time_GravityAccelerometer_stdX"                 
## [11] "Time_GravityAccelerometer_stdY"                 
## [12] "Time_GravityAccelerometer_stdZ"                 
## [13] "Time_BodyAccelerometer_JerkmeanX"               
## [14] "Time_BodyAccelerometer_JerkmeanY"               
## [15] "Time_BodyAccelerometer_JerkmeanZ"               
## [16] "Time_BodyAccelerometer_JerkstdX"                
## [17] "Time_BodyAccelerometer_JerkstdY"                
## [18] "Time_BodyAccelerometer_JerkstdZ"                
## [19] "Time_BodyGyroscope_meanX"                       
## [20] "Time_BodyGyroscope_meanY"                       
## [21] "Time_BodyGyroscope_meanZ"                       
## [22] "Time_BodyGyroscope_stdX"                        
## [23] "Time_BodyGyroscope_stdY"                        
## [24] "Time_BodyGyroscope_stdZ"                        
## [25] "Time_BodyGyroscope_JerkmeanX"                   
## [26] "Time_BodyGyroscope_JerkmeanY"                   
## [27] "Time_BodyGyroscope_JerkmeanZ"                   
## [28] "Time_BodyGyroscope_JerkstdX"                    
## [29] "Time_BodyGyroscope_JerkstdY"                    
## [30] "Time_BodyGyroscope_JerkstdZ"                    
## [31] "Time_BodyAccelerometer_Magnitude_mean"          
## [32] "Time_BodyAccelerometer_Magnitude_std"           
## [33] "Time_GravityAccelerometer_Magnitude_mean"       
## [34] "Time_GravityAccelerometer_Magnitude_std"        
## [35] "Time_BodyAccelerometer_JerkMagnitude_mean"      
## [36] "Time_BodyAccelerometer_JerkMagnitude_std"       
## [37] "Time_BodyGyroscope_Magnitude_mean"              
## [38] "Time_BodyGyroscope_Magnitude_std"               
## [39] "Time_BodyGyroscope_JerkMagnitude_mean"          
## [40] "Time_BodyGyroscope_JerkMagnitude_std"           
## [41] "Frequency_BodyAccelerometer_meanX"              
## [42] "Frequency_BodyAccelerometer_meanY"              
## [43] "Frequency_BodyAccelerometer_meanZ"              
## [44] "Frequency_BodyAccelerometer_stdX"               
## [45] "Frequency_BodyAccelerometer_stdY"               
## [46] "Frequency_BodyAccelerometer_stdZ"               
## [47] "Frequency_BodyAccelerometer_JerkmeanX"          
## [48] "Frequency_BodyAccelerometer_JerkmeanY"          
## [49] "Frequency_BodyAccelerometer_JerkmeanZ"          
## [50] "Frequency_BodyAccelerometer_JerkstdX"           
## [51] "Frequency_BodyAccelerometer_JerkstdY"           
## [52] "Frequency_BodyAccelerometer_JerkstdZ"           
## [53] "Frequency_BodyGyroscope_meanX"                  
## [54] "Frequency_BodyGyroscope_meanY"                  
## [55] "Frequency_BodyGyroscope_meanZ"                  
## [56] "Frequency_BodyGyroscope_stdX"                   
## [57] "Frequency_BodyGyroscope_stdY"                   
## [58] "Frequency_BodyGyroscope_stdZ"                   
## [59] "Frequency_BodyAccelerometer_Magnitude_mean"     
## [60] "Frequency_BodyAccelerometer_Magnitude_std"      
## [61] "Frequency_Body_Accelerometer_JerkMagnitude_mean"
## [62] "Frequency_Body_Accelerometer_JerkMagnitude_std" 
## [63] "Frequency_Body_Gyroscope_Magnitude_mean"        
## [64] "Frequency_Body_Gyroscope_Magnitude_std"         
## [65] "Frequency_Body_Gyroscope_JerkMagnitude_mean"    
## [66] "Frequency_Body_Gyroscope_JerkMagnitude_std"     
## [67] "label"                                          
## [68] "subject"
```
####5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:    
```
   write.table (tidyDataSet, file = "./data/tidyDataSet.txt", row.names = FALSE)
```
To see the [tidyDataSet.txt](https://github.com/oreyesc/Getting-and-Cleaning-Data/blob/master/tidyDataSet.txt).       
   

<caption><font color = "red"><b>NOTE:</b></font>   To see more detailed information about the Script, see the <a href="https://github.com/oreyesc/Getting-and-Cleaning-Data/blob/master/README.md"><b>README.md</b></a> file</caption>