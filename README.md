# Get-Data
This is the final course project for the Getting and Cleaning Data Course at Johns Hopkins, via Coursera.

Included are the following:

* an R script called run_analysis.R. The script performs the following actions:
  + it checks to make sure the zip file for data set is in the current working directory. If not:
    + it downloads the data from this site: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  + **Note:** it unzips the data into a new directory
    + it makes the new working directory the "current working directory"
* it creates a codebook called CodeBook.md that explains the variables, data and transformations performed in order to clean the data into
* the dataset, entitled **happydata.txt**. This is a 180 x 68 tidy set of data. This file is located in the directory that is current after the script has been run.
