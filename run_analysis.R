# This script is for the project of Peer-graded Assignment: Getting and Cleanning Data Course
# 
# Overview: using read table function to get the data from test and train, use cbind to merge the data, use select function to keep or remove the columes to make the data tidy
# After getting the data tidy up then using as.factor function and %>% operator to cat the average into the tidy_data.txt

library(dplyr)

features_list <- read.table("features.txt", col.names = c("id","features"))
activity <- read.table("activity_labels.txt", col.names = c("label","activity"))

# getting the test data
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("test/X_test.txt", col.names = features_list$features)
y_test <- read.table("test/y_test.txt", col.names = "label")
y_test_label <- left_join(y_test, activity, by = "label")

# cleanning the test data
tidy_test <- cbind(subject_test, y_test_label, x_test)
tidy_test <- select(tidy_test, -label)

# getting the train data
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = features_list$features)
y_train <- read.table("train/y_train.txt", col.names = "label")
y_train_label <- left_join(y_train, activity, by = "label")

# cleanning the train data
tidy_train <- cbind(subject_train, y_train_label, x_train)
tidy_train <- select(tidy_train, -label)

#merg all the data from test and train
tidy_dataSet <- rbind(tidy_test, tidy_train)

# only keep the mean and std from the merged the data set
tidy_mean_std <- select(tidy_dataSet, contains("mean"), contains("std"))


# convert the subject and activity as the factor
tidy_mean_std$subject <- as.factor(tidy_dataSet$subject)
tidy_mean_std$activity <- as.factor(tidy_dataSet$activity)

tidy_avg <- tidy_mean_std %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# output of the average 
# 
write.table(tidy_avg, "tidy.txt", row.names = F, quote = F)
