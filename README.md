<h1 color="darkblue">Getting-and-Cleaning-Data</h1>
  <h3> <b>Autor:</b> Oscar Reyes</h3>
  <h3> <b>Title:</b> Course Project - Getting Cleaning Data </h3>
  <h3> Description:</h3> 
  <p>The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
    The goal is to prepare tidy data that can be used for later analysis. 
    This repo explains how all of the scripts work and how they are connected.  
    One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: </p>
          
               http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
<br>
    <p>Here are the data for the project: </p>
        
               https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

<h2> Files contained in this repository</h2>
  <ol> 
    <li><b>README.md</b>       --> this file.</li>
    <li><b>CodeBook.md</b>     --> describes the variables, the data, and any transformations or work performed to clean up the data.</li>
    <li><b>run_analysis.R</b>  --> R script, executes 5 procedures to obtain tidy data, and store it in a file: <b>tidyDataSet.txt</b>.</li>
  </ol>
<br>
<h1>Script Explanation - run_analysis.R</h1>

<h2> Loaded packages</h2>
  <ul>
    <li>library (dplyr)</li>
    <li>library (epicalc)</li>
    <li>library (Hmisc)</li>
    <li>library (httr)</li>
    <li>library (knitr)</li>
    <li>library (memisc)</li>
    <li>library (R.utils)</li>
    <li>library (tidyr)</li>
  </ul>

<h2> Verify if the folder "data" exists, if not exist it is created</h2>
  <p>if (!file.exists("./data/")){
        dir.create("./data")
}</p>

<h2> Download the .zip file</h2>
<p>fileUrl &#60;- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"</p>
<p>download.file (fileUrl, destfile = "./data/UCI HAR Dataset.zip", method = "curl")</p>

<h2> Unzip the file</h2>
  <h3>The files are unzipped in <b>UCI HAR Dataset</b> folder.<br> </h3>
unzip (zipfile = "./data/UCI HAR Dataset.zip", exdir = "./data")

<h2>Creating the new url</h2>
unzipFolder &#60;- file.path ("./data", "UCI HAR Dataset")

<h2>Loading files/data --> loading data from files</h2>
  Files to use in the project, and a brief descripction of each one:
    <ul> 
      <li>'train/X_train.txt': Training set.</li>
      <li>'train/y_train.txt': Training labels.</li>
      <li>'test/X_test.txt': Test set.</li>
      <li>'test/y_test.txt': Test labels.</li>
      <li>The following files are available for the train and test data. Their descriptions are equivalent: 
          'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.</li>
    </ul>

<h2> Reading X_test.txt and Y_test.txt</h2>
  <ul>
    <li> X_test_Data  &#60;- read.table (file.path (unzipFolder, "test", "X_test.txt"), header = FALSE)</li>
    <li> Y_test_Data  &#60;- read.table (file.path (unzipFolder, "test", "y_test.txt"), header = FALSE)</li>
  </ul>
  
<h2> Reading X_train.txt and Y_train.txt</h2>
  <ul>
    <li> X_train_Data &#60;- read.table (file.path (unzipFolder, "train", "X_train.txt"), header = FALSE)</li>
    <li> Y_train_Data &#60;- read.table (file.path (unzipFolder, "train", "y_train.txt"), header = FALSE)</li>
  </ul>
        
<h2> Reading subject_test.txt and subject_train.txt</h2>
  <ul>
    <li>subject_test_Data &#60;- read.table (file.path (unzipFolder, "test", "subject_test.txt"), header = FALSE)</li>
    <li>subject_train_Data &#60;- read.table (file.path (unzipFolder, "train", "subject_train.txt"), header = FALSE)</li>
  </ul>

<h2> Readind features.txt:</h2>
features_Data &#60;- read.table (file.path (unzipFolder, "features.txt"), header = FALSE)

<h2> Reading activiy_labels.txt:</h2>
activity_labels_Data &#60;- read.table (file.path (unzipFolder, "activity_labels.txt"), header = FALSE)

<h2> Points to develop</h2>
 <ol>  
  <li>Merges the training and the test sets to create one data set.</li>
  <li>Extracts only the measurements on the mean and standard deviation for each measurement.</li>
  <li>Uses descriptive activity names to name the activities in the data set.</li>
  <li>Appropriately labels the data set with descriptive variable names.</li>
  <li>From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
