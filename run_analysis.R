
#Download file
temp <- tempfile()
download.file(url= "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",method = "curl", destfile=temp)
#Unzip file
unzip(temp)
unzip(temp,list=TRUE)
unlink(temp)


#1. TODO merge data
#read data files X and Y
raw_x_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt" , skip = 0, header = FALSE)
raw_x_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt" , skip = 0, header = FALSE)
raw_y_train <- read.csv(file="UCI HAR Dataset/train/y_train.txt" , sep=" ", header=FALSE)
raw_y_test <- read.csv(file="UCI HAR Dataset/test/y_test.txt" , sep=" ", header=FALSE)
raw_subject_train <- read.csv(file="UCI HAR Dataset/train/subject_train.txt" , sep=" ", header=FALSE)
raw_subject_test <- read.csv(file="UCI HAR Dataset/test/subject_test.txt" , sep=" ", header=FALSE)
# and merge
raw_x <- rbind(raw_x_train,raw_x_test)
raw_y <- rbind(raw_y_train,raw_y_test)
raw_subject <- rbind(raw_subject_train,raw_subject_test)

#4. TODO descriptive variable names
raw_features <- read.csv(file = "./UCI HAR Dataset/features.txt",sep=" ",header=FALSE);

#explaining names in x file
names(raw_x) <- raw_features[[2]]


#2. TODO measurements on the mean and standard deviation for each measurement
library(dplyr)
target_measures <- c(grep(x = names(raw_x),pattern = "mean\\(\\)"),grep(x = names(raw_x),pattern = "std\\(\\)"))
tidyData <- raw_x[,target_measures]

#3. TODO descriptive activity names 

raw_activities <- read.csv(file = "./UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE)
#to preserve order
raw_y$seq<- sequence(length(raw_y$V1))
mergeY <- merge(x=raw_activities,y=raw_y)
tidyY <- mergeY[sort.list(mergeY$seq),1:2]
names(tidyY) <- c("activitId","activityDescription")

#Creating new tidyData with all data/variables
tidyData$subjectId <- raw_subject[[1]]
tidyData$activityDescription <- tidyY$activityDescription
#Now we have all select variables with mean and std and the subject and activity identification in the same dataframe

#5. TODO new tidy_data_set with the average of each variable for each activity and each subject
#group by activity and subject. calculate mean(avg)
library(reshape2)

meltedData <- melt(data = tidyData, id=c("subjectId","activityDescription"))
tidyData2 <- summarise(.data = group_by (meltedData,subjectId,activityDescription,variable),mean(value))
#And back to all columns
tidyData2Cols <- dcast(data = tidyData2, subjectId + activityDescription ~ variable)
dim(tidyData2Cols)

# save to disk
write.table(x = tidyData2Cols, file = "export_data.txt", sep=" ", row.names = F)


#length(unique(raw_subject[[1]])) = 30 different subjects
#length(names(tidyData))-2 = 66 different variables (mean and std)
#length(unique(raw_activities[[2]])) = 6 different activities
#total observations for tidyData2 = 30*66*6 = 11880
#Or a dataframe with 66 medition cols (+2 for activity and subject) and 180 obs (30*6)
