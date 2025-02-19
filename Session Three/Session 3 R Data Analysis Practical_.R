# Data Analysis Using R: Session 3

# Session 3: Data Management
# Part 1: Common Data Management Options in R

# Sorting Data
# order() function used to sort dataframes- default is sorting ASCENDING.
# sorting examples using the mtcars dataset
attach(mtcars)
mpg

# sort by mpg
newdata <- mtcars[order(mpg),]
newdata

# sort by mpg and cyl
newdata <- mtcars[order(mpg, cyl),]
newdata
#Prepend the sorting variable by a minus sign to indicate DESCENDING order

#sort by mpg (ascending) and cyl (descending)
newdata <- mtcars[order(mpg, -cyl),]
newdata

detach(mtcars)

# Merging Data: Adding Columns

# To merge two data frames (datasets) horizontally, use the merge function. 
# Join two data frames by one or more common key variables (i.e., an inner join).
# merge two data frames by ID
# total <- merge(data frameA,data frameB,by="ID")

# merge two data frames by ID and Country
# total <- merge(dataframeA,dataframeB, by=c("ID","Country"))

# Examples: Two simple dataframes x and y

# Dataframe "x"
name <- c("John", "Paul", "George", "Ringo", "Stuart", "Pete")
instrument <- c("guitar", "bass", "guitar", "drums", "bass", "drums")

x <- data.frame(name, instrument)
x
# Dataframe "y"

name <- c("John", "Paul", "George", "Ringo", "Brian")
band <- c("TRUE", "TRUE", "TRUE", "TRUE", "FALSE")

y <- data.frame(name, band)
y

# Merging Data: Adding Columns
xy <- merge(x, 
            y,
            by = "name")

print(xy)


# Merging Data: Adding Rows

# To join two data frames (datasets) vertically, use the rbind function. 
# The two data frames must have the same variables, but they do not have to be in the same order.
# total <- rbind(dataframeA, dataframeB)

dataframeA <- mtcars[1:4,]
dataframeB <- mtcars[5:8,]
dataframe_both <- rbind(dataframeA, dataframeB) # combine objects as rows


# Aggregating Data
# Collapse data in R using one or more BY variables and a defined function.
# Example: aggregate data frame mtcars by cyl and vs, returning means for numeric variables

attach(mtcars) # to make the variables in the dataframe directy available in the workspace
aggData <- aggregate(mtcars, 
                     by = list(cyl,vs), 
                     FUN = mean, 
                     na.rm=TRUE)
print(aggData)
detach(mtcars)
export(mtcars, "myCars.csv")
# Reshaping Data: Transpose

# Use the t() function to transpose a matrix or a dataframe. 


# example using built-in dataset
mtcars
t(mtcars)


# Reshaping Data: The Reshape Package

# Creating the data frame
id <- c(1, 1, 2, 2)
time <- c(1, 2, 1, 2)
measure_1 <- c(5, 3, 6, 2)
measure_2 <- c(6, 5, 1, 4)

mydata <- data.frame(id, time, measure_1, measure_2)

print(mydata)

# Melt function
# install.packages("reshape", dependencies = T)
library(reshape)
mdata <- melt(mydata, 
              id = c("id","time"))

print(mdata)

# You must specify the variables needed to uniquely identify each measurement (ID and Time)

# Cast function
# Now that the data is in a melted form, it can be recast into any shape, using the cast() function.

# newdata <- cast(md, formula, FUN)

# Cast the melted data
# cast(data, formula, function)
 # Example 1. Average variable for each subject

subjmeans <- cast(mdata, id ~ variable, mean) 
print(subjmeans)

# Example 2. Average variable for each time
timemeans <- cast(mdata, time ~ variable, mean)
print(timemeans)

# Subsetting Data

# Subsetting Data: Selecting (Keeping) Variables

# Select variables v1, v2, v3
# myvars <- c("v1", "v2", "v3")
# newdata <- mydata[myvars]

