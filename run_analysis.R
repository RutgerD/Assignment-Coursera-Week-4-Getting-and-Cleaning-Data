if(!file.exists("assignment")) {
  dir.create("assignment")
}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./assignment/fresh.zip")
unzip("./assignment/fresh.zip", exdir = "./assignment")

acts<-read.table("./assignment/UCI HAR Dataset/activity_labels.txt", header =
                   FALSE)
features<-read.table("./assignment/UCI HAR Dataset/features.txt", header =
                       FALSE)
x_train<-read.table("./assignment/UCI HAR Dataset/train/X_train.txt", header =
                      FALSE)
y_train<-read.table("./assignment/UCI HAR Dataset/train/y_train.txt", header =
                      FALSE)
subject_train<-read.table("./assignment/UCI HAR Dataset/train/subject_train.txt",
                          header = FALSE)
x_test<-read.table("./assignment/UCI HAR Dataset/test/X_test.txt", header =
                     FALSE)
y_test<-read.table("./assignment/UCI HAR Dataset/test/y_test.txt", header =
                     FALSE)
subject_test<-read.table("./assignment/UCI HAR Dataset/test/subject_test.txt", header =
                           FALSE)

data<-bind_rows(x_train, x_test)

ex<-grep("mean|std", features$V2)
sel_feat<-slice(features, ex)

ex1<-grep("^t", sel_feat$V2)
sel_feat<-slice(sel_feat, ex1)

sel_data<-select(data, ex)
sel_data<-select(sel_data, ex1)

colnames(sel_data)<-sel_feat$V2

y_data<-bind_rows(y_train, y_test)

y_data<-y_data$V1
y_data<-gsub("1", acts[1, 2], y_data)
y_data<-gsub("2", acts[2, 2], y_data)
y_data<-gsub("3", acts[3, 2], y_data)
y_data<-gsub("4", acts[4, 2], y_data)
y_data<-gsub("5", acts[5, 2], y_data)
y_data<-gsub("6", acts[6, 2], y_data)
y_data<-data.frame(y_data)

sel_data<-bind_cols(y_data, sel_data)
sel_data<-rename(sel_data, activity = y_data)

subjects<-bind_rows(subject_train, subject_test)
subjects<-rename(subjects, subject = V1)

df4<-bind_cols(subjects, sel_data)

grouped<-group_by(df4, subject, activity, add = TRUE)

tidy_data<- summarise_each(grouped, funs(mean))

## If we don't need the standard deviation columns, we can get rid of them with
## the following line:
## tidy_data<-select(tidy_data, -contains("std"))