Code Book

This code book describes the data used in this assignment and the processes used to create the tidy data set.

30 volunteers between the ages of 19-48 performed 6 different activities while wearing the Samsung Galaxy S II smartphone. The Galaxy S2 collected data about their differnet movements.

Explanation of each file

features.txt: contains the names of the 561 features.
activity_labels.txt: contains the names and IDs for each of the 6 activities.

X_test.txt: contains 2947 observations of the 561 features, for the volunteers.

subject_test.txt: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in X_test.txt.
y_test.txt: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in X_test.txt.

X_train.txt: contains the 7352 observations of the 561 features, from the volunteers.

subject_train.txt: contains 7352 integers, that shows the volunteer's ID related to each of the observations in X_train.txt.
Y_train.txt: contains 7352 integers, that shows the activity's ID related to each of the observations in X_train.txt.


Steps performed to process the data into a tidy data set:

1- The test and training data files were read into data frames, column headers were added, and the training and then combined into a single data set.

2- Columns that did not contain the exact string "mean()" or "std()" were removed., leaveing 66 feature columns.

3- The column "activity" was converted from an integer to a factor, and labels were used to describe the activities.

4- A tidy data set was created and saved as a CSV file.