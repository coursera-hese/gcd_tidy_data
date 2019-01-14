# Code-Book

## Introduction

The original data-sets were cleaned and prepared to finally get two tidy data-sets described below.
A detailled description of the single processing steps is found in the comments of 'run_analysis.R'.

## Original data ('Dataset.zip')

### Short description
[Copied from README.txt of the Dataset.zip]
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


### Data description (external link)

URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Download link

URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Size: Approx. 60 MB

### The dataset includes the following files

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


## Processing & Tidy data

### Processing steps (overview)

The R code for the single steps were included in 'run_analysis.R'. This is an overview about the steps:

1. Downloading an extracting the input-data ("Dataset.zip")
2. Reading the data for "Subject", "X" and "Y" for test- and train-data-sets.
3. Filter the measurement-columns in the "X" data-sets with column-names containing "mean()" or "std()". There are 66 of them.
4. Combine the columns for "Subject", "X" and "Y" to one data-set for test- and train-data each. This gives 68 columns.
5. Append the rows of train-data to the test-data.
6. Replace the activity-Id with the activity-names.
7. for the grouped data-set only: group subject and activity and summarize the measurement with the average function (`mean`).
8. Tidy data (see below)

### Tidy data

The column-name of the original data-set were prepared to get tidy data:
- '(' and ')' removed from names
- names converted to lower-case

Unnamed columns get descriptive names (e.g. 'subject', 'activity').


## Final data-sets

The final data-sets contain the subject-Ids, their activity and measurement-data from the sensors (either all the measurements or in condensed/grouped form).

### Columns

#### Subject & Activity columns

- "subject": integer that identifies the individual subjects. [Column-type `integer` in the range=[1:30]]
- "activity" : the activity executed by the subject (see 'Activity values'). [Column-type = `factor`, 6 different levels]

#### Measurement columns

From the original data only the measurements with 'mean()' or 'std()' in the (original-)name were taken. The following 66 columns were included in the final data-sets. More information on the measurements can be found in the original data-set documentation.
All the columns contain `numeric` data in the range [-1.0; 1.0].

- "tbodyacc-mean-x", "tbodyacc-mean-y", "tbodyacc-mean-z"          
- "tbodyacc-std-x", "tbodyacc-std-y", "tbodyacc-std-z"
- "tgravityacc-mean-x", "tgravityacc-mean-y", "tgravityacc-mean-z"
- "tgravityacc-std-x", "tgravityacc-std-y", "tgravityacc-std-z"
- "tbodyaccjerk-mean-x", "tbodyaccjerk-mean-y", "tbodyaccjerk-mean-z"
- "tbodyaccjerk-std-x", "tbodyaccjerk-std-y", "tbodyaccjerk-std-z"       
- "tbodygyro-mean-x", "tbodygyro-mean-y", "tbodygyro-mean-z"
- "tbodygyro-std-x", "tbodygyro-std-y", "tbodygyro-std-z"
- "tbodygyrojerk-mean-x", "tbodygyrojerk-mean-y", "tbodygyrojerk-mean-z"
- "tbodygyrojerk-std-x", "tbodygyrojerk-std-y", "tbodygyrojerk-std-z"
- "tbodyaccmag-mean"
- "tbodyaccmag-std"
- "tgravityaccmag-mean"      
- "tgravityaccmag-std"
- "tbodyaccjerkmag-mean"
- "tbodyaccjerkmag-std"
- "tbodygyromag-mean"
- "tbodygyromag-std"         
- "tbodygyrojerkmag-mean"
- "tbodygyrojerkmag-std"
- "fbodyacc-mean-x", "fbodyacc-mean-y", "fbodyacc-mean-z"
- "fbodyacc-std-x", "fbodyacc-std-y", "fbodyacc-std-z"
- "fbodyaccjerk-mean-x", "fbodyaccjerk-mean-y", "fbodyaccjerk-mean-z"
- "fbodyaccjerk-std-x", "fbodyaccjerk-std-y", "fbodyaccjerk-std-z"
- "fbodygyro-mean-x", "fbodygyro-mean-y", "fbodygyro-mean-z"
- "fbodygyro-std-x", "fbodygyro-std-y", "fbodygyro-std-z"
- "fbodyaccmag-mean"
- "fbodyaccmag-std"
- "fbodybodyaccjerkmag-mean"
- "fbodybodyaccjerkmag-std"
- "fbodybodygyromag-mean"    
- "fbodybodygyromag-std"
- "fbodybodygyrojerkmag-mean"
- "fbodybodygyrojerkmag-std"

### 'Activity' values

Activity could be one of the following six values:

- LAYING
- SITTING
- STANDING
- WALKING 
- WALKING_DOWNSTAIRS
- WALKING_UPSTAIRS


### Data-set `df`

This data-set contains the subject-Ids, their activity and the mean- and standard-deviation-measurements from the sensors.

Columns:

- subject [type = "integer", range=[1:30]]: integer that identifies the individual subjects
- activity [type = "factor", 6 different levels]: the activity executed by the subject, either: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
- columns 3 to 68 [type = "numeric", range = [-1.0:1.0]]: normalized sensor measurement-data


### Data-set `dfGrouped`

This is the grouped version of `df`, where 'subject' and 'activity' is grouped and the average is computed for each non-grouped column (all the sensor-data).

Columns:

- subject [type = "integer", range=[1:30]]: integer that identifies the individual subjects
- activity [type = "factor", 6 different levels]: the activity executed by the subject, either: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
- columns 3 to 68 [type = "numeric", range = [-1.0:1.0]]: the average of the grouped measurement-data

