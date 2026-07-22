url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI_HAR_Dataset.zip"

if (!file.exists(zipfile)) download.file(url, zipfile, mode = "wb")
if (!file.exists("UCI HAR Dataset")) unzip(zipfile)


## Merges the training and the test sets to create one data set.

read_set <- function(type) {
  X <- read.table(file.path("UCI HAR Dataset", type, paste0("X_", type, ".txt")))
  y <- read.table(file.path("UCI HAR Dataset", type, paste0("y_", type, ".txt")))
  subject <- read.table(file.path("UCI HAR Dataset", type, paste0("subject_", type, ".txt")))
  cbind(subject, y, X)
}

train <- read_set("train")
test  <- read_set("test")
full  <- rbind(train, test)


## Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "name"))
names(full) <- c("subject", "activity", features$name)

is_mean_std <- grepl("mean\\(\\)|std\\(\\)", features$name)
full <- full[, c(TRUE, TRUE, is_mean_std)]


## Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",
                               col.names = c("id", "activity_name"))
full$activity <- factor(full$activity,
                         levels = activity_labels$id,
                         labels = activity_labels$activity_name)


## Appropriately labels the data set with descriptive variable names. 

replacements <- c(
  "^t" = "time",
  "^f" = "frequency",
  "Acc" = "Accelerometer",
  "Gyro" = "Gyroscope",
  "Mag" = "Magnitude",
  "BodyBody" = "Body",
  "-mean\\(\\)" = "Mean",
  "-std\\(\\)" = "STD",
  "-" = ""
)
clean_names <- names(full)
for (pattern in names(replacements)) {
  clean_names <- gsub(pattern, replacements[pattern], clean_names)
}
names(full) <- clean_names


## Creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject.

tidy_avg <- aggregate(. ~ subject + activity, full, mean)
write.table(tidy_avg, "tidy_avg.txt", row.names = FALSE)