myvars_mtcars <- c("mpg" , "cyl" , "disp")

newdata_mtcars <- mtcars[myvars_mtcars]
head(newdata_mtcars)

# select 1st and 5th thru 10th variables
# newdata <- mydata[c(1,5:10)]
newdata2_mtcars <- mtcars[c(1,5:10)]
head(newdata2_mtcars)

# Subsetting Data: Excluding (DROPPING)
      Variables
# exclude variables v1, v2, v3                 
# myvars <- names(mydata) %in% c("v1","v2", "v3")   
# newdata_mtcars <- mydata[!myvars]      

# Example: exclude variables am, gear, carb 

myvars <- names(mtcars) %in% c("am", "gear", "carb")

newdata_mtcars <- mtcars[!myvars]

head(newdata_mtcars)
        
# exclude 3rd and 5th variable         
# newdata <- mydata[c(-3,-5)]            

newdata_mtcars_2 <- mtcars[c(-3,-5)]

head(newdata_mtcars_2)

# delete variables v3 and v5
# mydata$v3 <- mydata$v5 <- NULL
# delete variables transmission (am) and gear

dataframeA$am <- dataframeA$gear <- NULL

print(dataframeA)


# Subsetting Data: Selecting Observations
# first 5 observations
newdata_mtcars_5 <- mtcars[1:5,]

head(newdata_mtcars_5)

# based on variable values where Number of carburetors =2 and  Miles/(US) gallon > 20.09
newdata_mtcars_carb_mpg <- mtcars[which(mtcars$carb == 2 & mtcars$mpg > 20.09), ]

print(newdata_mtcars_carb_mpg)

# or
attach(mtcars)
newdata_mtcars_carb_mpg <- mtcars[which(carb==2 & mpg > 20.09), ]
detach(mtcars)


# Subsetting Data: Selection using the Subset
# The subset() function is the easiest way to select variables and observations. 
# Example: select all rows that have a value of weight greater than or equal to 3.610 or wt less then 2.58. We keep the mpg, cyl and disp columns.

# using subset function
newdata_mtcars_wt <- subset(mtcars, wt >= 3.610 | wt < 2.58, 
                            select = c(mpg, cyl, disp, wt))
 
print(newdata_mtcars_wt)


# EaIn the next example, we select cars with miles per gallon greater than 20.09 and carburetors = 2 but we keep variables from horsepower to 1/4 mile time (hp, drat, wt and qsec).
# using subset function (part 2)

newdata_mtcars_range <- subset(mtcars, mtcars$carb == 2 & mtcars$mpg > 20.09, select = hp:qsec)

head(newdata_mtcars_range)

# Subsetting Data: Random Samples

# Use the sample() function to take a random sample of size n from a dataset.
# Example: take a random sample of size 15 from the dataset mtcars sample without replacement

mysample_mtcars <- mtcars[sample(1:nrow(mtcars), 15, replace = FALSE),]

dim(mysample_mtcars) # shows dimensions of new dataset i.e. 15 rows and 11 columns original was 32 rows

#######################################################
###Part 2: Transforming Your Data with dplyr      #####
#######################################################

# install.packages("dplyr")
library(dplyr)
library(tidyverse)
# Dplyr: select() function
# Objective: Reduce dataframe size to only desired variables for current task
# The select() function allows you to select and/or rename variables.
# Function:    select(data, ...)
# Same as:     data %>% select(...) |> 

# Read the provided "expenditure" data into R
expenditures <- read.delim("expenditures.txt", sep="")


# Example: our goal is to only assess the 5 most recent years worth of expenditure data.
# Applying the select() function we can select only the variables of concern.
sub.exp <- expenditures %>% select(Division, State, X2007:X2011)
head(sub.exp) # for brevity only display first 6 rows

# Dplyr: select( ) function

