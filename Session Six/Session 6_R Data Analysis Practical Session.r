# Set the working directory (you will need to edit this to be the directory where you have stored the data files for this Chapter)


# Initiate packages

# install.packages("pacman", dependencies = T) # Install pacman package if you have not

library(pacman)

# Run the following R code:
# p_load() function in the pacman package checks if a package is installed if not it installs it and loads it. It is a wrapper for library and require.

pacman::p_load(Hmisc, polycor, ggm, ggplot2, boot, ppcor, dplyr, correlation)

install.packages("graph", repos = "https://bioconductor.org/packages/3.14/bioc")

install.packages("ggm", repos = "https://cran.rstudio.com/")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("graph")


# After executing this, we have loaded all the above packages


# --------Variance and covariance of adverts data---------
# Packets of sweets taken for each number of adverts watched 

adverts <- c(5, 4, 4, 6, 8)
packets <- c(8, 9, 10, 13, 15) 

advertData <- data.frame(adverts, packets)

# Variance
var(adverts)
var(packets)

# Step 1
# Mean of adverts = (5 + 4 + 4 + 6 + 8)/5 = 27/5 = 5.4

# Step 2
# Difference from the mean
# 5 - 5.4 = -0.4, 4 - 5.4 = -1.4, 4 - 5.4 = -1.4, 6 - 5.4 = 0.6, 8 - 5.4 = 2.6

# Step 3
# Square the differences:
# (-0.4)^2 = 0.16, -1.4 = 1.96

# Step 4 get the sum total of the squares
# Step 5, divide it by n - 1 = 2.8


# Covariance
cov(advertData)

advertData2 = advertData * 2
cor(advertData)
cor(advertData2)

cov(advertData2) #covariance is affected by scale of data

var(advertData2$adverts)
var(advertData2$packets)
# Show the strength between two variables visually

attach(mtcars)
plot(wt, mpg)

#...QUANTIFYING THE STRENGTH OF RELATIONSHIPS BY CALCULATING R2....

?cor()

#....cor() function
# cor(x,y, use = "everything", method = "correlation type")
# Method can be either "pearson", "kendall" or "spearman"
# With NAs

cor(wt, mpg)

#-----Dealing with missing cases

adverts <- c(5, 4, 4, 6, 8)
packetsNA <- c(8, 9, 10, NA, 15)
age <- c(5, 12, 16, 9, 14)
advertNA<-data.frame(adverts, packetsNA, age)


cor(advertNA, use = "everything",  method = "pearson")

cor(advertNA, use = "complete.obs",  method = "pearson")


# We can get a different type of correlation (e.g., Kendall's tau) by changing the method 
# command:


cor(advertNA, use = "complete.obs",  method = "kendall")

cor(advertNA, use = "complete.obs",  method = "spearman")

setwd("~/Projects/DataAnalysisUsingR/Session Six")
examData = read.csv("exam_anxiety.csv")
head(examData)

# The first issue we have is that some of the variables are not numeric (Gender) and others 
# are not meaningful numerically. We choose to subset the data and select 3 of the variables to work with


examData2 <- examData[, c("exam_grade", "anxiety", "revise")]
head(examData2)

# We can get the Pearson correlations between all continuous variables by specifying the dataframe (examData2):

cor(examData2, use = "complete.obs", method = "pearson")

#If we want a single correlation between a pair of variables (e.g., Exam and Anxiety) then 
#we'd specify both variables instead of the dataframe:

cor(examData2$exam_grade, examData2$anxiety, use = "complete.obs", method = 'pearson')

#......rcorr()..........

# While correlation coefficients can be interpreted on their own(strength and direction of a relationship) we might want to know the statistical significance of our correlation coefficient.The P-value is the probability that you would have found the same result if the null hypothesis were true . If this probability is lower than the conventional 5% (P<0.05) the correlation coefficient is called statistically significant.To get the p-values along with the coefficient value we can use the rcorr() function. 

??rcorr

#We need to convert our dataframe into a matrix using the as.matrix() command. 
# We can include only numeric variables so, just as we did above, we need to select only the 
# numeric variables within the examData dataframe. 
typeof(examData2)

examMatrix <- as.matrix(examData[, c("exam_grade", "anxiety", "revise")])

