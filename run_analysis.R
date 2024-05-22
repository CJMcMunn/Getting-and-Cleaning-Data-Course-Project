library(data.table)
library(dplyr)
setwd("~/Documents")

## Reading files and Creating Data Sets ##

subjectTrain <- read.table("~/Downloads/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
Y_Train <- read.table("~/Downloads/UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_Train <- read.table("~/Downloads/UCI HAR Dataset/train/X_train.txt", header = FALSE)

subjectTest <- read.table("~/Downloads/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
Y_Test <- read.table("~/Downloads/UCI HAR Dataset/test/y_test.txt", header = FALSE)
X_Test <- read.table("~/Downloads/UCI HAR Dataset/test/X_test.txt", header = FALSE)

features <- read.table("~/Downloads/UCI HAR Dataset/features.txt")
activityLabels <- read.table("~/Downloads/UCI HAR Dataset/activity_labels.txt", header = FALSE)
colnames(activityLabels) <- c("activityID", "activityType")

## Name columns ##

colnames(X_Train) <- features[, 2]
colnames(Y_Train) <- "activityID"
colnames(subjectTrain) <- "subjectID"

colnames(X_Test) <- features[, 2]
colnames(Y_Test) <- "activityID"
colnames(subjectTest) <- "subjectID"

## Merge data ##

allTrain <- cbind(Y_Train, subjectTrain, X_Train)
allTest <- cbind(Y_Test, subjectTest, X_Test)
finaldata <- rbind(allTrain, allTest)

## Pull only mean and STD data ##

mean_and_std <- grepl("activityID|subjectID|mean\\(\\)|std\\(\\)", colnames(finaldata))
MeanandStd_data <- finaldata[, mean_and_std]

## Uses descriptive activity names to name the activities in the data set ##

ActivityNames_data <- merge(MeanandStd_data, activityLabels, by = "activityID", all.x = TRUE)

## Appropriately labels the data set with descriptive variable names. ##

colnames(ActivityNames_data) <- gsub("^t", "time", colnames(ActivityNames_data))
colnames(ActivityNames_data) <- gsub("^f", "frequency", colnames(ActivityNames_data))
colnames(ActivityNames_data) <- gsub("Acc", "Accelerometer", colnames(ActivityNames_data))
colnames(ActivityNames_data) <- gsub("Gyro", "Gyroscope", colnames(ActivityNames_data))
colnames(ActivityNames_data) <- gsub("Mag", "Magnitude", colnames(ActivityNames_data))
colnames(ActivityNames_data) <- gsub("BodyBody", "Body", colnames(ActivityNames_data))


## creates a second, independent tidy data set with the average of each variable for each activity and each subject ##
tidy_data <- ActivityNames_data %>%
  group_by(subjectID, activityID, activityType) %>%
  summarise_all(mean)

## Writing tidy data into a txt file ##
write.table(tidy_data, "tidySet.txt", row.names = FALSE)


