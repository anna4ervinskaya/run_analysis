
## Code book
The run_analysis.R script performs data preparation and 5 steps required as described in the course project.

 1. Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset
 2. Assign data to variables
activity_labels <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)
features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

 3. Merges the training and the test sets to create one data set
x (10299 rows, 561 columns) is created by merging x_train and x_test with rbind()
y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
subject_merged (10299 rows, 1 column) is created by merging subject_train and subject_test with rbind()
data_merged (10299 rows, 563 column) is created by merging subject_merged , x and y with cbind()

 4. Extracts only the measurements on the mean and standard deviation for each measurement
tidy_data (10299 rows, 88 columns) is created by subsetting data_merged, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

 5. Uses descriptive activity names to name the activities in the data set
Each number in code column of the tidy_data was replaced with corresponding activity taken from second column of the activity_labels variable

 6. Appropriately labels the data set with descriptive variable names
subject column in tidy_data was renamed into Subject
code column in tidy_data renamed into ActivityLabel
All Acc in names replaced by Accelerometer
All angle in names replaced by Angle
All Gyro in names replaced by Gyroscope
All gravity in names replaced by Gravity
All BodyBody in names replaced by Body
All Mag in names replaced by Magnitude
All start with character f in names replaced by Frequency
All start with character t in name replaced by Time

 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
result (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export results variable into TidyData.txt file.