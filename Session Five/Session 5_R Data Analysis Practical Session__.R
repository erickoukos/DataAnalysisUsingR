
# ----Install and Load Packages-----

library(car)
library(ggplot2)
library(pastecs)
library(psych)
library(readxl)


# The music festival data:

# A Biologist worried about potential health effects of music  festivals, measured hygiene of 810 concert-goers over  the three days of a music festival. Hygiene measured using standardized index (from 0 to 4): 0 = you smell terribly	4 = you smell beautifully.


setwd("~/Projects/DataAnalysisUsingR/Session Five")

dlf <- read_excel("MusicFestival.xlsx")

names(dlf)
str(dlf)
dim(dlf)
head(dlf)

# Remove the outlier from the day1 hygiene score
summary(dlf$day1)
dlf$day1 <- ifelse(dlf$day1 > 20, NA, dlf$day1)


# Histograms for hygiene scores on day 1, day 2 and day 3.

# Histogram for day 1:

# First, produce the histogram for the normally distributed data (normal) and add a normal curve using the mean and standard deviation of the variable.

par(mfrow = c(2,3)) # Combine all six plots below in 1 plot

h1 <- hist(dlf$day1,
          probability = T, 
          breaks = 30, 
          main = "Histogram of hygiene score on day 1",
          xlab = "Hygiene score on day 1", 
          ylab = "Density")

# Now add a normal curve using the mean and standard deviation of the variable.

x = as.numeric(dlf$day1)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length = 40)

yfit <- dnorm(xfit, 
              mean = mean(x, na.rm = T),
              sd = sd(x, na.rm = T))

lines(xfit, 
      yfit, 
      col="blue", 
      lwd = 2)



# Histogram for day 2:

h <- hist(dlf$day2, 
          probability = T, 
          breaks = 30, 
          main = "Histogram of hygiene score on day 2",
          xlab = "Hygiene score on day 2", 
          ylab = "Density")

x = as.numeric(dlf$day2)

xfit <-seq(min(x, na.rm = T),
           max(x, na.rm = T),
           length = 40)

yfit <- dnorm(xfit, 
              mean = mean(x, na.rm = T), 
              sd=sd(x, na.rm = T))

lines(xfit, 
      yfit, 
      col="blue", 
      lwd = 2)



# Histogram for day 3:

h <- hist(dlf$day3,
          probability = T, 
          breaks = 30, 
          main="Histogram of hygiene score on day 2",
          xlab="Hygiene score on day 3", 
          ylab = "Density")

x = as.numeric(dlf$day3)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length=40)

yfit <- dnorm(xfit,
              mean = mean(x, na.rm = T),
              sd = sd(x, na.rm = T))

lines(xfit, 
      yfit, 
      col="blue", 
      lwd = 2)

# Q-Q Plot

# This graph plots the cumulative values we have in our data against the cumulative probability of a particular distribution (in this case we would specify a normal distribution). 

# If the data are normally distributed then the actual scores will have the same distribution as the score we expect from a normal distribution, and you'll get a  straight diagonal line. If values fall on the diagonal of the plot then the variable is normally distributed, but deviations from the diagonal show deviations from normality.

# Q-Q plot for day 1:

qqnorm(dlf$day1, 
       pch = 1, 
       frame = FALSE, 
       main = "Normal Q-Q Plot Day 1")

qqline(dlf$day1, 
       col = "steelblue", 
       lwd = 2)

# Q-Q plot for day 2:

qqnorm(dlf$day2, 
       pch = 1, 
       frame = FALSE, 
       main = "Normal Q-Q Plot Day 2")

qqline(dlf$day2, 
       col = "steelblue", 
       lwd = 2)

# Q-Q plot of the hygiene scores on day 3:
qqnorm(dlf$day3, 
       pch = 1, 
       frame = FALSE, 
       main = "Normal Q-Q Plot Day 3")

qqline(dlf$day3, 
       col = "steelblue", 
       lwd = 2)

dev.off() # Remember to run this so as to switch off the combined plotting

# Quantifying normality with numbers

# It is all very well to look at histograms, but they are subjective and open to abuse

# Therefore, having inspected the distribution of hygiene scores visually, we can move on to look at ways to quantify the shape of the distributions and to look for outliers. 

library(psych)		# load the psych library, if you haven't already, for the describe() function to work.

# Using the describe() function for a single variable.

describe(dlf$day1)

# Two alternative ways to describe multiple variables.

