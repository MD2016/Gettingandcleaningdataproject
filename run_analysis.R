run_analysis<-function(x){
  ##load dplyr
  ##library(dplyr)
  
  ##read the data
  subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
  x_test<-read.table("UCI HAR Dataset/test/x_test.txt")
  y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
  features<-read.table("UCI HAR Dataset/features.txt")
  activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
  
  subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
  x_train<-read.table("UCI HAR Dataset/train/x_train.txt")
  y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
  

  ##drop irrelevant columns
  
  ##x_test<-x_test[,grep("mean\\(\\) | std\\(\\)", features$V2)]
  ##x_train<-x_train[,grep("mean\\(\\) | std\\(\\)", features$V2)]
  
  ##combine train and test
  subject_combined<-rbind(subject_test,subject_train)
  x_combined<-rbind(x_test,x_train)
  y_combined<-rbind(y_test,y_train)
  
  ##name columns
  colnames(y_combined)<-c("activitylabel")
  colnames(x_combined)<-features$V2
  colnames(subject_combined)<-c("subject")
  
  ##drop irrelevant columns
  x_combined<-x_combined[,grep("mean\\(\\)|std\\(\\)", features$V2)]

  ##create one dataset as the answer to step 4 in the assignment
  step4<-cbind(subject_combined,y_combined,x_combined)
  
  ##name activities
  step4$activitylabel<-factor(step4$activitylabel,levels=activity_labels$V1,labels=activity_labels$V2)
  ##Step 4 completed!!
  
  
  ##create another tidy data set according to Step 5 of the assignment
  step5<- summarise_each(group_by(step4, subject, activitylabel),funs(mean))
  
  ##rename columns appropriately
  colnames(step5)[-(1:2)]<-paste("Average of", colnames(step5)[-(1:2)])
  
  ##return dataset
  step5
  
  
  
}