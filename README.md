#Getting and Cleaning Data Project based on "Human Activity Recognition Using Smartphones" data.
```
author: "Marozet"  
date: "Thursday, January 22, 2015"
```

The purpose of the project is to create a tidy dataset using data from wearable computing project "Human Activity Recognition Using Smartphones". The data is obtained from UCI MAchine Learning Repository. The link to the data is [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and a full description of the HAR project [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The original data file was downloaded using the following code.

```r
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="getdata_projectfiles_UCI_HAR_Dataset.zip",mode="wb")
date() #Exact date the file was downloaded.
```

```
## [1] "Thu Jan 22 13:03:23 2015"
```

Next the "run_analysis.R" script was run, which loaded the data and reshaped it into a tidy data set.  
The script performed the following steps:  
1. Merged the training and the test sets to create one data set.  
2. Extracted only the measurements on the mean and standard deviation for each measurement.   
3. Added descriptive activity names to name the activities in the data set  
4. Labeled the data set with descriptive variable names (saves step 4 file into "newHARData.csv" file).   
5. From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.  

```r
source("run_analysis.R")
str(summarizedData) #show the structure of the new tidy data set.
```

```
## Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	11880 obs. of  4 variables:
##  $ Subject     : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ Activity    : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ variable    : Factor w/ 66 levels "tBodyAcc-mean()-X",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ variableMean: num  0.2773 -0.0174 -0.1111 -0.2837 0.1145 ...
##  - attr(*, "vars")=List of 2
##   ..$ : symbol Subject
##   ..$ : symbol Activity
##  - attr(*, "drop")= logi TRUE
```

The resulting long form tidy data set is saved to "GetDataHARProjectTidyDataSet.txt".

###Transformations in "run_analysis.R" script explained.
First step was to load the txt files from zipped archive and merge them:
Train data:  
X_train.txt  
y_train.txt  
subject_train.txt
```
trainDataX<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/train/X_train.txt"))
trainDataY<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/train/y_train.txt"))
trainDataSubject<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/train/subject_train.txt"))
```

Merging subject number with activity(Y) and features(X) by column 
```
trainData<-cbind(trainDataSubject,trainDataY,trainDataX)
```

The same procedure was used to load and merge test data. (As can be seen in "run_analysis.R"" script). "testData" dat.frame was created.

Merging train and test data by row
```
allData<-rbind(trainData,testData)
```

I have obtained an unlabelled data set. (example of first 5 columns)

```r
head(allData[,1:5])
```

```
##       V1 V2                V3               V4                V5
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

```
#loading features labels
features<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/features.txt"))

#Add lables to the data frame
nFeatures<-nrow(features)
featuresVec <- as.character(features[,2])
featuresVec<-c("Subject","Activity",featuresVec)
names(allData)<-featuresVec
```

Activity names were added from "activity_labels.txt" file
```
#loading activity labels
activityLabels<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/activity_labels.txt"))

#add activity names
allData$Activity <- as.factor(allData$Activity)
levels(allData$Activity)<-as.character(activityLabels$V2)
rm(activityLabels)
```

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

The data set was then saved to a txt file using the following command.
```
write.table(summarizedData,row.name=FALSE,"GetDataHARProjectTidyDataSet.txt")
```
