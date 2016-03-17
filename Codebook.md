This is the Codebook related to the "Human Activity Recognition Using Smartphones Data Set".

More information on this dataset can be found on the following website: "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
The data comes as a bundle of files in a zip file, and needs to be reconsituted in order to be characterised as "tidy data".

run_analyis.R will download, unzip, and reassamble the data. It will add the appropiate columns, with appropiate and understandable column names.
It will output a data frame called "df4", which contains the means and standard deviations of measurements for each of thirty persons, for each period they were performing one of six different activities (there are 10299 rows) For each person/activity, there are 40 columns with the measurements.

It will also output a data frame called "tidy_data", which contains the means and standard deviations of the measurements of each person for each activity, averaged over the number of times they performed said activities. This data frame contains 180 rows (30 persons * 6 activites) and 42 columns of which 40 are the averaged means and standard deviations.

The measurements in this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

These signals were used to estimate variables for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ,
tGravityAcc-XYZ,
tBodyAccJerk-XYZ,
tBodyGyro-XYZ,
tBodyGyroJerk-XYZ,
tBodyAccMag,
tGravityAccMag,
tBodyAccJerkMag,
tBodyGyroMag,
tBodyGyroJerkMag (a total of 20 measurement types)

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation


License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012