describe(cbind(dlf$day1, 
               dlf$day2, 
               dlf$day3))

describe(dlf[ ,c("day1", 
                 "day2", 
                 "day3")])

library(pastecs)

# In this function, we simply name our variable and by default (i.e., if we simply name a variable and don't include the other commands) we'll get a whole host of statistics including some basic ones such as the number of cases (because basic = TRUE by default) but not including statistics relating to the normal distribution (because norm = FALSE by default). 

# Specify basic = FALSE to get rid of these statistics, but in the current context it is useful to override the default and specify norm = TRUE so that we get statistics relating to the distribution of scores. Therefore, we could execute:

# Single variable
stat.desc(dlf$day1, 
          basic = FALSE, 
          norm = TRUE)

# Multiple variable - method 1

stat.desc(cbind(dlf$day1, 
                dlf$day2, 
                dlf$day3), 
          basic = FALSE, 
          norm = TRUE)

# Multiple variable - method 2 (subsetting and rounding off to 3 digits)

round(stat.desc(dlf[ , c("day1", 
                         "day2", 
                         "day3")], 
                basic = FALSE, 
                norm = TRUE), 
      digits = 3)


# Example 2 using R exam data

# This file contains data regarding students' performance on an R exam. Four variables were measured: exam (first- year R exam scores as a percentage), computer (measure of computer literacy as a percentage), lecture  (percentage of R lectures attended) and numeracy (a measure of numerical ability out of 15). 

# There is a variable called uni indicating whether the  student  attended  Sussex  University  or  Duncetown  University.  

# Let's begin by exploring the data as a whole.

# Read in rexam data
library(rio)
rexam <- import("RExam.xlsx")
head(rexam)
str(rexam)

# Set the variable uni to be a factor:

rexam$uni <- factor(rexam$uni, 
                  levels = c(0:1), 
                  labels = c("Duncetown University", "Sussex University"))

# Self test task:

round(stat.desc(rexam[, c("exam", 
                          "computer", 
                          "lectures", 
                          "numeracy")], 
                basic = FALSE, 
                norm = TRUE), 
      digits = 3)

# First year exam score histogram

h <- hist(rexam$exam,
          probability=T, 
          breaks = 30, 
          main="Histogram of Exam Anxiety: First Year Exam Scores",
          xlab="First Year Exam Score", 
          ylab = "Density")

x = as.numeric(rexam$exam)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length = 40)

yfit <- dnorm(xfit, 
              mean = mean(x, na.rm = T),
              sd = sd(x, na.rm = T))

lines(xfit, 
      yfit, 
      col="blue", 
      lwd = 2)


# Computer literacy histogram
h <- hist(rexam$computer, 
          probability = T,  
          breaks = 30, 
          main = "Histogram of Exam Anxiety: computer Literacy",
          xlab = "Computer Literacy", 
          ylab = "Density")

x = as.numeric(rexam$computer)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length=40)

yfit <- dnorm(xfit, 
              mean = mean(x, na.rm = T),
              sd=sd(x, na.rm = T))

lines(xfit, 
      yfit, 
      col="blue", 
      lwd = 2)

# The exam scores are very interesting because this distribution is quite clearly not normal; in fact, it looks suspiciously bimodal (there are two peaks, indicative of two modes)- we come back to this later in the codes 

# Percentage of Lectures Attended

h <- hist(rexam$lectures, 
          probability=T, 
          breaks = 30, 
          main="Histogram of Exam Anxiety: Percentage of Lectures Attended",
          xlab="Percentage of Lectures Attended", 
          ylab = "Density")

x = as.numeric(rexam$lectures)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length=40)

yfit <- dnorm(xfit, 
              mean = mean(x, na.rm = T),
              sd = sd(x, na.rm = T))

lines(xfit, 
      yfit, 
      col="blue", 
      lwd = 2)

# Numeracy
h <- hist(rexam$numeracy, 
          probability = T, 
          breaks = 30, 
          main = "Histogram of Exam Anxiety: Numeracy"
          ,xlab="Numeracy", 
          ylab = "Density")

x = as.numeric(rexam$numeracy)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length=40)

yfit <- dnorm(xfit,
              mean = mean(x, na.rm = T),
              sd = sd(x, na.rm = T))

lines(xfit, 
      yfit, 
      col="blue", 
      lwd = 2)


# Use by() to get descriptives for one variable, split by uni
by(data = rexam$exam, 
   INDICES = rexam$uni, 
   FUN = describe)