# We can also apply some of the special functions within select(). For
# instance we can select all variables that start with "X":
head(expenditures %>% select(starts_with("X")))


# Dplyr: filter( ) function
# Objective: Reduce rows/observations with matching conditions

# Example: Continuing with the sub.exp dataframe which includes only the recent 5 years worth of expenditures, we can filter by Division:
sub.exp %>% filter(Division == 6)

# Filtering by multiple criteria within a single logical expression (starwars is an R dataset)
filter(starwars, hair_color == "none" & eye_color == "black")

# Dplyr: group_by( ) function
# Objective: Group data by categorical variables

# Description: Often, observations are nested within groups or categories and our goals is to perform statistical analysis both at the observation level and also at the group level.
# The group_by() function allows us to create these categorical groupings.
# The group_by() function is a silent function. No observable manipulation of the data is performed after applying the function.
# The real importance of the group_by() function comes when we perform summary statistics

group.exp <- sub.exp %>% group_by(Division)
head(group.exp)

# Dplyr: summarise( ) function
# Objective: Perform summary statistics on variables
# Description: key goal of data management is to be able to support statistical analysis on the data.
# The summarise() function allows us to perform the majority of the initial summary statistics
# when performing exploratory data analysis.

# Lets get the mean expenditure value across all states in 2011

sub.exp %>% summarise(Mean_2011 = mean(X2011))

# Dplyr: summarise( ) function
# Examples: some more summary stats
sub.exp %>% summarise(Min = min(X2011, na.rm=TRUE),
          Median = median(X2011, na.rm=TRUE),
          Mean = mean(X2011, na.rm=TRUE),
          Var = var(X2011, na.rm=TRUE),
         SD = sd(X2011, na.rm=TRUE),
         Max = max(X2011, na.rm=TRUE))


# Dplyr: summarise( ) function
# Previous slide: useful summaries. Comparison of summary statistics at multiple levels reveals important insights.
# This is where the group_by() function comes in. Let's group by Division and see how the different regions compared in by 2010 and 2011.

sub.exp %>%
    group_by(Division)%>%
    summarise(Mean_2010 = mean(X2010, na.rm=TRUE),
          Mean_2011 = mean(X2011, na.rm=TRUE))

# Dplyr: arrange( ) function
# Objective: Order variable values
# Description: Often, we desire to view observations in rank order for a particular variable(s). The arrange() function allows us to order data by variables in accending or descending order.

# Examples: Sort mtcars data by cylinder and displacement
mtcars[with(mtcars, order(cyl, disp)), ]

# Same result using arrange: no need to use with(), as the context is implicit
# NOTE: plyr functions do NOT preserve row.names
arrange(mtcars, cyl, disp)

# Let's keep the row.names in this example
myCars = cbind(vehicle=row.names(mtcars), mtcars)
arrange(myCars, cyl, disp)

# Sort with displacement in descending order desc() option
arrange(myCars, cyl, desc(disp))


# Dplyr: join( ) functions

# Objective: Join two datasets together

# The multiple xxx_join() functions provide multiple ways to join dataframes.
# Examples: Two simple dataframes
# Dataframe "x" and "y"
# Dataframe "x"
name <- c("John", "Paul", "George", "Ringo", "Stuart", "Pete")
instrument <- c("guitar", "bass", "guitar", "drums", "bass", "drums")
x <- data.frame(name, instrument)

# Dataframe "y"
name <- c("John", "Paul", "George", "Ringo", "Brian")
band <- c("TRUE", "TRUE", "TRUE", "TRUE", "FALSE")
y <- data.frame(name, band)


# Dplyr: join( ) functions
# inner_join(): Include only rows in both x and y that have a matching value
inner_join(x,y)

# left_join(): Include all of x, and matching rows of y
left_join(x,y)

# semi_join(): Include rows of x that match y but only keep the columns from x
semi_join(x,y)

# anti_join(): Opposite of semi_join
anti_join(x,y)

