## The assignment was to create one R script called run_analysis.R that does 
## the following. 

## 1.Merges the training and the test sets to create one data set.

## 2.Extracts only the measurements on the mean and standard deviation 
## for each measurement. 

## 3.Uses descriptive activity names to name the activities in the data set

## 4.Appropriately labels the data set with descriptive variable names. 

## 5.From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.

## Assignment STEP 1: 
## Merging the training and test sets into data set

## This section is reading the data into data frames
subj_train <- read.table("C:/McD/R/UCI_HAR_Dataset/train/subject_train.txt")
subj_test <- read.table("C:/McD/R/UCI_HAR_Dataset/test/subject_test.txt")
X_train <- read.table("C:/McD/R/UCI_HAR_Dataset/train/X_train.txt")
X_test <- read.table("C:/McD/R/UCI_HAR_Dataset/test/X_test.txt")
Y_train <- read.table("C:/McD/R/UCI_HAR_Dataset/train/y_train.txt")
Y_test <- read.table("C:/McD/R/UCI_HAR_Dataset/test/y_test.txt")


## This section is adding column names for subj files
names(subj_train) <- "subjectID"
names(subj_test) <- "subjectID"


## This section is adding column names for measurement files
featureNames <- read.table("C:/McD/R/UCI_HAR_Dataset/features.txt")
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2


## This section is adding column names for label files
names(Y_train) <- "activity"
names(Y_test) <- "activity"


# This section is combining the files into a single dataset
train <- cbind(subj_train, Y_train, X_train)
test <- cbind(subj_test, Y_test, X_test)
combined <- rbind(train, test)


## Assignment STEP 2 
## Extracting only the mean and standard deviation for each measurement.

## This sectino determines which columns contain "mean()" or "std()"
meanstdcols <- grepl("mean\\(\\)", names(combined)) |
       grepl("std\\(\\)", names(combined))

## ensure that we also keep the subjectID and activity columns
meanstdcols[1:2] <- TRUE

## remove unnecessary columns
combined <- combined[, meanstdcols]

## Assignment STEPS 3 and 4
## Use descriptive activity names to name the activities and appropriately label the data set
## with descriptive variable names.

combined$activity <- factor(combined$activity, 
                            labels= c("Walking", "Walking Upstairs", 
                                      "Walking Downstairs", "Sitting", 
                                      "Standing", "Laying"))

## STEP 5: Creates a second, independent tidy data set with the
## average of each variable for each activity and each subject.
## This step assumes the rshape2 package has been installed.
## create the tidy data set

combined2 <- melt(combined, id=c("subjectID","activity"))
tidy <- dcast(combined2, subjectID+activity ~ variable, mean)

# write the tidy data set to a file
write.csv(tidy, "C:/McD/R/UCI_HAR_Dataset/tidy.csv", row.names=FALSE)​
