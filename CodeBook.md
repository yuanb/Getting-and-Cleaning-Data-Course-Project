# CodeBook.md

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable comput~ing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Source code : run_analysis.R

### Download dataset ###

In this section, the code checks if folder 'UCI HAR Dataset' exist, if not, it downloads dataset file from given url and unzip it. 

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

### Merges the training and the test sets to create one data set ###

The first step is to read features.txt from dataset folder into a variable named features.

    features <- read.table('./UCI HAR Dataset/features.txt', header = FALSE)

The code then read training and test data tables into named variables.

    subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt', header = FALSE) %>% setNames(c('subject'))
    y_train <- read.table('./UCI HAR Dataset/train/Y_Train.txt', header = FALSE) %>% setNames(c('activity'))
    x_train <- read.table('./UCI HAR Dataset/train/X_train.txt', header = FALSE) %>% setNames(features[,2])
    
    subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt', header = FALSE) %>% setNames(c('subject'))
    y_test <- read.table('./UCI HAR Dataset/test/y_test.txt', header = FALSE) %>% setNames(c('activity'))
    x_test <- read.table('./UCI HAR Dataset/test/X_test.txt', header = FALSE) %>% setNames(features[,2])

Next, training dataset and test dataset data frames are created using cbind function.

    training_dataset <- cbind(subject_train, y_train, x_train)
    test_dataset <- cbind(subject_test, y_test, x_test)

After the 2 datasets are ready, I used rbind to concatinate them together.

    merged_dataset <- rbind(training_dataset,test_dataset)