Hmisc::rcorr(examMatrix)
correlation_matrix<-Hmisc::rcorr(examMatrix)
correlation_matrix$P
correlation_matrix$r  #shows the r values
correlation_matrix$P  #shows actual p values
correlation_matrix$n  #shows the sample size

#We could combine the previous two commands into a single one:

correlation_matrix <- Hmisc::rcorr(as.matrix(examData[, c("exam_grade", "anxiety", "revise")]))


#The results show the same previously seen correlation
#In addition, we are given the sample size on which these correlations are based, and also a matrix of p-values that correspond to the matrix of correlation coefficients above. 

# Exam performance is negatively related to exam anxiety with a Pearson correlation coefficient of r = -0.44 and the significance value is less than .001 (it is approximately zero). This significance value tells us that the probability of getting a correlation coefficient of this value in a sample of 103 people if the null hypothesis were true (there was no relationship between these variables) is very low (close to zero in fact). Hence, we can gain confidence that there is a genuine 
# relationship between exam performance and anxiety. Our criterion for significance is usually 
# .05 so we can say that all of the correlation coefficients are significant.

#........cor.test()......

# It can also be very useful to look at confidence intervals for correlation coefficients. This we have to do one at a time (we can't do it for a whole dataframe or matrix). Let's look 
# at the correlation between exam performance (Exam) and exam anxiety (Anxiety). We can compute the confidence interval using cor.test()

?cor.test()

#cor.test(x,y, alternative = "string", method = "correlation type", conf.level = 0.95)

cor.test(examData$anxiety, examData$exam_grade)
cor.test(examData$revise, examData$exam_grade)
cor.test(examData$anxiety, examData$revise)

# Pearson correlation between exam performance and anxiety was -0.441, The results tell us that this was highly significantly different from zero, t(101) = -4.94, p < .001. 
# Most important, the 95% confidence ranged from -.585 to - .271, which does not cross zero. 


#..........R² (R-squared) The  coefficient of determination
# The correlation coefficient squared (known as the coefficient of determination, R²) is a measure of the amount of variability in one variable that is shared by the other. You can interpret the R² as the proportion of variation in the dependent variable that is predicted by the independent variable(s). It's value ranges from 0 to 1 and can be calculated by simply squaring R values

# For example we can produce a matrix of R² values by executing the code below

cor(examData2)^2

#Since R² is a measure of proportion of variation, we might want to see these values expressed as a percentage. For this we simply multiply the above code by 100:


cor(examData2)^2 * 100


#--------Spearman's Rho----------

#Spearman's correlation coefficient (Spearman, 1910), rs, is a non-parametric statistic and so can be used when the data have violated parametric assumptions such as non-normally distributed data. The test is also referred to as Spearman's rho 
# Spearman's test works by first ranking the data  
 
# The example used is from the World's Biggest Liar competition held annually at the Santon Bridge Inn in Wasdale (in the Lake District). 
# Each year locals are encouraged to attempt to tell the biggest lie in the world. Assume we wanted to test a theory that more creative people will be able to create taller tales. 68 past contestants from this competition were asked where they were placed in the competition (first, second, third, etc.) and were also given a creativity questionnaire (maximum score 60). The position in the competition is an ordinal variable because the places are categories but have a meaningful order (first place is better than second place and so on). Therefore, Spearman's correlation coefficient should be used.

liarData <- as.data.frame(read.csv("biggest_liar.csv"))

View(liarData)


#The procedure for doing a Spearman correlation is the same as for a Pearson correlation except that we need to specify that we want a Spearman correlation instead of Pearson,

#To obtain the correlation coefficient for a pair of variables we can execute:

cor(liarData$position, liarData$creativity, method = "spearman")

# We hypothesize that more creative people would tell better lies.
# Therefore, we predict that the correlation will be less than zero, and we can 
# reflect this prediction by using alternative = "less" in the command:

cor.test(liarData$position, 
         liarData$creativity, 
         alternative = "less", 
         method = "spearman")


#If we want a significance value for this correlation we could simply use cor.test(), 
# which has the advantage that we can set a directional hypothesis. 

cor.test(liarData$position, liarData$creativity, method = "spearman")


#--------Kendall's Tau----------
# Kendall's tau is another non-parametric correlation and it should be used rather than 
# Spearman's coefficient when you have a small data set with a large number of tied ranks. 
# This means that if you rank all of the scores and many scores have the same rank, then Kendall's tau should be used. 


