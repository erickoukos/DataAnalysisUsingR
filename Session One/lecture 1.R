
# Data Analysis Using R
# Program R: Beginner

# Session 1: Introduction to R

# Get started: Creating an R  script
# Click File -> New File -> R Script
# The script editor opens with an empty script this is my first R script do some things
x = 34
y = 16
z = x + y # addition
w = y/x     # division
# display the results
x
y
z
w

# change x
x = "some text"

# display the results
x
y
z
w #why is w still giving us a value?

# To save: click File ->  Save as

# To open: double click on saved script file
# Run code: highlight/place cursor along code line and either: click run, or Press Ctrl + Enter (Windows) or Command + Enter (Mac)


# Basic Commands
x <- c(1, 6, 8, 10, 7, 5, 3, 14, 19, 6, 5, 1, 5, 3, NA)
max(x, na.rm = TRUE) # maximum removing missing data
min(x, na.rm = TRUE) # minimum removing missing data
mean(x, na.rm = TRUE) # mean removing missing data
median(x, na.rm = T) # median removing missing data
sum(x, na.rm = T) # sum removing missing data
var(x, na.rm = T) # variance removing missing data
sd(x, na.rm = T) # standard deviation removing missing data
length(x) # number of items
summary(x) # produce result summaries of data models ..
table(x) # tabulation or crosstabulation
x[5] # List or subsetting- here the 5th item of dataset x

# Useful Functions
str(mtcars)
class(mtcars) # class or type of an object
names(mtcars) # names

vector1 <- c(1, 2, 3) # vector for use in examples below
vector2 <- c(4, 5, 6) # vector for use in examples below
c(vector1, vector2) # combine objects into a vector
cbind(vector1, vector2) # combine objects as columns
rbind(vector1, vector2) # combine objects as rows

ls()    # list current objects in workspace
rm(vector1) # delete an object from workspace

newobject <- edit(mtcars) # edit copy and save a newobject
fix(mtcars) # edit in place- replace original

# Points to note
# An example
x <- c(1:10) # Make vector of numbers from 1 to 10

x[(x > 8) | (x < 5)] # x greater than 8 and less than 5
# yields 1 2 3 4 9 10

# How it works
x <- c(1:10)
x

x > 8

x < 5


x > 8 | x < 5

x[c(T, T, T, T, F, F, F, F, T, T)]    


# Points to note
# To list the objects that you have in your current R session use the function ls or the function objects.
ls()

# To list all objects starting with the letter x:
x2 = 9
y2 = 10
ls(pattern = "x")

# Use the function rm to remove one or more objects from your session.
rm(x, x2)


# Lets create two small vectors with data and a scatterplot, concatenate function or c(), groups things together

z2 <- c(1, 2, 3, 4, 5, 6)
z3 <- c(6, 8, 3, 5, 7, 1)
plot(z2, z3)
title("My first scatterplot")

# R as a calculator
x = sin(9)/75
y = log(x) + x^2
x
y
m <- matrix(c(1, 2, 4, 1), ncol = 2, byrow = T)
m

# Working directory
getwd() # print the current working directory


setwd(mydirectory) # change to mydirectory- insert computer pathway here
setwd("/home/erick/Documents/Projects/session_one")

# myData <- read.csv('CleanData.csv')
# head(myData)
# 
# Workspace
# session you can also explicitly save the workspace image.
# save to the current working directory

save.image(insertfile_name_and_path_here)
# just checking what the current working directory is
getwd()
## save to a specific file and location
save.image("/home/erickoukos/Downloads/Project R/Essential Level/Session One/Practicals/sessionone.R")

# work with your previous commands
history() # display last 25 commands
history(max.show=Inf) # display all previous commands

# save your command history
savehistory(file="sessiononeCommands") # default is ".Rhistory"
# recall your command history
loadhistory(file="sessiononeCommands") # default is ".Rhistory


# R Help

help.start() # general help
help(lm) # help about function lm
?lm         # same thing

apropos("lm") # list all function containing string lm
example(lm) # show an example of function lm

# search for function lm in help manuals and  archived mailing lists
RSiteSearch("lm")
# get vignettes on using installed packages
# Vignettes are long-form guide to your  package
vignette() # show available vingettes
vignette("ggplot2") # show specific vignette

# R Packages
# Use the function search to see a list of packages that are currently 
# attached to the system, this list is also called the search path.
search()

library(MASS)
require(ggplot2)

