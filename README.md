## Week 4 project

Files in this repo are for the Week 4 assignment of Getting and cleaning data course on Coursera.

README.md - This file  
CodeBook.md - Describes the variables, the data, and any transformations or work performed to clean up the data  
run_analysis.R - Project R script does the following:   

It first download the project dataset, then perform the following steps, details are documented in CodeBook.md. Please follow CodeBook.md for R script programming details.

1. Merges the training and the test sets to create one data set.

Result from this step is saved in 'merged_dataset' variable.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

Result from this step is saved in 'dataset_mean_std' variable.

3. Uses descriptive activity names to name the activities in the data set.

Result from this step is still in 'dataset_mean_std', but activity names are applied.

4. Appropriately labels the data set with descriptive variable names.

Result from this step is still in 'dataset_mean_std' variable, variable names are change. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The independent tidy data set is 'dataset_tidy', the result is saved in 'dataset_tidy.txt' file in current folder as requested.

Thanks
