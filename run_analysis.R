## Getting and Cleaning Data Week ##
## Week 4 assignment              ##
## File Name - run_analysis.R     ##
## Author - Amit Kumar Das        ##

###########################################################################################

file_path <- file.path("./data", "UCI_HAR_Dataset")
list.files(file_path, recursive = TRUE)

#################################Data Reading #############################################
### Read training data. X_train, Y_train & Subject_train ######

x_train <- read.table(file.path(file_path, "train", "X_train.txt"), header = F)
y_train <- read.table(file.path(file_path, "train", "y_train.txt"), header = F)
sub_train <- read.table(file.path(file_path, "train", "subject_train.txt"), header = F)

ncol(x_train) ### 561, the readings are corresponding to 561 features, mentioned in features.txt

#### Read testing data. X_test, Y_test & Subject_test ######

x_test <- read.table(file.path(file_path, "test", "X_test.txt"), header = F)
y_test <- read.table(file.path(file_path, "test", "y_test.txt"), header = F)
sub_test <- read.table(file.path(file_path, "test", "subject_test.txt"), header = F)

ncol(x_test)  ### 561, the readings are corresponding to 561 features, mentioned in features.txt

###### Read Activity Labels ######

activity_labels <- read.table(file.path(file_path, "activity_labels.txt"), header = F)

###### Read Features Data ######

features_data <- read.table(file.path(file_path, "features.txt"), header = F)

nrow(features_data) ## 561 features

##########################################################################################
### Add column names to the data read above ###
colnames(x_train) <- features_data[ , 2]
colnames(x_test) <- features_data[ , 2]

colnames(y_train) <- "ActivityID"
colnames(y_test) <- "ActivityID"

colnames(sub_train) <- "SubjectID"
colnames(sub_test) <- "SubjectID"

colnames(activity_labels) <- c("ActivityID", "ActivityName")

##########################################################################################
### Merge all train data sets ###

merge_train <- cbind(y_train, sub_train, x_train)

### Merge all test data sets ###

merge_test <-  cbind(y_test, sub_test, x_test)

### Merge train & test data sets ###

merge_train_test <- rbind(merge_train, merge_test)

### Quick verification ###
ncol(merge_train_test) ## 563
nrow(merge_train) ## 7352
nrow(merge_test)  ## 2947
nrow(merge_train_test) ## 10299

### Capture column names of merged data ###

all_columns <- colnames(merge_train_test)

### Prepare the indices of columns with mean & std information ###

mean_stddev_index <- grepl("ActivityID" , all_columns) |
               grepl("SubjectID" , all_columns) |
               grepl("mean.." , all_columns) |
               grepl("std.." , all_columns)

### Select relevant data ###

mean_stddev_data <- merge_train_test[, mean_stddev_index == TRUE]

#View(mean_stddev_data)

mean_stddev_with_activity_data <- merge(mean_stddev_data, activity_labels, by = 'ActivityID')

### Quick Verification ###
#unique(mean_stddev_with_activity_data$ActivityID)
#table(mean_stddev_with_activity_data$ActivityID, mean_stddev_with_activity_data$ActivityName)

### Compute mean and create the tidy data set ###

tidy_aggregate_data <- mean_stddev_with_activity_data %>% 
  group_by(ActivityID, SubjectID) %>% summarise_all(mean)

View(tidy_aggregate_data)
str(tidy_aggregate_data) # 82 Variables  and 180 observations

### write tidy data set to disk as .txt file ###

write.table(tidy_aggregate_data, "TidyDataSet.txt", row.name=FALSE)
