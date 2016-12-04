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

setwd("C:/Users/krupakar_singampally/Documents/UCI HAR Dataset/test")
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
# Due to the length of column names, this has been done as a 4 step process:
# 1. Create dataset that summarizes the first 54 observations
# 2. Create another dataset that summarizes the rest of the 14 observations
# 3. Merge both datasets into the summary.df  
# 4. Create final dataset sortedsummary.df that is sorted by activity and subject
summary.df1 <- summarize(byactsub.df , AvgTimeBodyAcceleration.Mean...X= mean(TimeBodyAcceleration.Mean...X), AvgTimeBodyAcceleration.Mean...Y= mean(TimeBodyAcceleration.Mean...Y), AvgTimeBodyAcceleration.Mean...Z= mean(TimeBodyAcceleration.Mean...Z), AvgTimeBodyAcceleration.StDev...X= mean(TimeBodyAcceleration.StDev...X), AvgTimeBodyAcceleration.StDev...Y= mean(TimeBodyAcceleration.StDev...Y), AvgTimeBodyAcceleration.StDev...Z= mean(TimeBodyAcceleration.StDev...Z), AvgTimeGravityAcceleration.Mean...X= mean(TimeGravityAcceleration.Mean...X), AvgTimeGravityAcceleration.Mean...Y= mean(TimeGravityAcceleration.Mean...Y), AvgTimeGravityAcceleration.Mean...Z= mean(TimeGravityAcceleration.Mean...Z), AvgTimeGravityAcceleration.StDev...X= mean(TimeGravityAcceleration.StDev...X), AvgTimeGravityAcceleration.StDev...Y= mean(TimeGravityAcceleration.StDev...Y), AvgTimeGravityAcceleration.StDev...Z= mean(TimeGravityAcceleration.StDev...Z), AvgTimeBodyAccelerationJerk.Mean...X= mean(TimeBodyAccelerationJerk.Mean...X), AvgTimeBodyAccelerationJerk.Mean...Y= mean(TimeBodyAccelerationJerk.Mean...Y), AvgTimeBodyAccelerationJerk.Mean...Z= mean(TimeBodyAccelerationJerk.Mean...Z), AvgTimeBodyAccelerationJerk.StDev...X= mean(TimeBodyAccelerationJerk.StDev...X), AvgTimeBodyAccelerationJerk.StDev...Y= mean(TimeBodyAccelerationJerk.StDev...Y), AvgTimeBodyAccelerationJerk.StDev...Z= mean(TimeBodyAccelerationJerk.StDev...Z), AvgTimeBodyGyro.Mean...X= mean(TimeBodyGyro.Mean...X), AvgTimeBodyGyro.Mean...Y= mean(TimeBodyGyro.Mean...Y), AvgTimeBodyGyro.Mean...Z= mean(TimeBodyGyro.Mean...Z), AvgTimeBodyGyro.StDev...X= mean(TimeBodyGyro.StDev...X), AvgTimeBodyGyro.StDev...Y= mean(TimeBodyGyro.StDev...Y), AvgTimeBodyGyro.StDev...Z= mean(TimeBodyGyro.StDev...Z), AvgTimeBodyGyroJerk.Mean...X= mean(TimeBodyGyroJerk.Mean...X), AvgTimeBodyGyroJerk.Mean...Y= mean(TimeBodyGyroJerk.Mean...Y), AvgTimeBodyGyroJerk.Mean...Z= mean(TimeBodyGyroJerk.Mean...Z), AvgTimeBodyGyroJerk.StDev...X= mean(TimeBodyGyroJerk.StDev...X), AvgTimeBodyGyroJerk.StDev...Y= mean(TimeBodyGyroJerk.StDev...Y), AvgTimeBodyGyroJerk.StDev...Z= mean(TimeBodyGyroJerk.StDev...Z), AvgTimeBodyAccelerationMagnitude.Mean..= mean(TimeBodyAccelerationMagnitude.Mean..), AvgTimeBodyAccelerationMagnitude.StDev..= mean(TimeBodyAccelerationMagnitude.StDev..),  AvgTimeGravityAccelerationMagnitude.Mean..= mean(TimeGravityAccelerationMagnitude.Mean..), AvgTimeGravityAccelerationMagnitude.StDev..= mean(TimeGravityAccelerationMagnitude.StDev..), AvgTimeBodyAccelerationJerkMagnitude.Mean..= mean(TimeBodyAccelerationJerkMagnitude.Mean..),  AvgTimeBodyAccelerationJerkMagnitude.StDev..= mean(TimeBodyAccelerationJerkMagnitude.StDev..), AvgTimeBodyGyroMagnitude.Mean..= mean(TimeBodyGyroMagnitude.Mean..), AvgTimeBodyGyroMagnitude.StDev..= mean(TimeBodyGyroMagnitude.StDev..), AvgTimeBodyGyroJerkMagnitude.Mean..= mean(TimeBodyGyroJerkMagnitude.Mean..), AvgTimeBodyGyroJerkMagnitude.StDev..= mean(TimeBodyGyroJerkMagnitude.StDev..), AvgFreqBodyAcceleration.Mean...X= mean(FreqBodyAcceleration.Mean...X), AvgFreqBodyAcceleration.Mean...Y= mean(FreqBodyAcceleration.Mean...Y), AvgFreqBodyAcceleration.Mean...Z= mean(FreqBodyAcceleration.Mean...Z), AvgFreqBodyAcceleration.StDev...X= mean(FreqBodyAcceleration.StDev...X), AvgFreqBodyAcceleration.StDev...Y= mean(FreqBodyAcceleration.StDev...Y), AvgFreqBodyAcceleration.StDev...Z= mean(FreqBodyAcceleration.StDev...Z), AvgFreqBodyAccelerationJerk.Mean...X= mean(FreqBodyAccelerationJerk.Mean...X), AvgFreqBodyAccelerationJerk.Mean...Y= mean(FreqBodyAccelerationJerk.Mean...Y), AvgFreqBodyAccelerationJerk.Mean...Z= mean(FreqBodyAccelerationJerk.Mean...Z), AvgFreqBodyAccelerationJerk.StDev...X= mean(FreqBodyAccelerationJerk.StDev...X), AvgFreqBodyAccelerationJerk.StDev...Y= mean(FreqBodyAccelerationJerk.StDev...Y),AvgFreqBodyAccelerationJerk.StDev...Z= mean(FreqBodyAccelerationJerk.StDev...Z))
# Step 2
summary.df2 <- summarize(byactsub.df, AvgFreqBodyGyro.Mean...X= mean(FreqBodyGyro.Mean...X), AvgFreqBodyGyro.Mean...Y= mean(FreqBodyGyro.Mean...Y), AvgFreqBodyGyro.Mean...Z= mean(FreqBodyGyro.Mean...Z), AvgFreqBodyGyro.StDev...X= mean(FreqBodyGyro.StDev...X), AvgFreqBodyGyro.StDev...Y= mean(FreqBodyGyro.StDev...Y), AvgFreqBodyGyro.StDev...Z= mean(FreqBodyGyro.StDev...Z), AvgFreqBodyAccelerationMagnitude.Mean..= mean(FreqBodyAccelerationMagnitude.Mean..), AvgFreqBodyAccelerationMagnitude.StDev..= mean(FreqBodyAccelerationMagnitude.StDev..), AvgFreqBodyAccelerationJerkMagnitude.Mean..= mean(FreqBodyAccelerationJerkMagnitude.Mean..), AvgFreqBodyAccelerationJerkMagnitude.StDev..= mean(FreqBodyAccelerationJerkMagnitude.StDev..), AvgFreqBodyGyroMagnitude.Mean..= mean(FreqBodyGyroMagnitude.Mean..), AvgFreqBodyGyroMagnitude.StDev..= mean(FreqBodyGyroMagnitude.StDev..), AvgFreqBodyGyroJerkMagnitude.Mean..= mean(FreqBodyGyroJerkMagnitude.Mean..), AvgFreqBodyGyroJerkMagnitude.StDev..= mean(FreqBodyGyroJerkMagnitude.StDev..))
# Step 3
summary.df <- merge(summary.df1, summary.df2, by=c("Activity", "Subject"))
# Step 4
sortedsummary.df <- arrange(summary.df, Activity, Subject)

##Output dataframe to tesxt file
write.table(sortedsummary.df, "SortedSummary")