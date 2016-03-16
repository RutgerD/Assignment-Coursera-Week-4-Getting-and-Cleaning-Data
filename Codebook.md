---
output: 
  html_document: 
    highlight: zenburn
---
#### BEFORE WE START

##### Download and unzip
1. Create a directory called "assignment"
2. Download the zip file from the web.
3. Unzip the files to that directory.
```
if(!file.exists("assignment")){dir.create("assignment")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./assignment/fresh.zip")
unzip("./assignment/fresh.zip", exdir="./assignment")
```

##### Read the data files
1. Acts lists the activities
2. Features lists the labels of the measurements
3. Subject lists the number of the subjects (1-30)
4. y lists the activities according to a number specified in "acts"
5. x lists the data output of the measurements
```
acts<-read.table("./assignment/UCI HAR Dataset/activity_labels.txt", header=FALSE)
features<-read.table("./assignment/UCI HAR Dataset/features.txt", header=FALSE)
x_train<-read.table("./assignment/UCI HAR Dataset/train/X_train.txt", header=FALSE)
y_train<-read.table("./assignment/UCI HAR Dataset/train/y_train.txt", header=FALSE)
subject_train<-read.table("./assignment/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
x_test<-read.table("./assignment/UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_test<-read.table("./assignment/UCI HAR Dataset/test/y_test.txt", header=FALSE)
subject_test<-read.table("./assignment/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
```


#### STEP 1

Here, values from the test group are added to the train dataset. Rows from the test group are appended to the bottom of the train group
```
data<-bind_rows(x_train, x_test)
y_data<-bind_rows(y_train, y_test)
subjects<-bind_rows(subject_train, subject_test)
```


#### STEP 2

A vector "ex" is generated with the row numbers of the elements containing "mean" or "std". "Ex is then used to select the rows containing these elements from the "feature data frame
```
ex<-grep("mean|std", features$V2)
sel_feat<-slice(features, ex)
```


#### STEP 4

**Note: first we do step 4, then step 3.**
A vector "ex1" is generated with the row numbers of the elements starting with "t". "Ex1"" is then used to select the rows containing these elements from the "sel_feat" data frame. The other elements start with "f", which are the Fourier transforms of the "t"-elements and we don't need these.
```
ex1<-grep("^t", sel_feat$V2)
sel_feat<-slice(sel_feat, ex1)
```

Here the same is done as above, but selecting the columns containing the relevant data (as above). This is necessarily done in two steps.
```
sel_data<-select(data,ex)
sel_data<-select(sel_data, ex1)
```

Here we name the columns of the "sel_data" data frame according to their labels from "sel_feat""
```
colnames(sel_data)<-sel_feat$V2
```


#### STEP 3

The numbers in y_data are converted to their corresponding labels from "acts". First the data frame "y_data" is converted to a vector, and after the substitutions, it is converted back to a data frame. This is necessary for the 
next step.
```
y_data<-y_data$V1
y_data<-gsub("1", acts[1,2], y_data)
y_data<-gsub("2", acts[2,2], y_data)
y_data<-gsub("3", acts[3,2], y_data)
y_data<-gsub("4", acts[4,2], y_data)
y_data<-gsub("5", acts[5,2], y_data)
y_data<-gsub("6", acts[6,2], y_data)
y_data<-data.frame(y_data)
```

The different activities are appended to the "sel_data" data frame, and the column containing the activity names is renamed to "activity".
```
sel_data<-bind_cols(y_data, sel_data)
sel_data<-rename(sel_data, activity=y_data)
```

In the "subjects" data frame, and the column is renamed to "subject"
```
subjects<-rename(subjects, subject=V1)
```

Here the data frame required in step 4 is generated. It contains, from left to right, columns with subjects, activities, means and standard deviations of measurements detailed in the column names. 
```
df4<-bind_cols(subjects, sel_data)
```


#### STEP 5

We need to deliver the mean of each variable for each activity and subject. For this, we first group the data by subject number and by activity type. This gives us 30*6=180 groups.
```
grouped<-group_by(df4, subject, activity, add=TRUE)
```

Then, we use summarize_each to perform the mean function on each defined group, on each column. Performing mean on 40 columns, for 180 groups yields a data frame "tidy_data" of 180 rows * 42 columns.
```
tidy_data<- summarise_each(grouped, funs(mean))
```

If we don't need the standard deviation columns, we can get rid of them with the following line:
```  
tidy_data<-select(tidy_data, -contains("std"))
```