#### IMPORTANT  if you want to keep your wd at a specific place 
####substitute ~ by your specific path i.e (D:/R/Coursera) where data are located



## First step: Reading Data into Environment

features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"")
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt", header=F, quote="\"")
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt", header=F, quote="\"")
x_test <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"")
x_train <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"")

## Second step: Present summary of data and check homogeneity of data
table(y_test)
table(y_train)
ncol(x_test)
ncol(x_train)
nrow(features)
nrow(x_test)+nrow(x_train)
nrow(subject_test)+nrow(subject_train)

## Third Step: Substitute the activity labels code by descriptive names
##  Task 1 transform activity labels factors into char 
alchar<- data.frame(lapply(activity_labels, as.character), stringsAsFactors=FALSE)
##  Task 2 transform codes into names
for (i in 1:6){
  y_test$V1[which(y_test$V1==i)]<-alchar[i,2]
  y_train$V1[which(y_train$V1==i)]<-alchar[i,2]
}

## Fourth Step Combine  vars and introduce names
x_both<-rbind(x_test,x_train)
y_both<-rbind(y_test,y_train)
names(x_both)<-features[,2]
names(y_both)<-"Activities"
names(subject_test)<-"Subject"
names(subject_train)<-"Subject"
subject_both<-rbind(subject_test,subject_train)
names(subject_both)<-"Subject"
combidata<-cbind(x_both,y_both,subject_both)

## Fifth Step: Create new dataframe with the desired results
combmean<-aggregate(combidata,list(combidata[,562],combidata[,563]),mean)

## Sixth Step present Data
View(combmean)

