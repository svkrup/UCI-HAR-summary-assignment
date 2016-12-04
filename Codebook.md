# Code Book for Run Analysis

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
 
This is evident from the description of the variables in the above section. For instance, we could have created a 'dimension' variable and stored 'X', 'Y'  and 'Z' as possible values of that variable. That would have allowed us to melt the X,Y,Z variables of a certain feature (e.g.: AvgTimeBodyAcceleration.Mean...X, AvgTimeBodyAcceleration.Mean...Y, AvgTimeBodyAcceleration.Mean...Z)  into a single variable (e.g.: AvgTimeBodyAcceleration.Mean...). We have not done this because we assume that all variables above represent atomic elements of the same observation (please see the 3rd key assumption in the Read Me file. By melting, we would have split the data of a single observation across multiple rows, violating tidy dataset principles

###Each row represents a complete observation

The resultant data set has 180 rows, representing the exact combination of 6 activities and 30 subjects. Each row has a unique combination of activity and subject. Hence, we can conclude that observations are not split across rows

###Each type of observational unit forms a table
The table represents a subset of the 560 variables collected in the original exercise. It does not contain data other than this experiment.
