# ds-cleaning-data-project
## Project submission for Getting and Cleaning Data course 

This assignment uses the course provided data (Human Activity Recognition Using Smartphones Dataset) and goes through the steps of

1. Combining the training and test datasets 
2. Appropriately naming the variables(columns) and rows (adding subject and activityID & name).
3. Creating a subset of the data that has just the std and mean variables 
4. And then creating a tidy data set from the last step that contains the averages for each variable, each activity type, and each subject 

The submission includes the following files 
1. ReadMe file (this file) explaining the approach and the assignment 
2. Run_analysis.R which contains the script that can be run to get the desired results 
3. summaries.txt - the final data set as required by the assignment requirements and as specified above 
4. codebook extension. Extends the existing codebook by providing additional information about the variables. Note this must be used in conjunction with the original codebook for the input data 

Notes on the script 
1. The columns selected for the subset dataset are any columns with "mean" or "std" in the column label. 
2. Even though the assignment does not require both the numerical ID of the activity and the activity name to be there, i left both in it for ease of checking and for ease of readability.  
3. I added the original column names from the features.txt file available in the input data set.  For labeling the variables in the final data file, i prefixed "Avg_" to the original column names so as to retain the previous reference to the variables along with the meaning that it is now the average of those variables  

To run the script, you must download the input data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and make sure that the working directory is set to the downloaded dataset. downloading the files is not part of the script. 

The script writes the final output to a file "summaries.txt" in the working directory. 
