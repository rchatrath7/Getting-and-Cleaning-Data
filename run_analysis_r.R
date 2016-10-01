# Set training dataset 
training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)

# Set labels 
training[,562] <- read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)

# Set subject IDs
training[,563] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# Set testing dataset
testing <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing[,562] <- read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
testing[,563] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Get features
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] <- gsub('-mean', 'Mean', features[,2])
features[,2] <- gsub('-std', 'Std', features[,2])
features[,2] <- gsub('[-()]', '', features[,2])

# Get activity labels
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Merge dataset
data <- rbind(training, testing)

# Start getting the desired vals 
desired <- grep(".*Mean.*|.*Std.*", features[,2])
features <- features[desired, ]

desired <- c(desired, 562, 563)
data <- data[,desired]
colnames(data) <- c(features$V2, "Activity", "Subject")
colnames(data) <- tolower(colnames(data))

activity = 1 
for (activityLabel in activityLabels$V2){
  data$activity <- gsub(activity, activityLabel, data$activity)
  activity <- activity + 1
}

data$activity <- as.factor(data$activity)
data$subject <- as.factor(data$subject)

aggregant <- aggregate(data, by=list(Activity=data$activity, Subject=data$subject), mean)


aggregant[,89] = NULL 
aggregant[,90] = NULL

write.table(aggregant, file="tidy.txt", sep="\t")