by(rexam$exam, 
   rexam$uni, 
   stat.desc, 
   basic = FALSE, 
   norm = TRUE)

#Use by() to get descriptives for two variables, split by uni

by(cbind(data = rexam$exam, 
         data=rexam$numeracy), 
   rexam$uni, 
   describe)

by(rexam[, c("exam", "numeracy")], 
   rexam$uni, 
   stat.desc,
   basic = FALSE, 
   norm = TRUE)


# Use describe for four variables in the rexam dataframe.
describe(cbind(rexam$exam, 
               rexam$computer, 
               rexam$lectures, 
               rexam$numeracy))

# Use by() to get descriptives for four variables, split by uni
by(data=cbind(rexam$exam, 
              rexam$computer, 
              rexam$lectures, 
              rexam$numeracy), 
   rexam$uni, describe)


# Self test:
# Use by() to get descriptives for computer literacy and percentage of lectures attended, split by uni

by(cbind(data = rexam$computer, 
         data = rexam$lectures), 
   rexam$uni, describe)

by(rexam[, c("computer", "lectures")], 
   rexam$uni, 
   stat.desc, 
   basic = FALSE, 
   norm = TRUE)



# Using subset to plot histograms for different groups:

dunceData <- subset(rexam, 
                  rexam$uni == "Duncetown University")

sussexData <- subset(rexam, 
                     rexam$uni == "Sussex University")

h <- hist(dunceData$numeracy, 
          probability=T, 
          breaks = 10, 
          main="Histogram of numeracy for Duncetown University students",
          xlab="Numeracy Score", 
          ylab = "Density")

x = as.numeric(dunceData$numeracy)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length=40)

yfit <- dnorm(xfit, 
              mean = mean(x, na.rm = T), 
              sd = sd(x, na.rm = T))

lines(xfit, yfit, col="blue", lwd=2)



h <- hist(dunceData$exam, 
          probability = T, 
          breaks = 35, 
          main = "Histogram of first year exam score for Duncetown University students",
          xlab = "First Year Exam Score", 
          ylab = "Density")

x = as.numeric(dunceData$exam)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length = 40)

yfit <- dnorm(xfit, 
              mean = mean(x, na.rm = T),
              sd=sd(x, na.rm = T))

lines(xfit, 
      yfit, 
      col = "blue",  
      lwd = 2)


h <- hist(sussexData$numeracy, 
          probability=T, 
          breaks = 10, 
          main = "Histogram of numeracy for Sussex University students",
          xlab = "Numeracy Score", 
          ylab = "Density")

x = as.numeric(sussexData$numeracy)

xfit <- seq(min(x, na.rm = T),
            max(x, na.rm = T),
            length = 40)

yfit<-dnorm(xfit,
            mean = mean(x, na.rm = T),
            sd = sd(x, na.rm = T))

lines(xfit, yfit, col="blue", lwd=2)


h <- hist(sussexData$exam, 
          probability=T, 
          breaks = 35, main = "Histogram of first year exam score for Sussex University students",
          xlab="First Year Exam Score", 
          ylab = "Density")

x = as.numeric(sussexData$exam)

xfit <- seq(min(x, na.rm = T), 
            max(x, na.rm = T),length=40)

yfit <- dnorm(xfit,
              mean = mean(x, na.rm = T),
              sd=sd(x, na.rm = T))

lines(xfit, yfit, col="blue", lwd=2)

# Note: the exam marks the distributions are both fairly normal. This seems odd because the overall distribution was bimodal. However, it starts to make sense when you consider that for Duncetown the distribution is centred on a mark of about 40%, but for Sussex the distribution is centred on a mark of about 76%. This illustrates how important it is to look at distributions within groups. If we were interested in comparing Duncetown to Sussex it wouldn't matter that overall the distribution of scores was bimodal; all that's important is 
# that each group comes from a normal distribution, and in this case it appears to be true. 
# When the two samples are combined, these two normal distributions create a bimodal 
# one (one of the modes being around the centre of the Duncetown distribution, and the 
# other being around the centre of the Sussex data). 

########################################
# self test:

dunceData<-subset(rexam, rexam$uni==0)
sussexData<-subset(rexam, rexam$uni==1)


#Shapiro-Wilks test for exam and numeracy for whole sample
shapiro.test(rexam$exam)
shapiro.test(rexam$numeracy)

#Shapiro-Wilks test for exam and numeracy split by university
by(rexam$exam, rexam$uni, shapiro.test)
by(rexam$numeracy, rexam$uni, shapiro.test)

