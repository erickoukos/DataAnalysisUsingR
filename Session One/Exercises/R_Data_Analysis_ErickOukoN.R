# Exercise 1
# We will work from an R Script during the course. This script will be saved regularly to preserve work completed in previous sessions. Open and save a new R script and give it the name “R_Data_Analysis_YourName”


# Exercise 2
# It is preferable in many instances to redirect R to a working directory which is usually a  preferred folder in your project where you save the project information. This will allow for fast saving of plots, processed data, workspace etc and reading files without inserting the full folder path.


# a) Print the current working directory

getwd()
# [1] "/home/erick/Documents/Projects/session_one"

# b) Set your working directory to the R folder which you have dedicated to the course and check again to confirm

setwd("/home/erick/Documents/Projects/session_one")


# Exercise 3
# R contains a dataset called InsectSprays.
# a) Use help() function to inspect and describe the dataset here as well as the variables included.

help("InsectSprays")

# Description
# The counts of insects in agricultural experimental units treated with different insecticides.

# It is a data frame with 72 observations on 2 variables.

# [,1]	count	- numeric	Insect count
# [,2]	spray	- factor	The type of spray

# b) Use the function head() to inspect the first rows of the dataset, tail() to inspect the last rows and View() to open whole dataset.

head(InsectSprays)
tail(InsectSprays)
View(InsectSprays)


# c) Find the maximum, minimum, mean, median, sum, variance and standard deviation of the variable “count” in the dataset InsectSprays

summary(InsectSprays)

attach(InsectSprays)
max(count)# Maximum
min(count)# Minimum
mean(count)# Mean
median(count) # Median
sum(count) # Sum
var(count) # Variance
sd(count) # Standard Deviation
detach(InsectSprays)

attach(InsectSprays)
# d) How many values of count variable are greater than 20 and less than 5 in the InsectSprays dataset?


count[(count > 20) && (count < 5)]

count[count > 20]
count[count < 5]

length()


# e) Print out the following:
# ●Second column of the dataset
InsectSprays[, 2]
# ●Third row of the dataset
InsectSprays[3, ]
# ●Rows 6, 8, 10 and columns 1, 2 of the dataset

InsectSprays[c(6, 8, 10), c(1, 2)]

# Exercise 4
# You would like to use the function “sd” in R but you are not sure about some of its details. Use R help options to ask for help about the function “sd”, list all functions that contain “sd” and to obtain examples where you can use it

?sd
apropos("sd")
example(sd)

# Exercise 5
# Make a dataset (factor) composed of 40 variables for marital status “married”,  30 variables for  status “single” and 30 variables for status “won’t say”. Inspect this dataset using summary() function.

maritalStatus <- c(rep("Married", 40), 
                   rep("Single", 30),
                   rep("Won't Say", 30))
maritalStatus <- factor(maritalStatus)
maritalStatus

marital_status <- factor(c(rep("Married", 40),
                          rep("Single", 30), 
                           rep("Won't Say", 30)))


# Exercise 6
# Make and name a matrix consisting of the numbers between 50 and 60 with 2 rows and 5 columns. Inspect whether it is a matrix, its length and dimensions

matrixMain <- matrix(c(50:59), nrow = 2, ncol = 5)
matrixMain
is.matrix(matrixMain)
length(matrixMain)
dim(matrixMain)

apropos("sd")
