Data
    Data for this project originates from the Human Activity Recognition Using Smartphones. There is much on the site and the original article is no longer available. The data can be found on this link.

run_analysis.R
    The run_analysis.R script the following steps as per the assigned task of the coursework:
        1.	Merges the training and the test sets to create one data set.
                        o	Reads the training and testing datasets along with feature vectors and activity labels.
                        o	Assigns variable names.
                        o	Merges all data into one dataset.
        2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
                        o	Pulls only data measuring a variable mean and standard deviation
        3.	Uses descriptive activity names to name the activities in the data set
                        o	Pulls activity descriptive names versus the activities assigned numerical label
        4.	Appropriately labels the data set with descriptive variable names. 
                        o	Updates variable names by removing abbreviations used in origninal datasets
        5.	Create a second, independent tidy data set with the average of each variable for each activity and each subject.
                        o	Got each variable’s mean for each subject and activity then grouped by subject and activity 
                        o	Final text file, tidy_data.txt, created
