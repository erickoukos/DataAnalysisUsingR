#   Session 2: Online Academic Data Analysis Bootcamp Using Open-
#                 Access Program R

# Prerequisites 

# 1. Install the following packages by running the following code. You should be connected to a
 # stable internet during the installation (Note: remove the # comment symbols to run the code line)

#install.packages("Rcmdr", dependencies = TRUE); install.packages("writexl", dependencies = TRUE); 
#install.packages("foreign", dependencies = TRUE); install.packages("haven", dependencies=TRUE)



# 2. Download and save all the files sent in the session 2 email 

# 3. Set your working directory to the folder you have saved session's files sent via email 
getwd()
setwd("~/Documents/Projects/R/Essential Level/Session Two/Practicals")
# Getting data into and out of R
## Getting data into R
#1. Creating variables
# From first session the c() / concatenate function was to create objects that contain data.
studentNames <- c("John","James","Albert","Ahmed", "Aarya")
studentGrades1 <- c(60, 87, 53, 72, 85) #Grades at test 1

#More efficient to combine the files into a single object: dataframe
#Use the data.frame() function while renaming studentNames to
#Name and studentGrades1 to First_Grade:

students <-data.frame(Name = studentNames, First_Grade = studentGrades1)
#Run below to see the dataframe:
students

# dataframe$variableName can be used to refer to the variables
# e.g. to get student Name data run 
students$Name

#similarly, for First Grade variable we could use 

students$First_Grade

#We can add another variable e.g. Second Grades using the c() function as follows:
students$Second_Grade <- c(65, 56, 87, 79, 85) 

#run below to view the new dataframe

students

#You can view variable names using:
names(students)

# 2. Getting data into R: Calculating new variables from existing ones
# Use of basic operators in R
students$Improvement <- students$Second_Grade - students$First_Grade

students

# This inserts a new variable "Improvement" to the students dataframe.
names(students)
# 3. Getting data into R: Creating a date variable
#Text converted into date objects using the as.Date() function.

# Examples: calculate age difference using birthdates from four couples

husband <- as.Date(c("1973-06-21", "1970-07-16", "1949-10-08", "1969-05-24"))
wife <- as.Date(c("1984-11-12", "1973-08-02", "1948-11-11", "1983-07-23"))

# Calculate the difference between the two variables:
agegap <- husband - wife

# Time differences in days
agegap
# Creating coding variables/factors
# Example: Data where 1 = lecturers and 2 = students 
# Write levels = c("Lecturers", "Students")

job <- c(1,1,1,1,1,2,2,2,2,2) 
#or better use function rep(number_of_repetitions) 
job <- c(rep(1, 5),rep(2, 5))


job <- factor(job, levels = c(1:2), labels = c("Lecturer", "Student"))
summary(job)
# Or
?gl
job <- gl(2, 5, labels = c("Lecturer", "Student"))
summary(job)

# Check factor levels

levels(job)

# How to rename factor levels e.g. to Medical Lecturer and Medical Student
levels(job) <- c("Medical Lecturer", "Medical Student")
# Missing Data
# In R, missing values are represented by the symbol NA (not available) 
# Testing for Missing Values
# is.na(x) returns TRUE if x is missing
y <- c(1,2,3,NA)
is.na(y) # returns a vector (F F F T)

# Missing Data- Recording Values to Missing
# data frame that codes missing values as 99
df <- data.frame(variable1 = c(1:3, 99), variable2 = c(2.5, 4.2, 99, 3.2))
# change 99s to NAs
df[df == 99] <- NA

df
# Excluding Missing Values from Analyses
# Arithmetic functions on missing values yield missing values.
x <- c(1,2,NA,3)
mean(x)       # returns NA
mean(x, na.rm=TRUE) # returns 2

#The function complete.cases() returns a logical vector indicating which cases are complete.
# list rows of data that have missing values mydata[!complete.cases(mydata),]
df[!complete.cases(df),]
   
# The function na.omit() returns the object with listwise deletion of missing values.
# create new dataset without missing data newdata <- na.omit(mydata)
newdata <- na.omit(df)   
newdata  
# Entering data with R Commander 
# install.packages("Rcmdr", dependencies = TRUE)
install.packages("aplpack")
install.packages("leaps", dependencies = TRUE)
library(Rcmdr)

# New window opens
# Click Data -> New data set (opens a dialog box that   enables you to name the dataframe)
  # Enter students data below created in previous case study

#       Name First_Grade Second_Grade Improvement
#1   John          60           65           5
#2  James          87           56         -31
#3 Albert          53           87          34
#4  Ahmed          72           79           7
#5  Aarya          85           85           0

# To save the data, simply close the Rcmdr window.


# Importing data: formats
# Importing data: formats- excel
# 1. Open the Excel data called GSSsubset.xlsx that was sent via email
# 2. Click Save As, Select the location you wish to save the file (esp. R Working Directory)
# 3. Change Excel default format (.xlsx or .xls) by clicking on the drop-down list
# 4. select Text (Tab delimited), type a name for your file and click "Save"
# 5. The saved file is a Comma delimited file with a .csv file extension
# Repeat the process above to saved file is either a Text (Tab Delimited) .txt file 

