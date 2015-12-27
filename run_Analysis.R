# run_analysis does the following:

# Merges the training & the test sets to create one dataset.
# Extracts only the measurements on the mean & SD for ea measurement. 
# Uses descr. activity names to name the activities in the dataset
# Appropriately labels the dataset w/descr. var names. 
# From the dataset in step 4, creates a 2nd, ind. tidy dataset w/ 
# the ave of ea var for ea activity & ea subj.

# See this article: http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/
# dataset came from here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# dataset is here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This is a tester line as of 7:44pm, 12/26.

run_analysis <- function() {
  
melte
# Assumes we're now in the right directory, and all's there.   
# get the variable names
features <- read.table("features.txt")
features1 <- features[,2]
rm(features) #cleanup
cat("..Got the variable names.\n")

# Load and create big training set.
cat("..Getting the training set of data.\n")
trainData <- read.table("train/X_train.txt")
names(trainData) <- features1

# load big test set
cat("..Getting the testing set of data.\n")
testData<- read.table("test/X_test.txt")
names(testData) <- features1

# merge big data sets
cat("..Merging the sets.\n")
bigSet <- rbind(trainData,testData)
rm(trainData,testData) #cleanup

# toss the ones we don't need
cat("..Loading the necessary libraries.\n")
library(stringi) # Here for "melt" purposes in data.table. Go figure.
library(data.table)
library(plyr)    #Note: load dplyr AFTER plyr, or it causes problems. Here for mapvalues()
library(dplyr)                                     

bigSet <- data.table(bigSet)
meanSet <- select(bigSet, contains("mean()")); stdSet <- select(bigSet, contains("std()"))
finalSet <- cbind(meanSet,stdSet)
rm(meanSet, stdSet, bigSet) #cleanup

# Fix the names. Tried to "%>%" using library(magrittR) etc., but it didn't work. Brute force, instead.
# Try again to pipe it, later, if there's left over time.
# delete  "-", (), t to time, f to frequency. Write out STD more. Google R naming convention. Here: https://google.github.io/styleguide/Rguide.xml
cat("..Making the names nicer.\n")
nameSet <- names(finalSet)
nameSet <- gsub("^t", "time", nameSet) 
nameSet <- gsub("^f", "freq", nameSet) 
nameSet <- gsub("BodyBody", "Body", nameSet) 
nameSet <- gsub("std\\(\\)", "StandardDev", nameSet) 
nameSet <- gsub("-", "", nameSet) 
nameSet <- gsub("mean\\(\\)", "Mean", nameSet)
names(finalSet) <- nameSet
rm(features1, nameSet)
           
# load training Subjects/Activities
cat("..Loading the Subjects/Activities.\n")
trainSubs <- read.table("train/subject_train.txt", colClasses="factor", col.names="Subject")
trainActs <- read.table("train/y_train.txt", colClasses="factor", col.names="Activity")
trainSubsActs <- cbind(trainSubs,trainActs)
rm(trainSubs, trainActs) #cleanup

# load test Subjects/Activities
testSubs <- read.table("test/subject_test.txt", colClasses="factor", col.names="Subject")
testActs <- read.table("test/y_test.txt", colClasses="factor", col.names="Activity")
testSubsActs <- cbind(testSubs, testActs)
rm(testSubs, testActs) #cleanup

# merge the 2 sets & convert the Activity levels to meaningful names
subsActs <- rbind(trainSubsActs,testSubsActs)
acts <- read.table("activity_labels.txt")
acts <- select(acts, 2)
setnames(acts, old=c("V2"), new=c("Activity")) #courtesy of data.table

levels(subsActs$Activity) <- acts$Activity
rm(trainSubsActs,testSubsActs, acts) #cleanup

# Add the subjects/activities to the large data set
cat("..Combining all the Things.\n")
finalSet <- cbind(subsActs,finalSet)
rm(subsActs) #cleanup

# Manipulate the data
cat("..Tidying the data.\n")
finalSetMelt <- melt(finalSet, id=1:2)
finalSetCast <- dcast(finalSetMelt, Subject + Activity ~ variable, fun.aggregate = mean)
finalSetCast$Subject <- as.numeric(finalSetCast$Subject)
final <- arrange(finalSetCast, Subject, Activity)

cat("..Outputting the file to \"happydata.txt\". Enjoy.\n")
write.table(final, file="../happydata.txt", row.name=FALSE)

rm(finalSet, finalSetMelt, finalSetCast)
}