cor(liarData$position, 
    liarData$creativity, 
    method = "kendall")

# We predict that the correlation will be less than zero, and we can reflect this prediction by using alternative = "less" in the command:

cor.test(liarData$position, 
         liarData$creativity, 
         alternative = "less", 
         method = "pearson")

# We can also use alternative = more. 
#Below we compare earlier pearson and kendall coefficient
# with alternative = "more" for the first data on number of adverts watched versus and packets of sweets bought

adverts<-c(5,4,4,6,8)
packets<-c(8,9,10,13,15) 
advertData<-data.frame(adverts, packets)

# Two sided test not assuming more adverts lead to more sweets bought
cor(advertData$adverts, advertData$packets, method = "pearson")

# One sided test testing if  more adverts lead to more sweets bought
# Note: alternative = "greater"

cor.test(advertData$adverts, 
         advertData$packets, 
         alternative = "greater", 
         method = "kendall")


#-------Point Biserial-----

#The point-biserial correlation coefficient, rpb, quantifies the relationship between a continuous variable and a variable that is a discrete dichotomy (one where there is no continuum underlying the two categories, such as dead or alive).

# The biserial correlation coefficient, rb, quantifies the relationship between a continuous variable and a variable that is a continuous dichotomy 
# (One where there is a continuum underlying the categories, such as passing or failing an exam 


# Example data catData studying the relationship between the gender of a cat and how much time it spent away from home. We heard that male cats disappeared for substantial amounts of time on long-distance roams around the neighborhood whereas female cats tended to be more homebound.
# There are three variables: 
# time, which is the number of hours that the cat spent away from home (in a week).
# gender, is the gender of the cat, coded as 1 for male and 0 for female.
# recode, is the gender of the cat but coded the opposite way around (i.e., 0 for male 
  # and 1 for female). 


catData <- read.csv("roaming_cats.csv")

head(catData)

str(catData)
levels(catData$sex)
library(forcats)
?as_factor
#Compute point-biserial correlation
catData <- catData |> 
  dplyr::mutate(sex = forcats::as_factor(sex)) |> 
  dplyr::mutate(sex_bin = ifelse(sex == "Male", 0, 1), sex_bin_recode = ifelse(sex == "Male", 1, 0))

head(catData)

catData |> 
dplyr::select(time, sex_bin) |> 
correlation::correlation()

cor.test(catData$time, catData$sex_bin)

catData %>%
dplyr::select(time, sex_bin_recode) %>%
correlation::correlation()

#...biserial correlation

#Using the polycor package and using the polyserial() function. 
# Simply specify the two variables of interest within this function 
#just as you have been doing for every other correlation 

polyserial(catData$time, catData$sex)


#---------------Partial and semi-partial correlation
# A partial correlation quantifies the relationship between two variables while controlling for the effects of a third variable on both variables in the original correlation.
# A semi-partial correlation quantifies the relationship between two variables while controlling for the effects of a third variable on only one of the variables in the original correlation.

#Exam Anxiety Data file: create a dataframe containing only the 
# three variables of interest. We will conduct a partial correlation between exam anxiety and exam performance while 'controlling' for the effect of revision time.

# Use the ggm package


# The general form of pcor() is:

#pcor(c("var1", "var2", "control1", "control2" etc.), var(dataframe))

# # For the current example, we want the correlation between exam anxiety and exam performance (so we list these variables first) controlling for exam revision 
# (so we list this revision variable afterwards).
?pcor()
pc<-ggm::pcor(c("exam_grade", "anxiety", "revise"), var(examData2))
pc
#We can see the value of R 2  in the console by executing:


pc^2

?pcor.test()
#The general form of pcor.test() is:   pcor(pcor object, number of control variables, sample size)
# Basically, you enter an object that you have created with pcor() 
# or you can put the pcor() command directly into the function). 
#We created a partial correlation object called pc, had only one control variable (Revise) 
#and there was a sample size of 103; 
# therefore, to see the significance of the partial correlation, we can execute:

ggm::pcor.test(pc, 1, 103)

#.......semipartial correlation

?spcor.test()
spcor.test(x=examData2$exam_grade, y=examData2$anxiety, z=examData2$revise)






