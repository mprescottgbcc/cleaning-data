# Getting and Cleaning Data Course Project
The purpose of this project is to demonstrate the creation of a tidy data set as defined by [Hadley Wickham](http://http://had.co.nz) in [his paper on the subject](http://vita.had.co.nz/papers/tidy-data.pdf).

## Background
The analysis required for this project involves the use of data gathered from wearable computers, specifically Samsung Galaxy S smartphones. The study involved 30 subjects, with the individuals split into training and test groups. Measurements were taken while each subject performed six different activities (laying, sitting, standing, walking, walking upstairs, and walking downstairs). A full description of the study can be found on the [UCI Machine Learning web site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The official dataset can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## The Project Requirements
The project goal is to create one R script called run_analysis.R that does the following (quoted from the course project requirements page in the official Coursera course):

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set. These names come from the activity_labels.txt file found in the official data set folder._

4. Appropriately labels the data set with descriptive variable names. The variable names have been extracted and adjusted from the features.txt file found in the official data set folder.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each mean and standard deviation variable for each activity and each subject.


## How to Run the Analysis Script
The run_analysis.R script file contained within this project repository has been designed to satisfy the requirements as outlined in the Project Requirements above. The following steps must be executed in order for the analysis script to run successfully:

1. The UCI HAR Dataset must be download (see the link above) and extracted into the same directory as the run_analysis.R script file.

2. The directory containing the run_analysis.R script file must have file write permissions for the R interpreter.

3. The dplyr package for R must be installed before running the script

4. Upon successful completion of the script, the tidy data will be written to a plain text file in a directory named "tidy"

