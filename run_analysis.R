
filename <- "week4FinalProject.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename )
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels<- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code","activity"))
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


## 1.Merges the training and the test sets to create one data set.

xData <- rbind(x_train, x_test)
yData <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
mergedData <- cbind(Subject, yData, xData)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
library(dplyr)

newData <- mergedData %>% select(subject, code, contains("mean"), contains("std"))


#3.Uses descriptive activity names to name the activities in the data set
newData$code <- activity_labels[newData$code, 2]

#4.Appropriately labels the data set with descriptive variable names.

names(newData)[2] = "Activity"
names(newData)<-gsub("Acc", "Accelerometer", names(newData))
names(newData)<-gsub("Gyro", "Gyroscope", names(newData))
names(newData)<-gsub("BodyBody", "Body", names(newData))
names(newData)<-gsub("Mag", "Magnitude", names(newData))
names(newData)<-gsub("^t", "Time", names(newData))
names(newData)<-gsub("^f", "Frequency", names(newData))
names(newData)<-gsub("tBody", "TimeBody",names(newData))
names(newData)<-gsub("-mean()", "Mean", names(newData), ignore.case = TRUE)
names(newData)<-gsub("-std()", "STD", names(newData), ignore.case = TRUE)
names(newData)<-gsub("-freq()", "Frequency", names(newData), ignore.case = TRUE)
names(newData)<-gsub("angle", "Angle", names(newData))
names(newData)<-gsub("gravity", "Gravity", names(newData))


#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyData<-group_by(newData,subject,Activity)
tidyData<-summarise_all(tidyData,funs(mean))
write.table(tidyData, "tidyData.txt", row.name=FALSE)

