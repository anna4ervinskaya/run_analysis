library(dplyr)

# download data archive
file_name <- "Run_Analysis_DataSet.zip"
if (!file.exists(file_name)){
  file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(file_url, file_name, method="curl")
}

# unzip dowloaded archive
folder_name <- "UCI HAR Dataset"
if (!file.exists(folder_name)) { 
  unzip(file_name) 
}

#prepare data for tidying
activity_labels <- read.table(paste0(folder_name, "/activity_labels.txt"), col.names = c("code","activity"))
features <- read.table(paste0(folder_name, "/features.txt"), col.names = c("n","feature"))
subject_test <- read.table(paste0(folder_name, "/test/subject_test.txt"), col.names = c("subject"))
x_test <- read.table(paste0(folder_name, "/test/X_test.txt"), col.names = features$feature)
y_test <- read.table(paste0(folder_name, "/test/y_test.txt"), col.names = "code")
subject_train <-read.table(paste0(folder_name, "/train/subject_train.txt"), col.names = "subject")
x_train <- read.table(paste0(folder_name, "/train/X_train.txt"), col.names = features$feature)
y_train <- read.table(paste0(folder_name, "/train/y_train.txt"), col.names = "code")

# 1. Merges the training and the test sets to create one data set.
x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)
subject_merged <- rbind(subject_test, subject_train)
data_merged <- cbind(subject_merged, x, y)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
tidy_data <- select(data_merged, subject, code, contains(c("mean", "std")))

# 3. Uses descriptive activity names to name the activities in the data set.
tidy_data$code <- activity_labels[tidy_data$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.
names(tidy_data)[1] <- "Subject"
names(tidy_data)[2] <- "ActivityLabel"
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
result <- tidy_data %>%
  group_by(Subject, ActivityLabel) %>% 
  summarise_all(list(mean=mean))
write.table(result, "TidyData.txt", row.names = FALSE)
