
library(dplyr)

train_x <- read.table("train/X_train.txt")
train_y <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

test_x <- read.table("test/X_test.txt")
test_y <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")

merged_x <- rbind(train_x, test_x)

merged_y <- rbind(train_y, test_y)

merged_subject <- rbind(train_subject, test_subject)

colnames(merged_x) <- read.table("features.txt")[, 2]
colnames(merged_y) <- "Activity"
colnames(merged_subject) <- "Subject"

mean_std_cols <- grep("mean|std", colnames(merged_x))

subset_merged <- merged_x[, mean_std_cols]

activity_labels <- read.table("activity_labels.txt", col.names = c("Activity", "ActivityName"))

clean_col_names <- gsub("\\(|\\)", "", names(subset_merged))
clean_col_names <- gsub("Acc", "Acceleration", clean_col_names)
clean_col_names <- gsub("Mag", "Magnitude", clean_col_names)
clean_col_names <- gsub("^t", "Time", clean_col_names)
clean_col_names <- gsub("^f", "Frequency", clean_col_names)
clean_col_names <- gsub("-", "", clean_col_names)

colnames(subset_merged) <- clean_col_names

tidy_data <- subset_merged

> write.csv(tidy_data, file = "tidy_data.txt")
