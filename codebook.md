
1. Download the dataset

  Downloaded and extracted the data under the folder UCI HAR Dataset

2.Assign each data to variables

  features <- features.txt (contains 561 rows and 2 columns)
  
  activity_labels <- activity_labels.txt (contains 6 rows and 2 columns)
  
  subject_test <- test/subject_test.txt (contains 2947 rows and 1 column)
  
  x_test <- test/X_test.txt (contains 2947 rows and 561 columns)
  
  y_test <- test/y_test.txt (contains 2947 rows and 1 column)
  
  subject_train <- test/subject_train.txt (contains 7352 rows and 1 column)
  
  x_train <- test/X_train.txt (contains 7352 rows and 561 columns)
  
  y_train <- test/y_train.txt (contains 7352 rows, 1 columns)
  
  
3. Merges the training and the test sets to create one data set
   
   Merged x_train and x_test usind rbind() function and assigned to a new variable called xData.
   
   Merged y_train and y_test usind rbind() function and assigned to a new variable called yData.
   
   Merged subject_train and subject_test usind rbind() function and assigned to a new variable called subject.
   
   Finally mergedData (10299 rows, 563 column) is created by merging Subject, yData and xData using cbind() function.
   

4. Extracts only the measurements on the mean and standard deviation for each measurement.

  newData is created by subsetting mergedData, selecting only columns: subject, code and the measurements on the         mean and standard deviation (std) for each measurement

5.Uses descriptive activity names to name the activities in the data set

  code column of the newData is  replaced with corresponding activity taken from second column of the activity_label
  
6. Appropriately labels the data set with descriptive variable names

  code column in newData is changed to  Activities
  
  All Acc in column’s name is replaced by Accelerometer
  
  All Gyro in column’s name is replaced by Gyroscope
  
  All BodyBody in column’s name is replaced by Body
  
  All tBody in column’s name is replaced by TimeBody
  
  All Mag in column’s name is replaced by Magnitude
  
  All column's name starts with f is replaced by Frequency
  
  All column's name starts with t is replaced by Time
  
  All -mean() in column's name is replaced by Mean
  
  All -std() in column's name is replaced by STD
  
  All -freq() in column's name is replaced by Frequency
  
  All angle in column's name is replaced by Angle
  
  All gravity in column's name is replaced by Gravity
  
7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each     activity and each subject

  newData is first grouped by subject and activity. tidyData is created by sumarizing newData by taking means of each    variable for each activity.
