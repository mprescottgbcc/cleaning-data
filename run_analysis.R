#load the dplyr package to easily work with the merged data frame to create the final tidy data set
library(dplyr)

#combine subject files to provide one of the record identifiers
subject <- c(
  read.table('./UCI HAR Dataset/test/subject_test.txt')[,'V1'],
  read.table('./UCI HAR Dataset/train/subject_train.txt')[,'V1']
)

#similarly combine the activity codes found in the y_test.txt and the y_train.txt files
activity <- as.character(c(
  read.table('./UCI HAR Dataset/test/y_test.txt')[,'V1'],
  read.table('./UCI HAR Dataset/train/y_train.txt')[,'V1']
))

#get the activity labels from the activity_labels.txt file. These labels will replace the codes in the activity vector
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt',colClasses='character')

#convert each activity code into an activity label
for(i in 1:length(activity)) {
  activity[i] <- activity_labels[activity[i],'V2']
}

#clear out activity labels and counter variable to save memory
remove(i)
remove(activity_labels)

#put the x test and train data together
x <- merge(read.table('./UCI HAR Dataset/test/X_test.txt'),read.table('./UCI HAR Dataset/train/X_train.txt'),all=TRUE)

#features.txt contains the names of the variables represented by each column of the X data
#Set these as the column names of the x data frame
names(x) <- read.table('./UCI HAR Dataset/features.txt',colClasses='character')[,'V2']

#there are duplicates of columns that are not needed in the final data set, so remove them to make
#using the dplyr select method possible
x <- x[ !duplicated(names(x)) ]
x <- select(x,contains('mean()'),contains('std()'))

#Bind the columns of subject, activity and the x data frame to create the tidy data frame.
#Clean up the column names to remove the parentheses to make use of the summarize function possible
tidy <- cbind(subject,activity,x)
names(tidy) <- sapply(
  strsplit(names(tidy),'()',fixed=TRUE),
  function(x){ if(is.na(x[2])) x[2]=''; paste(x[1],x[2],sep='') }
)

#remove subject, activity and x now that they are bound together in the tidy data
remove(activity)
remove(subject)
remove(x)

#Group the data by subject and activity and find the means for the non-grouped columns.
tidy <- group_by(tidy, subject,activity)
tidy <- summarise_each(tidy, funs(mean))

#Finally, write the tidy data to a text file in the tidy directory
if(!file.exists("tidy")){ dir.create("tidy") }
write.table(tidy,"tidy/data.txt",row.names=FALSE)