#Now the "shoes" data becomes available from Mass package
# This is a list of two vectors, giving the wear of shoes of 
# materials A and B for one foot each of ten boys.
shoes$A
str(shoes)     
shoes$B
###########################################################################
# The function library can also be used to list all the available
# libraries on your system with a short description. 
# Run the function without any arguments
library()

# Install one package
install.packages("graphics", dependencies = T)

# Several packages: just replace the package names
install.packages("graphics"); install.packages("moments");
install.packages("graphics")

# R Datasets
# R comes with a number of sample datasets that you can experiment with. 
# Type data( )  to see the available datasets. 
# The results will depend on which packages you have  loaded. 
data()    

# Example: for details on a sample dataset Co2
# Dataset on Carbon Dioxide uptake in grass plants

help(CO2) 

# R Conflicting objects
# R will not warn you when you use an existing name.
mean = 10
mean

# The object mean already exists in the base package, but is now masked by your object mean. To get a list of all   masked objects use the function conflicts.

conflicts()

# You can safely remove the object mean with the function rm() without risking deletion of the mean function. handle conflicts how?

# for instance rm() some conflicts in libraries
rm(mean)
# The function mean is now unmasked 
mean


# Data types: logical

x = c(3, 7, 1, 2)

x > 2 # TRUE if x is greater than 2

x == 2 #TRUE if x is equal to 2

!(x < 3) # TRUE is x is not (!) less than 3

which(x > 2)  # To get the location in a vector where values of x are > 2

# Data types: character/string
y = c("a", "erbc", "def")

length(y)

nchar(y)


y == "a"  # which of the strings is "a"

y == "b" # which of the strings is "b"

# Data types: factor
# Example - a family of two girls (1) and four boys (0),
kids = factor(c(1, 0, 1, 0, 0, 0), 
              levels = c(0, 1),
              labels = c("boy", "girl"))
kids
table(kids)
class(kids)

mode(kids)

# variable gender with 20 "male" entries and 
# 30 "female" entries

gender <- factor(c(rep("Male", 20), rep("Female", 30)))
summary(gender)

# OR

gender <- c(rep("male", 20), rep("female", 30)) # then
gender <- factor(gender)

# Exercise 1
# Create an object that stores gender as 20 1s and 30 2s and associates 1 = Female, 2 = Male internally (alphabetically)

# summary(gender)           


# Matrix - a vector with two-dimensional shape information.
xx <- matrix(1:6, 
            nrow = 3,
            ncol = 2)
xx

class(xx)

is.vector(xx) # Check if xx is a vector (not true)

is.matrix(xx) # check if xx is a matrix (true)

length(xx)

dim(xx)
dim(iris)

# Identify rows, columns or elements using subscripts. mtcars dataset available in R. The data was extracted from the 1974 Motor Trend 

# US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models).

?mtcars
head(mtcars)
mtcars[,4] # 4th column of matrix
mtcars[3,] # 3rd row of matrix
mtcars[2:4, 1:3] # rows 2,3,4 of columns 1,2,3

# Data types: vectors
a <- c(1, 2, 5.3, 6,-2 , 4) # numeric vector
b <- c("one", "two", "three") # character vector
c <- c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE) #logical vector

# Refer to elements of a vector using subscripts.
a[c(2,4)] # 2nd and 4th elements of vector



# Data types: Data frames
#The elements of a data frame can be numeric vectors, factor vectors, and
# logical vectors, but they must all be of the same length.
d <- c(1, 2, 3, 4)
e <- c("red", "white", "red", NA)
efr <- complete.cases(e)
efr
e[efr]

f <- c(TRUE, TRUE, TRUE, FALSE)

mydata <- data.frame(d, e, f) # A dataframe

names(mydata) <- c("ID","Color","Passed") #variable names


# There are a variety of ways to identify the elements of a dataframe .
mydata[2:3] # columns 2 and 3 of dataframe
mydata[c("Color", "Passed")] # columns Color and Passed from dataframe
mydata$Color # variable Passed in the dataframe


# Data types: Lists
# A list allows you to gather a variety of (possibly unrelated) objects under one name.

myList <- list(a = 1:10, 
              b = "def", 
              c(TRUE, FALSE, TRUE))
myList$a

myList$b

myList[[3]]

length(myList) # there are 3 elements in the list
class(myList) # the class is a list
names(myList) # are a, b and the empty character ""
myList[1:2] # returns a list with two elements
myList[1] # returns a list with one element. 
myList[[1]] # returns the first a vector with ten elements, the numbers 1, 2, ..., 10
length(myList[[1]])#returns the length of the first element


