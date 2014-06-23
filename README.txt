===============================================================
Getting and Cleaning Data Course Project
README
Version 1.0
===============================================================
Roberto Kao
New College of Florida 
5800 Bay Shore Road
Sarasota, FL 34243
===============================================================

This is the readme file for the run_analysis.R file. I will do my best to describe my code and walk you through how
I obtained my tidy data set. I will refer to the lines of the code literally, so that each line is numbered regardless
if the line is empty or not. The code is structured so that as long as you are in your working directory, you will 
generate a tidy data set from start to finish with minimal effort. I have also marked certain lines in the code for 
your reference. Please refer to run_analysis.R as I will be going through each line to explain its purpose.

===============================================================
(lines 1-7)
Describes the download phase. (3) downloads the file from the given URL and stores it in your working directory.
(4) unzips the file. From here we have a folder with a few key data sets: activity_labels.txt, features.txt, subject_test,
X_test, Y_test, subject_train, X_train, and Y_train. You can refer to the folders README.txt to find out more detail about 
these data sets. (6) reads in activity_labels.txt, which we will use to label the observations of variable 'Activity' later 
on. (7) reads in features.txt, which we will use to label the variables later on.

Note: See that there are two supersets train and test. This refers to the splitting of the observations into two groups:
train and test. Any code I describe for one set can be applied to the other.

(lines 10-24)
This is the test superset. (12) reads in subject_test.txt, which are our observations. (13) reads in Y_test.txt, which refers 
to the activity the observation has done. (14) reads in X_test.txt, which are the data points recorded for each variable.
(15) binds all three data sets together by their columns, so that the first column are your observation ID's, second are your 
activity ID's, and the rest are your data points for each variable. (17) renames the first column to 'Subject ID'. (18) renames
the second column to 'Activity'. (19) takes the rest of the variables and matches them with the features data set; we now have
variable names for the data points recorded in X_test.txt. (20)-(22) describes a for loop from one to six(number of 
activities) that takes each number in the second column of our data set and matches it with the activity in the 
activity_labels.txt document we've read in. (24) extracts feature names that have the word 'mean', 'Mean', or 'std' in them 
using the grep() function and subsets our data set to only have features with mean or standard deviation data points. We now
have a tidy data set for the superset test that has Subject ID's, Activity names, and variables that only pertain to mean
or standard deviation.

(lines 27-41)
This is the train superset. Exactly the same as (lines 10-24), just replace 'test' with 'train'. 

(lines 44-52)
We now must merge the two tidy data sets we have created for each superset. (46) binds both data sets together by their rows,
essentially stacking one on top of the other. We have now one tidy data set to work with, which still needs work. (48) sorts
our merged data set by Subject ID and Activity. (50) takes our sorted data and collapses the rows by Subject ID and Activity
and takes the means of each feature. Please note that my data set does not change the feature name after I have performed 
this collapsing. Each of the feature name should be something along the lines of 'Mean of...' to properly describe what it is.
I did not have time to complete this. (52) once again sorts by Subject ID and Activity to get our final product: a tidy data
set that fulfills the project requirements. 

(lines 55-57)
We now must export our finished product into a .txt file. (57) does exactly that; it dumps the data set into a .txt file into
your working directory. 
===============================================================

This concludes the code walkthrough. We now have a tidy data set to work with. In order to see that it is indeed tidy, please
input this code into R:

tidy_data_set=read.table('./tidy_data.txt',row.names=1)

I hope you have enjoyed my walkthrough. Please excuse the rushed nature of it, as I literally am rushing to beat the deadline in
minutes!