</ol>
<h3>  1. Merges the training and the test sets to create one data set.</h3>
        # Mergin SET by ROWS and assign column names
        X_test_train &#60;- rbind (X_test_Data, X_train_Data)
        names (X_test_train) &#60;- features_Data$V2

        # Mergin LABEL by ROWS ans assign column name
        Y_test_train &#60;- rbind (Y_test_Data, Y_train_Data)
        names (Y_test_train) &#60;- c("label")

        # Mergin SUBJECT by ROWS and assign column name
        subject_test_train &#60;- rbind (subject_test_Data, subject_train_Data)
        names (subject_test_train) &#60;- c ("subject")

        # Combine all data.tables mergin by column, to create one data set --> dataSet
        Y_subject_test_train &#60;- cbind (Y_test_train, subject_test_train)
        dataSet &#60;- cbind (Y_subject_test_train, X_test_train)

        # Verification
        str (dataSet)
        head (dataSet, 10)
        names (dataSet)

<h3>  2. Extracts only the measurements on the mean and standard deviation for each measurement.</h3>
        # Reading the FEATURES with MEAN and STD
        mean_std_Features &#60;- features_Data$V2 [grep ("mean\\(\\)|std\\(\\)", features_Data$V2)]

        # Extract only mean and standard devitation from dataSet
        dataSet_mean_std_Features &#60;- subset (dataSet, select = c(as.character(mean_std_Features), "label", "subject"))

        # Verification
        str (dataSet_mean_std_Features)
        head (dataSet_mean_std_Features, 10)
        names (dataSet_mean_std_Features)

<h3>  3. Uses descriptive activity names to name the activities in the data set</h3>
        # Replace activity names with names of activity_labels
        dataSet_mean_std_Features$label &#60;- activity_labels_Data[dataSet_mean_std_Features$label, 2]

        # Verification
        head (dataSet_mean_std_Features$label, 40)
        str (dataSet_mean_std_Features$label)
        names (dataSet_mean_std_Features$label)

<h3>  4. Appropriately labels the data set with descriptive variable names.</h3>
        # Remove parentheses
        names (dataSet_mean_std_Features) &#60;- gsub ("\\()", "", names (dataSet_mean_std_Features))
        # Remove dashes
        names (dataSet_mean_std_Features) &#60;- gsub ("\\-", "", names (dataSet_mean_std_Features))

        # Replace assigned letters to its complete name: 
        #       Gyro = Gyroscope
        #       t = Time
        #       Acc = Accelerometer 
        #       f = Frequency 
        #       Mag = Magnitude 
        #       BodyBody = Body
        names (dataSet_mean_std_Features) &#60;- gsub ("Gyro", "Gyroscope_", names (dataSet_mean_std_Features))        
        names (dataSet_mean_std_Features) &#60;- gsub ("^t", "Time_", names (dataSet_mean_std_Features))
        names (dataSet_mean_std_Features) &#60;- gsub ("Acc", "Accelerometer_", names (dataSet_mean_std_Features))
        names (dataSet_mean_std_Features) &#60;- gsub ("^f", "Frequency_", names (dataSet_mean_std_Features))
        names (dataSet_mean_std_Features) &#60;- gsub ("Mag", "Magnitude_", names (dataSet_mean_std_Features))
        names (dataSet_mean_std_Features) &#60;- gsub ("BodyBody", "Body_", names (dataSet_mean_std_Features))

        # Verification
        str (dataSet_mean_std_Features)
        head (dataSet_mean_std_Features, 40)
        names (dataSet_mean_std_Features)

<h3>  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</h3>
        # tidyDataSet --> New dataSet with the average (mean)   
        #               of each variable for each activity and each subject
        tidyDataSet &#60;- stats:::aggregate.formula ( .~subject + label, data = dataSet_mean_std_Features, mean)
        # Save the data in a file
        write.table (tidyDataSet, file = "./data/tidyDataSet.txt", row.names = FALSE)

<h1>Tidy file</h1>
  <h2>tidyDataSet.txt</h2>
