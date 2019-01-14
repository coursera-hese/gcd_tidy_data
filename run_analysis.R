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

## from data-directory
dfActivityLabels <- read.csv(paste0(dataDir, "activity_labels.txt"), header = FALSE, sep = " ", col.names = c("id", "activity"))
dfFeatures <-  read.csv(paste0(dataDir, "features.txt"), header = FALSE, sep = " ", col.names = c("id", "feature"))
## from test-directory
dfTestSub <- read.csv(paste0(testDir, "subject_test.txt"), header = FALSE, sep = " ", col.names = c("subject"))
# WRONG Attempt `read.csv` (sep=" "): reads in wrong number of columns, since it does not skip multiple whitespaces (e.g. "  ").
#dfTestX <- read.csv(paste0(testDir, "X_test.txt"), header = FALSE, sep = " ") # wrong number of columns
dfTestX <- read.table(paste0(testDir, "X_test.txt"))
dfTestY <- read.csv(paste0(testDir, "y_test.txt"), header = FALSE, sep = " ", col.names = c("activity"))
## from train-directory
dfTrainSub <- read.csv(paste0(trainDir, "subject_train.txt"), header = FALSE, sep = " ", col.names = c("subject"))
dfTrainX <- read.table(paste0(trainDir, "X_train.txt"))
dfTrainY <- read.table(paste0(trainDir, "y_train.txt"), col.names = c("activity"))
#dfTrainY <- read.csv(paste0(trainDir, "y_train.txt"), header = FALSE, sep = " ", col.names = c("activity"))

rm(tmp)
tmp <- read.table(paste0(testDir, "X_test.txt"))

# merge datasets from train- and test
#dfSubject <- merge(dfTestSub, dfTrainSub)
# TODO

#
# prepare and merge data
#

# merge data (`cbind`, `rbind` ...)
# bind columns together
dfTest <- cbind(dfTestSub, dfTestY, dfTestX)
dfTrain <- cbind(dfTrainSub, dfTrainY, dfTrainX)
# bind rows together
df <- rbind(dfTest, dfTrain)

## columns to lower-case conversion
names(df) <- tolower(names(df))

# function `activity` gets the activity-name for a given activity-Id
activity <- function(x) { dfActivityLabels[x,2] }
df$activity <- sapply(df$activity, activity)
#dfTest$activity <- sapply(dfTest$activity, activity)
#dfTrain$activity <- sapply(dfTrain$activity, activity)