getwd()
setwd('/home/erick/Documents/Projects/R/Essential Level/Session Two/Practicals')
# Importing data: data saved in working directory
 # Import data from CSV
 # This is the code we use to import csv file into R
 GSSsubset_df <- read.table("GSSsubset.csv", header=TRUE, sep=",") # Or this code:
 head(GSSsubset_df)
 
 GSSsubset_df <- read.csv("GSSsubset.csv",header=T,as.is=T)
 head(GSSsubset_df)
 
 #Import data from TXT
 GSSsubset_df <- read.delim("GSSsubset.txt", as.is=TRUE, header=T) # Or this code:
 head(GSSsubset_df)
 
 GSSsubset_df <- read.delim("GSSsubset.txt", header=T, strings=F)
 head(GSSsubset_df)
 
 #Import data from Excel
 library(readxl)
 GSSsubset <- read_excel("GSSsubset.xlsx", sheet = "Sheet1")    
 head(GSSsubset)
                                               
# Import dataset: from folder with pathway
read.csv("full_path")
#Example (change pathway to your working directory)
gss <- read.csv("/home/erick/Documents/Projects/R/Essential Level/Session Two/Practicals/GSSsubset.csv")
gss

# Note R uses Forward Slash / in the directory path: C:/Users/R workshop
# For mac users, you can just copy and paste the path.
# For Windows users, you need to change all the back slash to forward slash

 #Import dataset: From A Comma Delimited Text File (.CSV)
# first row contains variable names, comma is separator
# assign the variable id to row names
# note the / instead of \ on MS Windows systems

 GssSubset_data <- read.table("c:/-...fullpath GSSsubset.csv", header=TRUE, sep=",", row.names="id")

#Importing data from other packages: SPSS- function read.sps
# install.packages("foreign", dependencies = TRUE)
 
 #Examples
library(foreign)
sleep_df <- read.spss("sleep.sav", use.value.label=TRUE, to.data.frame=TRUE)
head(sleep_df)

?sleep
sleep
require(stats)
## Student's paired t-test
with(sleep,
     t.test(extra[group == 1],
            extra[group == 2], paired = TRUE))

## The sleep *prolongations*
sleep1 <- with(sleep, extra[group == 2] - extra[group == 1])
summary(sleep1)
stripchart(sleep1, method = "stack", xlab = "hours",
           main = "Sleep prolongation (n = 10)")
boxplot(sleep1, horizontal = TRUE, add = TRUE,
        at = .6, pars = list(boxwex = 0.5, staplewex = 0.25))

#Sleep data
#This is real data file condensed from a study conducted to explore the prevalence and impact of sleep problems on various aspects of people's lives. Staff from a university in Melbourne, Australia were invited to complete a questionnaire containing questions about their sleep behavior (e.g. hours slept per night), sleep problems (e.g. difficulty getting to sleep) and the impact that these problems have on aspects of their lives (work, driving, relationships). The sample consisted of 271 respondents (55% female, 45% male) ranging in age from 18 to 84 years (mean=44yrs).


# Import data from Stata -function read.dta() from foreign package 
library(foreign)

census_df <- read.dta("census.dta") 
head(census_df)

#df is the name of data frame in R, and dataset.dta is the file name of Stata
#dataset we want to import.
#Import data from SAS
# install.packages("haven")
library(haven)
airline_df = read_sas("airline.sas7bdat")
head(airline_df)
 
# Exporting Data
# To A Tab Delimited Text File
write.table(GSSsubset, "GSSExported2.txt", sep="\t") 

# To an Excel Spreadsheet 

# install.packages("writexl")
library("writexl")
write_xlsx(GSSsubset, "GSSExported1.xlsx")

# Viewing/ Examining Data
# list objects in the working environment
   ls()
# list the variables in mydata
  names(GSSsubset)
# list the structure of mydata
   str(GSSsubset)
# list levels of factor v1 in mydata

GSSsubset$degree <- as.factor(GSSsubset$degree) #convert the variable to factor

levels(GSSsubset$degree)

# dimensions of an object (rows (cases, subjects ..) and columns(variables) in that order)
  dim(GSSsubset)

 # class of an object (numeric, matrix, dataframe, etc)
   class(GSSsubset)
 # print mydata
   GSSsubset
 # print first 10 rows of mydata
   head(GSSsubset, n=10)
 # print last 5 rows of mydata
   tail(GSSsubset, n=5)
   # How many rows are there in the dataset
nrow(GSSsubset)
# How many columns are there in the dataset
ncol(GSSsubset)

# What are the column names in the dataset - similar to   names(GSSsubset)
colnames(GSSsubset)
# What are the row names in the dataset
rownames(GSSsubset)
