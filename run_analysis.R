#--------------------------
# run_analysis.R by Marozet
# 2015.01.22
# -------------------------
# This script loads the HAR data and creates a tidy data set
# with only mean and standard deviation.
# -------------------------

toggleLoad <- TRUE # toglle load to save time if correct version is already loaded

if (toggleLoad) {
    # loading train data from zip
    trainDataX<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/train/X_train.txt"))
    trainDataY<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/train/y_train.txt"))
    trainDataSubject<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/train/subject_train.txt"))

    #merging features(X) with activity(Y)
    trainData<-cbind(trainDataSubject,trainDataY,trainDataX)

    # loading train data from zip
    testDataX<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/test/X_test.txt"))
    testDataY<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/test/y_test.txt"))
    testDataSubject<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/test/subject_test.txt"))

    #merging features(X) with activity(Y)
    testData<-cbind(testDataSubject,testDataY,testDataX)

# --------- Point 1 ----------------
    
    #merging train and test data
    allData<-rbind(trainData,testData)

    #removing objects
    rm(trainDataX,trainDataY,trainDataSubject,testDataX,testDataY,testDataSubject,trainData,testData)
}

# --------- Point 4 ----------------
#loading features labels
features<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/features.txt"))

#Add lables to the data frame
nFeatures<-nrow(features)
featuresVec <- as.character(features[,2])
featuresVec<-c("Subject","Activity",featuresVec)
names(allData)<-featuresVec
rm(features)

# --------- Point 3 ---------------
#loading activity labels
activityLabels<-read.table(unz("getdata_projectfiles_UCI_HAR_Dataset.zip","UCI HAR Dataset/activity_labels.txt"))

#add activity names
allData$Activity <- as.factor(allData$Activity)
levels(allData$Activity)<-as.character(activityLabels$V2)
rm(activityLabels)

# --------- Point 2 ---------------
#extract mean and standard deviation
newData <- allData[,grepl("Subject|Activity|mean\\(|std",names(allData))]
write.csv(newData,"newHarData.csv")

#---------- Point 5 ---------------
# Reshape data to create a data set with average or each variable for each activity and each subject
library(reshape2)
newDataMelt<-melt(newData,id=c("Subject","Activity"),measure.vars=names(newData[,3:(ncol(newData))]))
library(dplyr)

#create a long form tidy data set
groupData<-group_by(newDataMelt,Subject,Activity,variable)
summarizedData<-summarize(groupData,variableMean=mean(value))
write.table(summarizedData,row.name=FALSE,"GetDataHARProjectTidyDataSet.txt")
