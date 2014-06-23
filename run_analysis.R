#########################DOWNLOAD#########################(line 1)
###Downloading and unzipping files###(line 2)
download.file('http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',dest=paste(getwd(),'/files.zip',sep='')) 
unzip(paste(getwd(),'/files.zip',sep=''))
###Getting labeling data sets###(line 5)
activity=read.table('./UCI HAR Dataset/activity_labels.txt')
features=read.table('./UCI HAR Dataset/features.txt')


#########################TEST#########################(line 10)
###Getting required data sets###(line 11)
test_subj=read.table('./UCI HAR Dataset/test/subject_test.txt') 
test_act=read.table('./UCI HAR Dataset/test/Y_test.txt') 
test_set=read.table('./UCI HAR Dataset/test/X_test.txt')
test_comb=cbind(test_subj,test_act,test_set)
###Naming variables and activities###(line 16)
colnames(test_comb)[1] = 'Subject ID'
colnames(test_comb)[2] = 'Activity'
colnames(test_comb)[3:(length(features[,2])+2)] = as.vector(features[,2])
for(i in 1:length(activity[,2])){
	test_comb[test_comb$Activity == i,2] <- as.vector(activity[i,2])
}
###Extracting only mean and std variables###(line 23)
test_final=test_comb[,c(1,2,grep(c('mean|Mean|std'),names(test_comb)))]


#########################TRAIN#########################(line 27)
###Getting required data sets###(line 28)
train_subj=read.table('./UCI HAR Dataset/train/subject_train.txt')
train_act=read.table('./UCI HAR Dataset/train/Y_train.txt')
train_set=read.table('./UCI HAR Dataset/train/X_train.txt')
train_comb=cbind(train_subj,train_act,train_set)
###Naming variables and activities###(line 33)
colnames(train_comb)[1] = 'Subject ID'
colnames(train_comb)[2] = 'Activity'
colnames(train_comb)[3:(length(features[,2])+2)] = as.vector(features[,2])
for(i in 1:length(activity[,2])){
	train_comb[train_comb$Activity == i,2] <- as.vector(activity[i,2])
}
###Extracting only mean and std variables###(line 40)
train_final=train_comb[,c(1,2,grep(c('mean|Mean|std'),names(train_comb)))]


#########################MERGING AND FINAL DATA SET#########################(line 44)
###Merging data sets###(line 45)
merged=rbind(test_final,train_final)
###Sorting by Subject ID and Activity###(line 47)
sorted=merged[order(merged[,1],merged[,2]),] 
###Collapsing sorted data by Subject ID & Activity###(line 49)
collapsed=aggregate(sorted[3:length(sorted[1,])],as.list(sorted[1:2]),mean)
###Sorting by Subject ID and Activity Again###(line 51)
final_product=collapsed[order(collapsed[,1],collapsed[,2]),] 


#########################EXPORT AND FINAL TOUCHES#########################(line 55)
###Exporting to .txt file into working directory###(line 56)
write.table(final_product,file='./tidy_data.txt')