## Read Training and Test data including all 3 files in the directory but not from the Inertial/subdirectory 
xTrain <- read.table("./train/X_train.txt")
subjectTrain <- read.table("./train/subject_train.txt")
yTrain <- read.table("./train/y_train.txt")

xTest <- read.table("./test/X_test.txt")
subjectTest <- read.table("./test/subject_test.txt")
yTest <- read.table("./test/y_test.txt")
## Note: all files read as separate data frames 

## Step 1
##  Since these are independent rows (feature vectors), the merge is really like a concatenate achieved via rbind 
xMerged <- rbind(xTrain,xTest)

## Similarly rbind the activity IDs, in the same order  
yMerged <- rbind(yTrain,yTest)

## read feature names - and use those as column names for the data set 
features <- read.table("./features.txt",stringsAsFactors = FALSE)
colnames(xMerged) <- features[,2]

## Combine the activity ID into the data set/ data frame. Note yMerged is a dataframe; just take the first column 
xMerged$activityID <- yMerged$V1

## Need plyr package to get the activity labels into the dataframe w/o changing the order (using join). I could also use left_join from dplyr  
library(plyr)

## Read the activity Labels (6 of them) and name the columns with matching names so as to apply join 
activityLabelNames <- read.table("./activity_labels.txt")
colnames(activityLabelNames) <- c("activityID","activityName")

## use left join to attach using activity ID as the column to join on
finalFullData <- join(xMerged,activityLabelNames,by="activityID",type = "left")
subjectMerged <- c(subjectTrain$V1,subjectTest$V1)
finalFullData$subject <- subjectMerged

## Using grep to find the columns that contain mean or std in the labels and add the 3 ID columns 
columnsKept <- c("activityID","activityName","subject",grep("std()", names(xMerged), value = TRUE),grep("mean()", names(xMerged), value = TRUE))
smallSet <- finalFullData[,columnsKept]

## Now for step#5,calculate a second, independent tidy data set with the average of each variable for each activity and each subject.

## make activityID into a factor and subject as a factor too. Did i need to do it? not necessary 
smallSet$subject <- factor(smallSet$subject)
smallSet$activityID <- factor(smallSet$activityID)

## Now to summarize, load dplyr and use the group_by to group the pivots and then get mean on all variables  
library(dplyr)

finalResult <- smallSet %>% group_by(activityID,subject,activityName) %>% summarise_all(funs(mean))

## Rename columns to add the "avg" indicating it is the average of the variables 
colnames(finalResult) <- c("activityID","subject","activityName", paste("Avg", colnames(finalResult[,4:82]), sep = "_"))

write.table(finalResult,file = "./summaries.txt")
