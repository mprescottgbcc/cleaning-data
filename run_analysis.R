#load all libraries needed throughout
library(reshape2)

#combine subject files to provide one of the record identifiers
subject <- c(
  read.table('./UCI HAR Dataset/test/subject_test.txt')[,'V1'],
  read.table('./UCI HAR Dataset/train/subject_train.txt')[,'V1']
)

#similarly combine the activity codes found in the y_test.txt and the y_train.txt files
y_codes <- c(
  read.table('./UCI HAR Dataset/test/y_test.txt')[,'V1'],
  read.table('./UCI HAR Dataset/train/y_train.txt')[,'V1']
)
