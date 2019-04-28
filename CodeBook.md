## CodeBook.md ##

Source code : run_analysis.R

### Dataset ###

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Dataset description ###

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Activities ###

    WALKING (1) - The subject performed walking in the test
	WALKING_UPSTAIRS (2) - The subject performed up-stair walking in the test
	WALKING_DOWNSTAIRS (3) - Down-stair walking
	SITTING (4) - The subject was sitting in the test
	STANDING (5) - Subject performed standing action in the test
	LAYING (6) - The subject laid down in the test

### Variables collected/transformed in the tidy dataset ###
#### Time domain: ####

##### Body Acceleration - X,Y,Z: #####

"Time-BodyAcceleration-Mean-X","Time-BodyAcceleration-Mean-Y","Time-BodyAcceleration-Mean-Z",

"Time-BodyAcceleration-StandardDeviation-X","Time-BodyAcceleration-StandardDeviation-Y","Time-BodyAcceleration-StandardDeviation-Z",

##### Gravity Acceleration - X,Y,Z: #####

"Time-GravityAcceleration-Mean-X","Time-GravityAcceleration-Mean-Y","Time-GravityAcceleration-Mean-Z",

"Time-GravityAcceleration-StandardDeviation-X","Time-GravityAcceleration-StandardDeviation-Y","Time-GravityAcceleration-StandardDeviation-Z",

##### Body Acceleration Jerk - X,Y,Z: #####

"Time-BodyAcceleration-JerkMean-X","Time-BodyAcceleration-JerkMean-Y","Time-BodyAcceleration-JerkMean-Z",

"Time-BodyAcceleration-JerkStandardDeviation-X","Time-BodyAcceleration-JerkStandardDeviation-Y","Time-BodyAcceleration-JerkStandardDeviation-Z",

##### Body Gyroscope - X,Y,Z: #####

"Time-BodyGyroscope-Mean-X","Time-BodyGyroscope-Mean-Y","Time-BodyGyroscope-Mean-Z",

"Time-BodyGyroscope-StandardDeviation-X","Time-BodyGyroscope-StandardDeviation-Y","Time-BodyGyroscope-StandardDeviation-Z",

##### Body Gyroscope Jerk - X,Y,Z: #####

"Time-BodyGyroscope-JerkMean-X","Time-BodyGyroscope-JerkMean-Y","Time-BodyGyroscope-JerkMean-Z",

"Time-BodyGyroscope-JerkStandardDeviation-X","Time-BodyGyroscope-JerkStandardDeviation-Y","Time-BodyGyroscope-JerkStandardDeviation-Z",

##### Magnitude: #####

"Time-BodyAcceleration-Magnitude-Mean","Time-BodyAcceleration-Magnitude-StandardDeviation",

"Time-GravityAcceleration-Magnitude-Mean","Time-GravityAcceleration-Magnitude-StandardDeviation",

"Time-BodyAcceleration-JerkMagnitude-Mean","Time-BodyAcceleration-JerkMagnitude-StandardDeviation",

"Time-BodyGyroscope-Magnitude-Mean","Time-BodyGyroscope-Magnitude-StandardDeviation",

"Time-BodyGyroscope-JerkMagnitude-Mean","Time-BodyGyroscope-JerkMagnitude-StandardDeviation"


#### Frequency Domain: ####

##### Body Acceleration - X,Y,Z: #####

"FrequencyDomain-BodyAcceleration-Mean-X","FrequencyDomain-BodyAcceleration-Mean-Y","FrequencyDomain-BodyAcceleration-Mean-Z",

"FrequencyDomain-BodyAcceleration-StandardDeviation-X","FrequencyDomain-BodyAcceleration-StandardDeviation-Y","FrequencyDomain-BodyAcceleration-StandardDeviation-Z",

"FrequencyDomain-BodyAcceleration-JerkMean-X","FrequencyDomain-BodyAcceleration-JerkMean-Y","FrequencyDomain-BodyAcceleration-JerkMean-Z",

"FrequencyDomain-BodyAcceleration-JerkStandardDeviation-X","FrequencyDomain-BodyAcceleration-JerkStandardDeviation-Y","FrequencyDomain-BodyAcceleration-JerkStandardDeviation-Z",

"FrequencyDomain-BodyGyroscope-Mean-X","FrequencyDomain-BodyGyroscope-Mean-Y","FrequencyDomain-BodyGyroscope-Mean-Z",

