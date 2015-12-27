# Get-Data
This is the final course project for the Getting and Cleaning Data Course at Johns Hopkins, via Coursera.

Included are the following:

* an R script called **run_analysis.R**. The script performs the following actions:
  + It checks to see if the unzipped files are in the current working directory. If not:
  + It checks to make sure the zip file for data set is in the current working directory. If not:
    + It downloads the data from this site: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  + **Note:** As a last resort, it unzips the data into a new directory
    + it makes the new working directory the "current working directory"
* This repository also contains a codebook called **CodeBook.md** that explains 
* the dataset, entitled **happydata.txt**. This is a 180 x 68 tidy set of data. After running **run_Analysis.R**, this tidied set of data is output into the directory above the set of raw data files for the researcher's convenience.
* For extensive details regarding the raw data, the tidied data, how it was cleaned, the variables, measurements, and thought process behind the cleaning, and all transformations performed on it, please refer to either **Codebook.Rmd** or **Codebook.md** (they are identical), included in this repository. 

**Read data file ("happydata.txt") using read.table("happydata.txt", header=TRUE)**