#qqplots for the two variables
qqnorm(rexam$exam, pch = 1, frame = FALSE, main = "First year score")
qqline(rexam$exam, col = "steelblue", lwd = 2)

qqnorm(rexam$numeracy, pch = 1, frame = FALSE, main = "Numeracy")
qqline(rexam$numeracy, col = "steelblue", lwd = 2)


#Levene's test for comparison of variances of exam scores in the two universities.
leveneTest(rexam$exam, rexam$uni)
leveneTest(rexam$exam, rexam$uni, center = mean)
leveneTest(rexam$numeracy, rexam$uni)


#Data transformations

#########Log, square root, and reciprocal transformation:
dlf$day1LessThanOne <- dlf$day1 < 1
dlf$day1LessThanorEqualOne <- dlf$day1 <= 1
dlf$day1GreaterThanOne <- dlf$day1 > 1
dlf$day1GreaterThanorEqualOne <- dlf$day1 >= 1

#self-help tasks
dlf$logday1 <- log(dlf$day1 + 1)
dlf$logday2 <- log(dlf$day2 + 1)
dlf$logday3 <- log(dlf$day3 + 1)

#Histograms of the log transformed scores:

#Histogram for logday1


# Log Transformed Hygiene Score on Day 1

h <- hist(dlf$logday1,probability=T, breaks = 30, main="Log Transformed Hygiene Score on Day 1",xlab="Hygiene score on day 1", ylab = "Density")

x = as.numeric(dlf$logday1)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)



#Histogram for logday2:

h <- hist(dlf$logday2,probability=T, breaks = 30, main="Histogram of hygiene score on day 2",xlab="Log Transformed Hygiene Score on Day 2", ylab = "Density")

x = as.numeric(dlf$logday2)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)



#Histogram for logday3:

h <- hist(dlf$logday3,probability=T, breaks = 30, main="Log Transformed Hygiene Score on Day 3",xlab="Hygiene score on day 3", ylab = "Density")

x = as.numeric(dlf$logday3)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)


#Create square root scores

dlf$sqrtday1 <- sqrt(dlf$day1)
dlf$sqrtday2 <- sqrt(dlf$day2)
dlf$sqrtday3 <- sqrt(dlf$day3)

#Histograms of the square root transformed scores:

#Histogram for sqrtday1:

h <- hist(dlf$sqrtday1,probability=T, breaks = 30, main="Square Root of Hygiene Score on Day 1",xlab="Hygiene score on day 1", ylab = "Density")

x = as.numeric(dlf$sqrtday1)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)


#Histogram for sqrtday2:

h <- hist(dlf$sqrtday2,probability=T, breaks = 30, main="Square Root of Hygiene Score on Day 1",xlab="Hygiene score on day 1", ylab = "Density")

x = as.numeric(dlf$sqrtday2)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)

#Histogram for sqrtday3:

h <- hist(dlf$sqrtday3,probability=T, breaks = 30, main="Square Root of Hygiene Score on Day 3",xlab="Hygiene score on day 3", ylab = "Density")

x = as.numeric(dlf$sqrtday3)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)


#Create reciprocal scores

dlf$recday1 <- 1/(dlf$day1 + 1)
dlf$recday2 <- 1/(dlf$day2 + 1)
dlf$recday3 <- 1/(dlf$day3 + 1)

#Histograms of the reciprocal transformed scores:

#Histogram for recday1:

h <- hist(dlf$recday1,probability=T, breaks = 30, main="Reciprocal of of Hygiene Score on Day 1",xlab="Hygiene score on day 1", ylab = "Density")

x = as.numeric(dlf$recday1)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)


#Histogram for recday2:

h <- hist(dlf$recday2,probability=T, breaks = 30, main="Reciprocal of of Hygiene Score on Day 2",xlab="Hygiene score on day 2", ylab = "Density")

x = as.numeric(dlf$recday2)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)

#Histogram for recday3:
h <- hist(dlf$recday3,probability=T, breaks = 30, main="Reciprocal of of Hygiene Score on Day 3",xlab="Hygiene score on day 3", ylab = "Density")

x = as.numeric(dlf$recday3)
xfit<-seq(min(x, na.rm = T),max(x, na.rm = T),length=40)
yfit<-dnorm(xfit,mean=mean(x, na.rm = T),sd=sd(x, na.rm = T))
lines(xfit, yfit, col="blue", lwd=2)


