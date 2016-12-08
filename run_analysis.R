## This script uses the UCI HAR Dataset to create a tidy dataset of summary data for mean and standard deviation features from the orginal dataset. 
## Specifically, the following steps are being performed:
## 1. Training and test datasets are merged into a dataset called alldata.df
## 2. Mean and Standard deviation measures are extracted from alldata.df to meanstd.df
## 3. The names of columns and activity labels within the "Activity' column is then made more meaningful 
## 4. The data is then grouped by Activity and Subject into a new dataset 'by_actsub'
## 5. A dataset that averages the features by groups of Activity and Subject is created 
## 6. A final dataset 'summary_sorted.df is created by sorting the summary.df by Activity and Subject


# Set the working directory as "UCI HAR Dataset"
# This assumes the original data is extracted as a sub folder in the current working directory
setwd("UCI HAR Dataset")
# Extract feature names into a data. To be used for column names of later datasets
features.dt <- read.table("features.txt")

## Get the training data into a dataset training.df

setwd("train")
# Get list of subjects corresponding to observations
subjecttrain.dt <- read.table("subject_train.txt")
# Get activity list corresponding to observations
trainlabels.dt <- read.table("y_train.txt")
# Get feature names from features.dt
feature.v <- as.character(features.dt$V2)
# Create training dataset of features 
xtrain.dt <- read.table("X_train.txt", colClasses = "numeric", col.names=feature.v)
# Append Actity and Subjects to the observations dataset to get training.df
trainingwithsub.df <- cbind(Subject=subjecttrain.dt$V1,xtrain.dt)
training.df <- cbind(Activity=trainlabels.dt$V1, trainingwithsub.df)

## Get the test data into a dataset test.df

setwd("../test")
# Get list of subjects corresponding to observations
subjecttest.dt <- read.table("subject_test.txt")
# Get activity list corresponding to observations
testlabels.dt <- read.table("y_test.txt")
# Create training dataset of features 
xtest.dt <- read.table("X_test.txt", colClasses = "numeric", col.names=feature.v)
# Append Actity and Subjects to the observations dataset to get test.df
testwithsub.df <- cbind(Subject=subjecttest.dt$V1,xtest.dt) 
test.df <- cbind(Activity=testlabels.dt$V1, testwithsub.df)

## Merge training and test datasets into alldata.df

test.df <- cbind(test.df, setType="Test")
training.df <- cbind(training.df, setType="Training")
alldata.df <- rbind(training.df,test.df)

## Extract features that are either mean or standard deviation values into meanstd.df

library(dplyr)
meanstd.df <- select(alldata.df, grep("Activity|Subject|mean()|std()", names(alldata.df)))
meanstd.df <- select(meanstd.df, -(grep("meanFreq",names(meanstd.df))))

## Make activity labels more meaningful
meanstd.df$Activity[meanstd.df$Activity==1]="Walking"
meanstd.df$Activity[meanstd.df$Activity==2]="Walking Upstairs"
meanstd.df$Activity[meanstd.df$Activity==3]="Walking Downstairs"
meanstd.df$Activity[meanstd.df$Activity==4]="Sitting"
meanstd.df$Activity[meanstd.df$Activity==5]="Standing"
meanstd.df$Activity[meanstd.df$Activity==6]="Laying"

## Make column names more meaningful
names(meanstd.df) <- gsub("Acc", "Acceleration",names(meanstd.df))
names(meanstd.df) <- gsub("Mag", "Magnitude",names(meanstd.df))
names(meanstd.df) <- gsub("std", "StDev",names(meanstd.df))
names(meanstd.df) <- gsub("mean", "Mean",names(meanstd.df))
names(meanstd.df)[ grep("^t",names(meanstd.df))] <- paste0("Time",substring(names(meanstd.df)[ grep("^t",names(meanstd.df))],2))
names(meanstd.df)[ grep("^f",names(meanstd.df))] <- paste0("Freq",substring(names(meanstd.df)[ grep("^f",names(meanstd.df))],2))
names(meanstd.df) <- gsub("BodyBody", "Body",names(meanstd.df))

## Create the final dataset that averages these observations by activity and subject combinations

# Group meanstd.df  by activity and subject
byactsub.df <- group_by(meanstd.df, Activity, Subject)
# Create a new dataset that averages the observations
summary.df <- summarise_all(byactsub.df, mean)
# Step 4
sortedsummary.df <- arrange(summary.df, Activity, Subject)

##Output dataframe to text file

write.table(sortedsummary.df, "SortedSummary.txt", row.name=FALSE)