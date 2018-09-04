# CourseraGettingAndCleaningData
Overview of run_analysis Strategy 
1. download the data from the url which are provided
2. use read.table function to getting the data of train and test
3.  use left_join funtion to return all the values from x by the commonlabel.
4.  use the cbind funtion to merge the subject, x and y table for train and test
5.  use the rbind funtion to merge the data from test and train
6.  use the select funtion to keep only mean and std and use contains function as well.
7.  use the factor function to convert the subject and activity as the factor
8.  use %>% operator to cat all the mean and std for group by the subject and activity
9. use the write.table to get the output
