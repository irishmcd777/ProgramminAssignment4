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

## This section is combining the files into a single dataset
train <- cbind(subj_train, Y_train, X_train)
test <- cbind(subj_test, Y_test, X_test)
combined <- rbind(train, test)

## This sectino determines which columns contain "mean()" or "std()"
meanstdcols <- grepl("mean\\(\\)", names(combined)) |
       grepl("std\\(\\)", names(combined))

meanstdcols[1:2] <- TRUE

## remove unnecessary columns
combined <- combined[, meanstdcols]

## Use descriptive activity names to name the activities and appropriately label the data set
## with descriptive variable names.
combined$activity <- factor(combined$activity, 
                            labels= c("Walking", "Walking Upstairs", 
                                      "Walking Downstairs", "Sitting", 
                                      "Standing", "Laying"))

## create the tidy data set

combined2 <- melt(combined, id=c("subjectID","activity"))
tidy <- dcast(combined2, subjectID+activity ~ variable, mean)

# write the tidy data set to a file
write.csv(tidy, "C:/McD/R/UCI_HAR_Dataset/tidy.csv", row.names=FALSE)