##### Body Gyroscope - X,Y,Z: #####

"FrequencyDomain-BodyGyroscope-StandardDeviation-X","FrequencyDomain-BodyGyroscope-StandardDeviation-Y","FrequencyDomain-BodyGyroscope-StandardDeviation-Z",

##### Magnitude: #####

"FrequencyDomain-BodyAcceleration-Magnitude-Mean","FrequencyDomain-BodyAcceleration-Magnitude-StandardDeviation"

"FrequencyDomain-BodyAcceleration-JerkMagnitude-Mean","FrequencyDomain-BodyAcceleration-JerkMagnitude-StandardDeviation"

"FrequencyDomain-BodyGyroscope-Magnitude-Mean","FrequencyDomain-BodyGyroscope-Magnitude-StandardDeviation"

"FrequencyDomain-BodyGyroscope-JerkMagnitude-Mean","FrequencyDomain-BodyGyroscope-JerkMagnitude-StandardDeviation"

## The following are steps performed in run_analysis.R script ##

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

### 1. Merges the training and the test sets to create one data set ###

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

Now we have the merged dataset like this:

    >str(merged_dataset)
    'data.frame':	10299 obs. of  563 variables:
     $ subject                             : int  1 1 1 1 1 1 1 1 1 1 ...
     $ activity                            : int  5 5 5 5 5 5 5 5 5 5 ...
     $ tBodyAcc-mean()-X                   : num  0.289 0.278 0.28 0.279 0.277 ...
     $ tBodyAcc-mean()-Y                   : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
     $ tBodyAcc-mean()-Z                   : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
     $ tBodyAcc-std()-X                    : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
     $ tBodyAcc-std()-Y                    : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
     $ tBodyAcc-std()-Z                    : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
     $ tBodyAcc-mad()-X                    : num  -0.995 -0.999 -0.997 -0.997 -0.998 ...
     $ tBodyAcc-mad()-Y                    : num  -0.983 -0.975 -0.964 -0.983 -0.98 ...
     $ tBodyAcc-mad()-Z                    : num  -0.924 -0.958 -0.977 -0.989 -0.99 ...
     $ tBodyAcc-max()-X                    : num  -0.935 -0.943 -0.939 -0.939 -0.942 ...
     $ tBodyAcc-max()-Y                    : num  -0.567 -0.558 -0.558 -0.576 -0.569 ...
     $ tBodyAcc-max()-Z                    : num  -0.744 -0.818 -0.818 -0.83 -0.825 ...
     $ tBodyAcc-min()-X                    : num  0.853 0.849 0.844 0.844 0.849 ...
     ......
     
### 2. Extracts only the measurements on the mean and standard deviation for each measurement ###

The goal of this step is to create a data frame with 'subject', 'activity' and variables has 'mean' and 'std'.

    columns_mean_std <- colnames(merged_dataset)[grepl("mean|std",colnames(merged_dataset))]
    dataset_mean_std <- merged_dataset[,c('subject', 'activity', columns_mean_std)]
    
The structure of 'dataset_mean_std' looks like this:

    > str(dataset_mean_std)
    'data.frame':	10299 obs. of  81 variables:
     $ subject                        : int  1 1 1 1 1 1 1 1 1 1 ...
     $ activity                       : int  5 5 5 5 5 5 5 5 5 5 ...
     $ tBodyAcc-mean()-X              : num  0.289 0.278 0.28 0.279 0.277 ...
     $ tBodyAcc-mean()-Y              : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
     $ tBodyAcc-mean()-Z              : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
     $ tBodyAcc-std()-X               : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
     $ tBodyAcc-std()-Y               : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
     $ tBodyAcc-std()-Z               : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
     $ tGravityAcc-mean()-X           : num  0.963 0.967 0.967 0.968 0.968 ...
     $ tGravityAcc-mean()-Y           : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
     ......

### 3. Uses descriptive activity names to name the activities in the data set ###

In the data frame generated in last step, activities are numbers, they are not easy to understand. To change the activity numbers to the names, we need first read 'activity_lables.txt' into activity_names, then apply the names to dataset_mean_std.

    activity_names <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
    activity_names <- as.character(activity_names[,2])
    dataset_mean_std$activity <- activity_names[dataset_mean_std$activity]

### 4. Appropriately labels the data set with descriptive variable names ###

