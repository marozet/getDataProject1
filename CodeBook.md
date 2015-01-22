---
title: "CodeBook for Getting and Cleaning Data Project"
author: "Marozet"
date: "Thursday, January 22, 2015"
output: html_document
---
##CodeBook for Getting and Cleaning Data Project

###Data file name: GetDataHARProjectTidyDataSet.txt

The purpose of the project is to create a tidy dataset using data from wearable computing project "Human Activity Recognition Using Smartphones". The data is obtained from UCI MAchine Learning Repository. The link to the data is [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and a full description of the HAR project [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

###Data example
```
## Source: local data frame [6 x 4]
## Groups: Subject, Activity
## 
##   Subject Activity          variable variableMean
## 1       1  WALKING tBodyAcc-mean()-X   0.27733076
## 2       1  WALKING tBodyAcc-mean()-Y  -0.01738382
## 3       1  WALKING tBodyAcc-mean()-Z  -0.11114810
## 4       1  WALKING  tBodyAcc-std()-X  -0.28374026
## 5       1  WALKING  tBodyAcc-std()-Y   0.11446134
## 6       1  WALKING  tBodyAcc-std()-Z  -0.26002790
```



##Data description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

This data set presents only Mean and Standard Deviation for each measurement.

 
    

##Columns

####Subject
description: Subject number, meaning the number of the volunteer within an age bracket of 19-48 years
type: integer
range: 1:30

####Activity
description: Performed activity name  
type: Factor with 6 levels  
Levels:  
1 - WALKING  
2 - WALKING_UPSTAIRS  
3 - WALKING_DOWNSTAIRS  
4 - SITTING  
5 - STANDING  
6 - LAYING  

####variable
description: Name of the variable for measurement.  
type: Factor with 66 levels  
Levels:  
1   - tBodyAcc-mean()-X            
2    - tBodyAcc-mean()-Y            
3	- tBodyAcc-mean()-Z            
4	- tBodyAcc-std()-X             
5	- tBodyAcc-std()-Y             
6	- tBodyAcc-std()-Z             
7	- tGravityAcc-mean()-X         
8	- tGravityAcc-mean()-Y         
9	- tGravityAcc-mean()-Z         
10	- tGravityAcc-std()-X          
11	- tGravityAcc-std()-Y          
12	- tGravityAcc-std()-Z          
13	- tBodyAccJerk-mean()-X        
14	- tBodyAccJerk-mean()-Y        
15	- tBodyAccJerk-mean()-Z        
16	- tBodyAccJerk-std()-X         
17	- tBodyAccJerk-std()-Y         
18	- tBodyAccJerk-std()-Z         
19	- tBodyGyro-mean()-X           
20	- tBodyGyro-mean()-Y           
21	- tBodyGyro-mean()-Z           
22	- tBodyGyro-std()-X            
23	- tBodyGyro-std()-Y            
24	- tBodyGyro-std()-Z            
25	- tBodyGyroJerk-mean()-X       
26	- tBodyGyroJerk-mean()-Y       
27	- tBodyGyroJerk-mean()-Z       
28	- tBodyGyroJerk-std()-X        
29	- tBodyGyroJerk-std()-Y        
30	- tBodyGyroJerk-std()-Z        
31	- tBodyAccMag-mean()           
32	- tBodyAccMag-std()            
33	- tGravityAccMag-mean()        
34	- tGravityAccMag-std()         
35	- tBodyAccJerkMag-mean()       
36	- tBodyAccJerkMag-std()        
37	- tBodyGyroMag-mean()          
38	- tBodyGyroMag-std()           
39	- tBodyGyroJerkMag-mean()      
40	- tBodyGyroJerkMag-std()       
41	- fBodyAcc-mean()-X            
42	- fBodyAcc-mean()-Y            
43	- fBodyAcc-mean()-Z            
44	- fBodyAcc-std()-X             
45	- fBodyAcc-std()-Y             
46	- fBodyAcc-std()-Z             
47	- fBodyAccJerk-mean()-X        
48	- fBodyAccJerk-mean()-Y        
49	- fBodyAccJerk-mean()-Z        
50	- fBodyAccJerk-std()-X         
51	- fBodyAccJerk-std()-Y         
52	- fBodyAccJerk-std()-Z         
53	- fBodyGyro-mean()-X           
54	- fBodyGyro-mean()-Y           
55	- fBodyGyro-mean()-Z           
56	- fBodyGyro-std()-X            
57	- fBodyGyro-std()-Y            
58	- fBodyGyro-std()-Z            
59	- fBodyAccMag-mean()           
60	- fBodyAccMag-std()            
61	- fBodyBodyAccJerkMag-mean()   
62	- fBodyBodyAccJerkMag-std()    
63	- fBodyBodyGyroMag-mean()      
64	- fBodyBodyGyroMag-std()       
65	- fBodyBodyGyroJerkMag-mean()  
66	- fBodyBodyGyroJerkMag-std() 

####variableMean
description: Calculated average of the variable for each activity and each subject  
type: Numeric

###Note on variable units
prefix 't' in the variable name denotes time  
prefix 'f' in the variable name indicate frequency domain signals). 


###Transformations in "run_analysis.R" script explained.
First step was to load the txt files from zipped archive and merge them:
(For more information look into README.md)

After merging train and test data by row, I have obtained an unlabelled data set. (example of first 5 columns)

```r
head(allData[,1:5])
```

```
##        V1       V2                V3                V4                V5
## 1       1 STANDING         0.2885845       -0.02029417        -0.1329051
## 2       1 STANDING         0.2784188       -0.01641057        -0.1235202
## 3       1 STANDING         0.2796531       -0.01946716        -0.1134617
## 4       1 STANDING         0.2791739       -0.02620065        -0.1232826
## 5       1 STANDING         0.2766288       -0.01656965        -0.1153619
## 6       1 STANDING         0.2771988       -0.01009785        -0.1051373
```

```r
nrow(allData) #number of rows
```
```
## [1] 10299
```
```r
ncol(allData) #number of columns
```
```
## [1] 563
```

Feature labels were taken from the "features.txt"" file and applied to the data.frame.
Activity names were added from "activity_labels.txt" file
(for more details please look into README.md)

In the next step I have extracted only the columns that correspond to mean and standard deviation of the measurements. "Subject" and "Activity" were also included.
```
newData <- allData[,grepl("Subject|Activity|mean\\(|std",names(allData))]
```

I have obtained the following data structure. (The below example only shows first 5 out of 68 columns of the data. "Subject", "Activity", and 66 columns with extracted measurements)

```r
head(newData[,1:5])
```
```
##   Subject Activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
## 1       1 STANDING         0.2885845       -0.02029417        -0.1329051
## 2       1 STANDING         0.2784188       -0.01641057        -0.1235202
## 3       1 STANDING         0.2796531       -0.01946716        -0.1134617
## 4       1 STANDING         0.2791739       -0.02620065        -0.1232826
## 5       1 STANDING         0.2766288       -0.01656965        -0.1153619
## 6       1 STANDING         0.2771988       -0.01009785        -0.1051373
```

```r
nrow(newData) #number of rows
```
```
## [1] 10299
```
```r
ncol(newData) #number of columns
```
```
## [1] 68
```

Data was restructured into "newDataMelt". All values were copied into one column "value" and the corresponding variable name is in column "variable"
```
library(reshape2)
newDataMelt<-melt(newData,id=c("Subject","Activity"),measure.vars=names(newData[,3:(ncol(newData))]))
```
```r
head(newDataMelt)
```
```
##   Subject Activity          variable     value
## 1       1 STANDING tBodyAcc-mean()-X 0.2885845
## 2       1 STANDING tBodyAcc-mean()-X 0.2784188
## 3       1 STANDING tBodyAcc-mean()-X 0.2796531
## 4       1 STANDING tBodyAcc-mean()-X 0.2791739
## 5       1 STANDING tBodyAcc-mean()-X 0.2766288
## 6       1 STANDING tBodyAcc-mean()-X 0.2771988
```

New data was then grouped by Subject and Activity, and summarized using mean function.

```r
library(dplyr)

#create a long form tidy data set
groupData<-group_by(newDataMelt,Subject,Activity,variable)
summarizedData<-summarize(groupData,variableMean=mean(value))
head(summarizedData)
```

Resulting data
```
## Source: local data frame [6 x 4]
## Groups: Subject, Activity
## 
##   Subject Activity          variable variableMean
## 1       1  WALKING tBodyAcc-mean()-X   0.27733076
## 2       1  WALKING tBodyAcc-mean()-Y  -0.01738382
## 3       1  WALKING tBodyAcc-mean()-Z  -0.11114810
## 4       1  WALKING  tBodyAcc-std()-X  -0.28374026
## 5       1  WALKING  tBodyAcc-std()-Y   0.11446134
## 6       1  WALKING  tBodyAcc-std()-Z  -0.26002790
```
