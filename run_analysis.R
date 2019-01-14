#
# 'Getting and Cleaning Data', Week 4, Peer-Assignment
#

# Getting the dataset
if (!file.exists("./data")) { dir.create("./data") }
# Download the original dataset
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data/Dataset.zip")

# Unzip the file with external tool (e.g. 7-Zip)

#
# reading the data
#
dataDir <- "./data/UCI HAR Dataset/"
testDir <- paste0(dataDir, "test/")
trainDir <- paste0(dataDir, "train/")

## WRONG Attempt `read.csv` (sep=" "): reads in wrong number of columns, since it does not skip multiple whitespaces (e.g. "  ").
##     Used `read.table` to fix this problem.
# dfTestX <- read.csv(paste0(testDir, "X_test.txt"), header = FALSE, sep = " ") # wrong number of columns

## from data-directory
#dfActivityLabels <- read.csv(paste0(dataDir, "activity_labels.txt"), header = FALSE, sep = " ", col.names = c("id", "activity"))
#dfFeatures <-  read.csv(paste0(dataDir, "features.txt"), header = FALSE, sep = " ", col.names = c("id", "feature"))
dfActivityLabels <- read.table(paste0(dataDir, "activity_labels.txt"), col.names = c("id", "activity"))
dfFeatures <-  read.table(paste0(dataDir, "features.txt"), col.names = c("id", "feature"))

## from test-directory
dfTestSub <- read.table(paste0(testDir, "subject_test.txt"), col.names = c("subject"))
dfTestX <- read.table(paste0(testDir, "X_test.txt"))
dfTestY <- read.table(paste0(testDir, "y_test.txt"), col.names = c("activity"))
## from train-directory
dfTrainSub <- read.table(paste0(trainDir, "subject_train.txt"), col.names = c("subject"))
dfTrainX <- read.table(paste0(trainDir, "X_train.txt"))
dfTrainY <- read.table(paste0(trainDir, "y_train.txt"), col.names = c("activity"))
#dfTestY <- read.csv(paste0(testDir, "y_test.txt"), header = FALSE, sep = " ", col.names = c("activity"))
#dfTrainY <- read.csv(paste0(trainDir, "y_train.txt"), header = FALSE, sep = " ", col.names = c("activity"))


#
# prepare and merge data
#

# filter features
# filter 'features' with regexp to find all columns containing 'mean()' and 'std()' in the name
featureFilter <- grepl("(mean\\(\\)|std\\(\\))", dfFeatures[,2])
columnIndex <- dfFeatures[featureFilter,1]
columnNames <- dfFeatures[featureFilter,2]
# filter by the calculated column-index
dfTestX <- dfTestX[,columnIndex]
dfTrainX <- dfTrainX[,columnIndex]
# rename columns
names(dfTestX) <- columnNames
names(dfTrainX) <- columnNames

# merge data (`cbind`, `rbind` ...)
# append columns from Subject, TestY and TestX (bind columns together)
dfTest <- cbind(dfTestSub, dfTestY, dfTestX)
dfTrain <- cbind(dfTrainSub, dfTrainY, dfTrainX)
# merge datasets test and train (bind rows together)
df <- rbind(dfTest, dfTrain)

## columns to lower-case conversion
names(df) <- tolower(names(df))
names(df) <- gsub("\\(\\)", "", names(df))

# function `activity` gets the activity-name for a given activity-Id
activity <- function(x) { dfActivityLabels[x,2] }
df$activity <- sapply(df$activity, activity)


#
# 5) Second dataset with the average of each variable for each activity and each subject (`dfGrouped`).
#
# use package `dplyr` for `group_by` and `summarize_all`
library(dplyr)

dfGrouped <- df %>% 
  group_by(subject, activity) %>% 
  summarize_all(mean)

## Alternative solution (without pipelining):
# groupedData <- group_by(df, subject, activity)
# dfGrouped <- summarize_all(groupedData, mean)

# information on the datasets
print(paste("df (columns x rows):", ncol(df), "x", nrow(df)))
print(object.size(df), units="Mb")

print(paste("dfGrouped (columns x rows):", ncol(dfGrouped), "x", nrow(dfGrouped)))
print(object.size(dfGrouped), units="Mb")
