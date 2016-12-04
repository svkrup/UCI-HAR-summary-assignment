# Code Book for Run Analysis

This document describes the run_analysis script created for the 'Getting and Cleaning Data' assignment for week-4

## Overview

This script uses the UCI HAR Dataset to create a tidy dataset of summary data for mean and standard deviation features from the orginal dataset. 

Specifically, the following steps are being performed:

* Training and test datasets are created and merged into a dataset called alldata.df
* Mean and Standard deviation measures are extracted from alldata.df to meanstd.df
* The names of columns and activity labels within the "Activity' column is then made more meaningful 
* The data is then grouped by Activity and Subject into a new dataset 'byactsub.df'
* A dataset 'summary.df' that averages the features by groups of Activity and Subject is created 
* A final dataset 'sortedsummary.df is created by sorting the summary.df by Activity and Subject
* The dataset is extracted into a text file 'SortedSummary' for submission

## Key Assumptions

* The script assumes that the zip file for the UCI HAR Dataset has been downloaded and extracted into the R working directory
* The UCI HAR Dataset can be downloaded at the following link: 
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* All the features described in features.txt are obtained from a single observation

### Selecting Mean and Standard Deviation measures

The intent of the assignment is to summarize features which are Mean and Standard Deviation measures of the raw data. 
The run_analysis program inteprets this to select only features that end with "mean()" or "std()"
Hence, any raw data measures that start with "mean" are not considered as candidates for the final dataset

## Description of the data set

The dataset contains 68 variables and 180 observations. The 180 observations describe average values for 30 subjects across 6 activities.The variables observered are:

### Grouping elements (2 variables)

* Activity: consisting of 6 types of activities
* Subject: consisting of 30 different subjects who perform each of the 6 activities

The rest of the variables are grouped by these 2 variables 

###Time measures (40 variables):

* Grouped averages of mean and standard deviations for body acceleration, along X,Y,Z axes (6 variables)
* Grouped averages of mean and standard deviations for gravity acceleration, along X,Y,Z axes (6 variables)
* Grouped averages of mean and standard deviations for body jerk acceleration, along X,Y,Z axes (6 variables)
* Grouped averages of mean and standard deviations for body gyro acceleration, along X,Y,Z axes (6 variables)
* Grouped averages of mean and standard deviations for body gyro jerk acceleration, along X,Y,Z axes (6 variables)
* Grouped averages of mean and standard deviations for the magnitudes of all the above vectors (10 variables)


###Frequency measures (26 variables):

* Grouped averages of mean and standard deviations for body acceleration, along X,Y,Z axes (6 variables)
* Grouped averages of mean and standard deviations for body jerk acceleration, along X,Y,Z axes (6 variables)
* Grouped averages of mean and standard deviations for body gyro acceleration, along X,Y,Z axes (6 variables)
* Grouped averages of mean and standard deviations for the magnitudes of all the above vectors (6 variables)
* Grouped averages of mean and standard deviations for the magnitudes of gyro jerk (2 variables)
	 

## Why is this a tidy data set?	 

###Each column represents a single variable
 
This is evident from the description of the variables in the above section. For instance, we could have created a 'dimension' variable and stored 'X', 'Y'  and 'Z' as possible values of that variable. That would have allowed us to melt the X,Y,Z variables of a certain feature (e.g.: AvgTimeBodyAcceleration.Mean...X, AvgTimeBodyAcceleration.Mean...Y, AvgTimeBodyAcceleration.Mean...Z)  into a single variable (e.g.: AvgTimeBodyAcceleration.Mean...). We have not done this because we assume that all variables above represent atomic elements of the same observation (please see the 3rd key assumption above. By melting, we would have split the data of a single observation across multiple rows, violating tidy dataset principles

###Each row represents a complete observation

The resultant data set has 180 rows, representing the exact combination of 6 activities and 30 subjects. Each row has a unique combination of activity and subject. Hence, we can conclude that observations are not split across rows

###Each type of observational unit forms a table
The table represents a subset of the 560 variables collected in the original exercise. It does not contain data other than this experiment.
