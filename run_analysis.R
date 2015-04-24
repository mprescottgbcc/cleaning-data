#load all libraries needed throughout
#library(reshape2)
library(dplyr)

#combine subject files to provide one of the record identifiers
subject <- as.character(c(
  read.table('./UCI HAR Dataset/test/subject_test.txt')[,'V1'],
  read.table('./UCI HAR Dataset/train/subject_train.txt')[,'V1']
))

#similarly combine the activity codes found in the y_test.txt and the y_train.txt files
y_codes <- as.character(c(
  read.table('./UCI HAR Dataset/test/y_test.txt')[,'V1'],
  read.table('./UCI HAR Dataset/train/y_train.txt')[,'V1']
))

#get the activity labels from the activity_labels.txt file. These labels will replace the y_codes
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt',colClasses='character')

#put the x test and train data together
#x <- merge(read.table('./UCI HAR Dataset/test/X_test.txt'),read.table('./UCI HAR Dataset/train/X_train.txt'),all=TRUE)

#features.txt contains the names of the variables represented by each column of the X data
#Set these as the column names of the x data frame
#names(x) <- read.table('./UCI HAR Dataset/features.txt',colClasses='character')[,'V2']

#there are duplicates of columns that are not needed in the final data set, so remove them to make
#using the dplyr select method possible
x <- x[ !duplicated(names(x)) ]
x <- select(x,contains('mean()'),contains('std()'))
