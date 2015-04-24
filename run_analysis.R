#Course Project for "Getting and Cleaning Data" Course
#Offered by Johns Hopkins University, Bloomberg School of Public Health
#Student Name: Margaret Prescott
#Course Start Date: 2015-04-06
#Please refer to the README.md file included with this script for more information

#load the dplyr package to easily work with the merged data frame to create the final tidy data set
library(dplyr)

#Set the base directory for where the data and related files live
base_dir <- './UCI HAR Dataset'
data_files <- vector()
data_files['subject_test'] <- paste(base_dir,'/test/subject_test.txt',sep='')
data_files['subject_train'] <- paste(base_dir,'/train/subject_train.txt',sep='')
data_files['activity_labels'] <- paste(base_dir,'/activity_labels.txt',sep='')
data_files['y_test'] <- paste(base_dir,'/test/y_test.txt',sep='')
data_files['y_train'] <- paste(base_dir,'/train/y_train.txt',sep='')
data_files['x_test'] <- paste(base_dir,'/test/X_test.txt',sep='')
data_files['x_train'] <- paste(base_dir,'/train/X_train.txt',sep='')
data_files['features'] <- paste(base_dir,'/features.txt',sep='')
remove(base_dir)

#Check to make sure all data files are where they need to be. If any data file is missing, stop the script
for(fil in data_files) {
  if(!file.exists(fil)) {
    stop(paste('Error:', fil, 'does not exist'))
  }
}

remove(fil)

#Data files are ready, so let's get on with it!
#Combine subject files to gather the subject identifiers
subject <- c(
  read.table(data_files['subject_test'])[,'V1'],
  read.table(data_files['subject_train'])[,'V1']
)

#similarly combine the activity codes found in the y_test.txt and the y_train.txt files
activity <- as.character(c(
  read.table(data_files['y_test'])[,'V1'],
  read.table(data_files['y_train'])[,'V1']
))

#get the activity labels from the activity labels file. These labels will replace the codes in the activity vector
labels <- read.table(data_files['activity_labels'],colClasses='character')

#convert each activity code into an activity label
for(i in 1:length(activity)) {
  activity[i] <- labels[activity[i],'V2']
}

#clear out activity labels and counter variable to save memory
remove(i)
remove(labels)

#put the x test and train data together
x <- merge(
  read.table(data_files['x_test']),
  read.table(data_files['x_train']),
  all=TRUE)

#The features file contains the names of the variables represented by each column of the X data
#Set these as the column names of the x data frame
names(x) <- read.table(data_files['features'],colClasses='character')[,'V2']

#there are duplicates of columns that are not needed in the final data set, so remove them to make
#using the dplyr select method possible
x <- x[ !duplicated(names(x)) ]
x <- select(x,contains('mean()'),contains('std()'))

#Bind the columns of subject, activity and the x data frame to create the tidy data frame.
#Clean up the column names to remove the parentheses to make column names a little nicer
tidy <- cbind(subject,activity,x)
names(tidy) <- sapply(
  strsplit(names(tidy),'()',fixed=TRUE),
  function(x){ if(is.na(x[2])) x[2]=''; paste(x[1],x[2],sep='') }
)

#remove subject, activity, data_files and x now that all data binding is complete
remove(activity)
remove(subject)
remove(data_files)
remove(x)

#Group the data by subject and activity and find the means for the non-grouped columns.
tidy <- group_by(tidy, subject,activity)
tidy <- summarise_each(tidy, funs(mean))

#Finally, write the tidy data to a text file in the tidy directory
if(!file.exists("tidy")){ dir.create("tidy") }
write.table(tidy,"tidy/data.txt",row.names=FALSE)
