#File name : run_analysis.R
#Purpose : Assignment for 'Course 3 : Getting and Cleaning Data' Week 4
#Date : April/27/2019
#Author : yuanb

library(dplyr)

### Download dataset file and unzip it.
if (!dir.exists('UCI HAR Dataset')) {
  if (!file.exists('getdata_projectfiles_UCI HAR Dataset.zip')) {
    message('Downloading dataset... ')
    download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 
                  destfile = 'getdata_projectfiles_UCI HAR Dataset.zip', quiet = TRUE)
  }
  
  unzip('getdata_projectfiles_UCI HAR Dataset.zip')
  message('Dataset file is unzipped... ')
} else
{
  message('"Dataset folder found, skip downloading...')
}

message('1. Merges the training and the test sets to create one data set.')

#read feature names table
features <- read.table('./UCI HAR Dataset/features.txt', header = FALSE)

subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt', header = FALSE) %>% setNames(c('subject'))
y_train <- read.table('./UCI HAR Dataset/train/Y_Train.txt', header = FALSE) %>% setNames(c('activity'))
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt', header = FALSE) %>% setNames(features[,2])

subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt', header = FALSE) %>% setNames(c('subject'))
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt', header = FALSE) %>% setNames(c('activity'))
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt', header = FALSE) %>% setNames(features[,2])

# create training dataset by combining subject #, activity # and training data
training_dataset <- cbind(subject_train, y_train, x_train)

# create test dataset by combining subject #, activity # and testing data
test_dataset <- cbind(subject_test, y_test, x_test)

#merge training_dataset and test_dataset
merged_dataset <- rbind(training_dataset,test_dataset)

message('2. Extracts only the measurements on the mean and standard deviation for each measurement.')
columns_mean_std <- colnames(merged_dataset)[grepl("mean|std",colnames(merged_dataset))]
dataset_mean_std <-merged_dataset[,c('subject', 'activity', columns_mean_std)]

message('3. Uses descriptive activity names to name the activities in the data set.')
activity_names <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity_names <- as.character(activity_names[,2])
dataset_mean_std$activity <- activity_names[dataset_mean_std$activity]

message('4. Appropriately labels the data set with descriptive variable names.')
names(dataset_mean_std) <- gsub("^t", "Time-", names(dataset_mean_std))
names(dataset_mean_std) <- gsub("^f", "FrequencyDomain-", names(dataset_mean_std))
names(dataset_mean_std) <- gsub('Acc', 'Acceleration-', names(dataset_mean_std))
names(dataset_mean_std) <- gsub('Gyro', 'Gyroscope-', names(dataset_mean_std))
names(dataset_mean_std) <- gsub('Mag', 'Magnitude-', names(dataset_mean_std))
names(dataset_mean_std) <- gsub('Freq[(][)]', 'Frequency', names(dataset_mean_std))
names(dataset_mean_std) <- gsub("BodyBody", "Body", names(dataset_mean_std))
names(dataset_mean_std) <- gsub('-mean([(][)])?', 'Mean', names(dataset_mean_std))
names(dataset_mean_std) <- gsub('-std[(][)]', 'StandardDeviation', names(dataset_mean_std))


message('5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable')
message('   for each activity and each subject.')
dataset_tidy <- aggregate(dataset_mean_std[,3:81], by=list(activity=dataset_mean_std$activity, subject=dataset_mean_std$subject), FUN = mean)
#Swap column order : activity and subject
dataset_tidy <- dataset_tidy[c(names(dataset_tidy[,2:1]), names(dataset_tidy[,3:81]))]

write.csv(dataset_tidy, './dataset_tidy.csv')


message('End of run_analysis.R.')

