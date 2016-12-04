#Read Me 


This readme file was created as a part of the submission for the week-4 assignment of the 'Getting and Cleaning Data' course on Coursera. 

The submission consists of the following:

* SortedSummary.txt: This contains the final tidy dataset that is to be created for the assignment. A description of the dataset is in the Codebook.md 
* run_analysis.R: This contains the scripts that need to be executed for obtaining the data file mentioned above
* Codebook.md: This file contains a description of the approach and key assumptions, a description of the final dataset and an explanation of why the dataset is tidy
* this Read Me file: Contains an overview of the script

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

Detailed comments have been provided in the script to aid execution.