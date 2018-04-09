Course Name - Getting and Cleaning Data 
Week # 4
Type - Assignment

Repository Name - Data_Cleansing_Week4
Purpose - Solution to the Week 4 assignment of "Getting & CLeaning Data" course.

Steps to follow - 

1. Download and unzip the data files to R working directory.
2. Read the data files to R working directory.
3. Create the Source code in R working directory.
4. Execute R source code to generate tidy data set.

Code explanation - 

1. Read the Training data (X, Y, Subject)
2. Read the Test data (X, Y, Subject)
3. Read Activity Data
4. Read Features Data
5. Assign column names to Training, Testing, Activity & Subject data
6. Merge training data sets into one.
7. Merge testing data sets into one.
8. Merge training and testing data.
9. Find all the columns having "mean" and "std" in column names along with the Activity ID and Subject ID.
10. Apply Activity Labels to above data.
11. Group by the data on Activity ID and Subject ID and compute mean.
12. Write the tidy data set into disk using write.table() function.

write.table(tidy_aggregate_data, "TidyDataSet.txt", row.name=FALSE)

