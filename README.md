# Getting-and-Cleaning-Data-Course-Project

To accomplish the tasks described, you will need to perform the following steps using the provided dataset:

    Download and extract the dataset:
        Download the dataset from the provided URL: Dataset Download
        Extract the downloaded ZIP file to a directory of your choice.

    Create an R script called run_analysis.R and open it in your preferred R development environment.

    Set the working directory to the directory where you extracted the dataset:

R

setwd("path_to_extracted_dataset_directory")

Load the required libraries. Make sure you have the dplyr library installed:

R

library(dplyr)

Read the training and test datasets into separate data frames:

R

# Read training dataset
train_x <- read.table("train/X_train.txt")
train_y <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

# Read test dataset
test_x <- read.table("test/X_test.txt")
test_y <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")

Merge the training and test datasets to create one combined dataset:

R

# Combine the x data
merged_x <- rbind(train_x, test_x)

# Combine the y data
merged_y <- rbind(train_y, test_y)

# Combine the subject data
merged_subject <- rbind(train_subject, test_subject)

# Set column names for merged data
colnames(merged_x) <- read.table("features.txt")[, 2]
colnames(merged_y) <- "Activity"
colnames(merged_subject) <- "Subject"

Extract only the measurements on the mean and standard deviation for each measurement:

R

# Extract the column indices containing mean or std in their names
mean_std_cols <- grep("mean|std", colnames(merged_x))

# Subset the merged dataset using the mean_std_cols
subset_merged <- merged_x[, mean_std_cols]

Use descriptive activity names to name the activities in the dataset:

R

# Read activity labels
activity_labels <- read.table("activity_labels.txt", col.names = c("Activity", "ActivityName"))

# Replace activity codes with descriptive names
subset_merged$Activity <- factor(subset_merged$Activity, levels = activity_labels$Activity, labels = activity_labels$ActivityName)

Label the dataset with descriptive variable names:

R

# Clean up the column names for better readability
clean_col_names <- gsub("\\(|\\)", "", names(subset_merged))
clean_col_names <- gsub("Acc", "Acceleration", clean_col_names)
clean_col_names <- gsub("Mag", "Magnitude", clean_col_names)
clean_col_names <- gsub("^t", "Time", clean_col_names)
clean_col_names <- gsub("^f", "Frequency", clean_col_names)
clean_col_names <- gsub("-", "", clean_col_names)

# Assign the cleaned column names
colnames(subset_merged) <- clean_col_names

Create a second, independent tidy dataset with the average of each variable for each activity and each subject:

R

# Group the data by Activity and Subject, and calculate the mean of each variable
tidy_data <- subset_merged
