# Code Book

## Data source

[UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):
accelerometer/gyroscope signals from a Samsung Galaxy S, worn by 30 subjects performing 6
activities. The original researchers derived 561 features per window and normalized each to
[-1, 1].

## Variables in `tidy_avg.txt`

180 rows (30 subjects x 6 activities), 68 columns:

- `subject`: integer, 1-30, volunteer ID.
- `activity`: `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`.
- 66 measurement columns: the mean, per subject-activity pair, of a `mean()`/`std()` measurement
  from the original 561 features. All unitless (normalized to [-1, 1]). Names follow the pattern
  `[time|frequency][Body|Gravity][Accelerometer|Gyroscope][Jerk]?[Magnitude]?[Mean|STD][X|Y|Z]?`:
  - `time`/`frequency`: raw signal vs. FFT-derived signal
  - `Body`/`Gravity`: body motion vs. gravity component
  - `Accelerometer`/`Gyroscope`: sensor
  - `Jerk`: derivative of the signal, if present
  - `Magnitude`: Euclidean norm of the 3-axis signal (no `X`/`Y`/`Z` suffix)
  - `Mean`/`STD`: mean or standard deviation of the original measurement
  - `X`/`Y`/`Z`: axis, when not a magnitude

  All 66: `timeBodyAccelerometerMeanX/Y/Z`, `timeBodyAccelerometerSTDX/Y/Z`,
  `timeGravityAccelerometerMeanX/Y/Z`, `timeGravityAccelerometerSTDX/Y/Z`,
  `timeBodyAccelerometerJerkMeanX/Y/Z`, `timeBodyAccelerometerJerkSTDX/Y/Z`,
  `timeBodyGyroscopeMeanX/Y/Z`, `timeBodyGyroscopeSTDX/Y/Z`,
  `timeBodyGyroscopeJerkMeanX/Y/Z`, `timeBodyGyroscopeJerkSTDX/Y/Z`,
  `timeBodyAccelerometerMagnitudeMean/STD`, `timeGravityAccelerometerMagnitudeMean/STD`,
  `timeBodyAccelerometerJerkMagnitudeMean/STD`, `timeBodyGyroscopeMagnitudeMean/STD`,
  `timeBodyGyroscopeJerkMagnitudeMean/STD`,
  `frequencyBodyAccelerometerMeanX/Y/Z`, `frequencyBodyAccelerometerSTDX/Y/Z`,
  `frequencyBodyAccelerometerJerkMeanX/Y/Z`, `frequencyBodyAccelerometerJerkSTDX/Y/Z`,
  `frequencyBodyGyroscopeMeanX/Y/Z`, `frequencyBodyGyroscopeSTDX/Y/Z`,
  `frequencyBodyAccelerometerMagnitudeMean/STD`, `frequencyBodyAccelerometerJerkMagnitudeMean/STD`,
  `frequencyBodyGyroscopeMagnitudeMean/STD`, `frequencyBodyGyroscopeJerkMagnitudeMean/STD`.

## Transformations (`run_analysis.R`)

1. Merged the train and test sets (X, y, subject files) into one data set.
2. Kept only the 66 columns whose name contains `mean()` or `std()`.
3. Replaced numeric activity codes with descriptive names from `activity_labels.txt`.
4. Cleaned variable names (expanded abbreviations, removed `()`/`-`).
5. Averaged every variable by subject and activity, producing `tidy_avg.txt`.