Variable names in 'dataset_mean_std' are not easy to understand too, we will do some string replacing.

    names(dataset_mean_std) <- gsub("^t", "Time-", names(dataset_mean_std))
    names(dataset_mean_std) <- gsub("^f", "FrequencyDomain-", names(dataset_mean_std))
    names(dataset_mean_std) <- gsub('Acc', 'Acceleration-', names(dataset_mean_std))
    names(dataset_mean_std) <- gsub('Gyro', 'Gyroscope-', names(dataset_mean_std))
    names(dataset_mean_std) <- gsub('Mag', 'Magnitude-', names(dataset_mean_std))
    names(dataset_mean_std) <- gsub('Freq[(][)]', 'Frequency', names(dataset_mean_std))
    names(dataset_mean_std) <- gsub("BodyBody", "Body", names(dataset_mean_std))
    names(dataset_mean_std) <- gsub('-mean([(][)])?', 'Mean', names(dataset_mean_std))
    names(dataset_mean_std) <- gsub('-std[(][)]', 'StandardDeviation', names(dataset_mean_std))

Our dataset looks like this now:

    > str(dataset_mean_std)
    'data.frame':	10299 obs. of  81 variables:
     $ subject                                                         : int  1 1 1 1 1 1 1 1 1 1 ...
     $ activity                                                        : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
     $ Time-BodyAcceleration-Mean-X                                    : num  0.289 0.278 0.28 0.279 0.277 ...
     $ Time-BodyAcceleration-Mean-Y                                    : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
     $ Time-BodyAcceleration-Mean-Z                                    : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
     $ Time-BodyAcceleration-StandardDeviation-X                       : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
     $ Time-BodyAcceleration-StandardDeviation-Y                       : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
     $ Time-BodyAcceleration-StandardDeviation-Z                       : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
     $ Time-GravityAcceleration-Mean-X                                 : num  0.963 0.967 0.967 0.968 0.968 ...
     $ Time-GravityAcceleration-Mean-Y                                 : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
     $ Time-GravityAcceleration-Mean-Z                                 : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
     ......

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject ###

We now have our dataset ready to do some calculations. We use 'aggregate' function here to split data into subsets, apply 'mean' to the summary returned from aggregate result. For better understanding, I also switched the column order of 'subject' and 'activity'. We name the result of this step as 'dataset_tidy'.

    dataset_tidy <- aggregate(dataset_mean_std[,3:68], by=list(activity=dataset_mean_std$activity, subject=dataset_mean_std$subject), FUN = mean)
    #Swap column order : activity and subject
    dataset_tidy <- dataset_tidy[c(names(dataset_tidy[,2:1]), names(dataset_tidy[,3:68]))]

The structure of 'dataset_tidy' looks like:

    > str(dataset_tidy)
    'data.frame':	180 obs. of  81 variables:
     $ subject                                                         : int  1 1 1 1 1 1 2 2 2 2 ...
     $ activity                                                        : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
     $ Time-BodyAcceleration-Mean-X                                    : num  0.222 0.261 0.279 0.277 0.289 ...
     $ Time-BodyAcceleration-Mean-Y                                    : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
     $ Time-BodyAcceleration-Mean-Z                                    : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
     $ Time-BodyAcceleration-StandardDeviation-X                       : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
     $ Time-BodyAcceleration-StandardDeviation-Y                       : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
     $ Time-BodyAcceleration-StandardDeviation-Z                       : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
     $ Time-GravityAcceleration-Mean-X                                 : num  -0.249 0.832 0.943 0.935 0.932 ...
     $ Time-GravityAcceleration-Mean-Y                                 : num  0.706 0.204 -0.273 -0.282 -0.267 ...
     $ Time-GravityAcceleration-Mean-Z                                 : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
     $ Time-GravityAcceleration-StandardDeviation-X                    : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
     $ Time-GravityAcceleration-StandardDeviation-Y                    : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
     $ Time-GravityAcceleration-StandardDeviation-Z                    : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
     $ Time-BodyAcceleration-JerkMean-X                                : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
     $ Time-BodyAcceleration-JerkMean-Y                                : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
     $ Time-BodyAcceleration-JerkMean-Z                                : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
     $ Time-BodyAcceleration-JerkStandardDeviation-X                   : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
     $ Time-BodyAcceleration-JerkStandardDeviation-Y                   : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
     
The result is written to 'dataset_tidy.csv' file as output.

    write.csv(dataset_tidy, './dataset_tidy.csv')


Thanks



