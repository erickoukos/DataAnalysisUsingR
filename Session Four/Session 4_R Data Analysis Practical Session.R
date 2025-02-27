#  Data Analysis Using R - Ploting
# Introduction: generic plot types in R

setwd("~/Documents/Projects/DataAnalysisUsingR/Session Four")
# Examples

x <- 1:10
y <- x*x

plot(x, 
     y, 
     type = "b")

plot(x, 
     y, 
     type = "h")

plot(x,
     y, 
     type = "s")

# Creating a Graph
attach(mtcars)
plot(x = wt, 
     y = mpg,
     main = "Graph of mpg vs wt",
     pch = 18, 
     frame = T, 
     xlab = "Weight",
     ylab = "Miles Per Gallon", 
     col = "violet")

# Saving graphs: RStudio Plots Panel
# In RStudio exported the plot from plot panel (lower right-pannel).
# Plots panel -> Export - > Save as Image or Save as PDF
# Then choose directory and change file name

# Saving graphs: R codes to redirect graphs to your working directory
# Open a pdf file
# 1. Specify files to save your image using a
# function such as jpeg(), png(), svg() or pdf().   
pdf("rplot.pdf")
# Additional argument indicating the width and the 
# height of the image can be also used.      
# 2. Create a plot

plot(x = wt, 
     y = mpg, 
     pch = 21,
     frame = FALSE, 
     xlab = "wt", 
     ylab = "mpg", 
     col ="#181ed6") # hex code

dev.off()

# 3. Close the pdf file
dev.off()

 
# Example 2: saving as jpeg file
# 1. Open jpeg file
jpeg("rplot.jpg", width = 350, height = 350)

# 2. Create the plot
plot(x = mtcars$wt, 
     y = mtcars$mpg, 
     pch = 16, 
     frame = FALSE, 
     xlab = "wt", 
     ylab = "mpg", 
     col = "#2E9FDF")
# 3. Close the file 
dev.off()


# Create histogram plots: hist()
# A histogram can be created using the function hist()
# Example:
x <- mtcars$mpg

hist(x, 
     col = "#961b32", 
     frame = FALSE)

#Create histogram plots: hist()
# Change the number of breaks

hist(x, 
     col = "steelblue", 
     frame = FALSE, 
     breaks = 5)


# Histograms can be a poor method for determining the shape of a distribution because it is so strongly affected by the number of bins/breaks used.
# Kernel density plots are usually a much more effective than histograms 
# The function density() is used to estimate kernel density.
# Compute the density data
densPlot <- density(mtcars$mpg)

# plot density
plot(densPlot, 
     frame = FALSE, 
     col = "steelblue", 
     main = "Density plot of mpg")


# Fill the density plot using polygon()
plot(densPlot, 
     frame = FALSE, 
     col = "steelblue", 
     main = "Density plot of mpg")

polygon(densPlot, col = "steelblue")


# Dot Plots: dotchart()
# The function dotchart() is used to draw a cleveland dot plot.
# dotchart(x, labels = NULL, groups = NULL, gcolor = par("fg"), color = par("fg"))
# Dot chart of a single numeric vector

dotchart(mpg, 
         labels = row.names(mtcars), 
         cex = .6, # Character Expansion
         xlab = "Miles Per Gallon")

# Plot and color by groups cyl
# Groups
grps <- as.factor(mtcars$cyl)

#Colours for each group: "#999999", "#E69F00" and "#56B4E9" are colour codes in R

my_cols <- c("#999999", "#E69F00", "#56B4E9")

#Plot
dotchart(mpg, 
         labels = row.names(mtcars), 
         groups = grps, 
         gcolor = my_cols, 
         color = my_cols[grps], 
         cex = 0.6, 
         pch = 19, 
         xlab = "mpg")

# Dot chart of a matrix 
# The dataset VADeaths consists of Death rates per 1000 in Virginia in 1940.
# The death rates are measured per 1000 population per year. 
# They are cross-classified by age group (rows) and population group (columns). 
# The age groups are: 50-54, 55-59, 60-64, 65-69, 70-74 and the population groups 
# are Rural/Male, Rural/Female, Urban/Male and Urban/Female.

dotchart(VADeaths, 
cex = 0.6, 
main = "Death Rates in Virginia - 1940")

# Bar Plots
# Create barplots with the barplot(height) function height is a vector or matrix

# Bar Plots: Basic
# Subset
peoples <- VADeaths[1:3, 1]

peoples
## 50-54 55-59 60-64
## 11.7 18.1 26.9

# Bar plot of one variable
barplot(peoples)
# Horizontal bar plot (adding the argument horiz = TRUE)
barplot(peoples, 
        horiz = TRUE)

#Change group names: using argument names.arg = c("A", "B", "C")
barplot(peoples, 
        names.arg = c("A", "B", "C"))

# Change color
# Change border and fill color using one single color
barplot(peoples, 
        col = "white", 
        border = "steelblue")

# Change the color of border.
# Use different colors for each group

barplot(peoples, 
        col = "white",
    border = c("#999999", "#E69F00", "#56B4E9"))

# Change fill color : single color

barplot(peoples, 
        col = "steelblue")

# Change fill color: multiple colors
barplot(peoples, 
        col = c("#999999", "#E69F00", "#56B4E9"))

# Bar Plots
# Change main title and axis labels
# Change axis titles
# Change color (col = "gray") and remove frame
barplot(peoples, 
main = "Death Rates in Virginia",  
xlab = "Age", 
ylab = "Rate")


# Stacked bar plots
barplot(VADeaths, 
        col = c("lightblue", "mistyrose", "lightcyan", "lavender",
"cornsilk"),    
legend = rownames(VADeaths))

# Grouped bar plots

barplot(VADeaths, 
        col = c("lightblue", "mistyrose", "lightcyan",
"lavender", "cornsilk"), 
legend = rownames(VADeaths),
beside = TRUE)

######################################################
# Bar Plots
# It's also possible to add legends to a plot using the
# function legend() as follow.
# Define a set of colors
my_colors <- c("lightblue", "mistyrose", "lightcyan",
            "lavender", "cornsilk")
# Bar plot
barplot(VADeaths, 
        col = my_colors, 
        beside = TRUE)

# Add legend
legend("topleft", 
       legend = rownames(VADeaths),
       fill = my_colors, 
       box.lty = 0, 
       cex = 0.8)

# Notes:
# box.lty = 0: Remove the box around the legend
# cex = 0.8: legend text size


#########Line Plots: plot() and lines()#####################
# The simplified format of plot() and lines() is as follow.   
# plot(x, y, type = "l", lty = 1)                             
# lines(x, y, type = "l", lty = 1)                           
# x, y: coordinate vectors of points to join                  


# Create some variables
x <- 1:10
y1 <- x*x
y2 <- 2*y1
# Create a basic stair steps plot
plot(x, y1, type = "s")
# Show both points and line
plot(x, 
     y1, 
     type = "b", 
     pch = 11, 
     col = "red",
     xlab = "x", 
     ylab = "y")


# Multiple lines 
# Create a first line
plot(x, 
     y1, 
     type = "b", 
     frame = FALSE, 
     pch = 11,
     col = "red", 
     xlab = "x", 
     ylab = "y")

# Add a second line
  lines(x, 
        y2, 
        pch = 18, 
        col = "blue", 
        type = "b",
        lty = 2)
  
# Add a legend to the plot
  legend("topleft", 
         legend = c("Line 1", "Line 2"),
         col=c("red", "blue"), 
         lty = 1:2, 
         cex=0.8)

  
########################################Pie Charts
# Pie charts are not recommended: their features are somewhat limited.
# Pie charts are created with the function pie(x, labels=)
# Pie Charts: basic pie chart
# Create some data
df <- data.frame(
 group = c("Male", "Female", "Child"),
 value = c(25, 25, 50)
 )

df

pie(df$value, 
    labels = df$group, radius = 0.7)

# Pie Charts: Change colors


pie(df$value, 
    labels = df$group, 
    radius = 1, col = c("#999999", "#E69F00", "#56B4E9"))


# Pie Charts: Create 3D pie charts: plotix::pie3D()
# The function pie3D()[in plotrix package] 
# Install plotrix package (uncomment code by removing # symbol if not already installed)
# install.packages("plotrix")
# 3D pie chart
library(plotrix)

pie3D(df$value, 
      labels = df$group, 
      radius = 1, 
      col = c("#999999", "#E69F00", "#56B4E9"))


# 3D Exploded Pie Chart. Can change radius (radiud=) and separation gaps (explode=)


pie3D(df$value, 
      labels = df$group, 
      radius = 1.8,
      col = c("#999999", "#E69F00", "#56B4E9"),
      explode = 0.1)

######################################Boxplots
# The format is: boxplot(x, data=),
#Example formula is y~group - a separate boxplot for numeric variable y is generated for each
#value of group.
# Here, we will use the R built-in ToothGrowth data set.

# Box plot of one variable

boxplot(ToothGrowth$len)

# Box plots by groups (dose)
# remove frame
boxplot(len ~ dose, data = ToothGrowth, frame = FALSE)

# Horizontal box plots
boxplot(len ~ dose, data = ToothGrowth, frame = FALSE,
    horizontal = TRUE)

# Notched box plots
boxplot(len ~ dose, data = ToothGrowth, frame = FALSE,
    notch = TRUE)

# Boxplots: Change group names
boxplot(len ~ dose, data = ToothGrowth, frame
= FALSE, names = c("D0.5", "D1", "D2"))

# Boxplots: Change color

# Change the color of border using one single color

boxplot(len ~ dose, data = ToothGrowth, frame = FALSE,
border = "steelblue")

# Change the color of border.

# Use different colors for each group

boxplot(len ~ dose, data = ToothGrowth, frame = FALSE,

    border = c("#999999", "#E69F00", "#56B4E9"))

# Change fill color : single color

boxplot(len ~ dose, data = ToothGrowth, frame = FALSE,
col = "steelblue")

# Change fill color: multiple colors

boxplot(len ~ dose, data = ToothGrowth, frame = FALSE,
col = c("#999999", "#E69F00", "#56B4E9"))


# Box plot with MULTIPLE GROUPS

boxplot(len ~ supp*dose, data = ToothGrowth,
    col = c("white", "steelblue"), frame = FALSE)

# Multiple customizations
# Change main title and axis labels
# Change axis titles
# Change color (col = "gray") and remove frame
# Create notched box plot
boxplot(len ~ dose, 
        data = ToothGrowth,
        main = "Plot of length by dose",
        xlab = "Dose (mg)", ylab = "Length",
        col = "lightgray", 
        frame = FALSE)


##############################Scatterplots
# Plotting a bivariate relationship- relationships between two variables
# Scatter plots can be created using the function plot(x, y).
# The function lm() can be used to fit linear models between y and x.
# A regression line can be added on the plot using the function abline(), 
# which takes the output of lm() as an argument.
# Smoothing lines can be added using the function loess().

# Scatterplots: basic
attach(mtcars)
# Plot with main and axis titles
# Change point shape (pch = 19) and remove frame.


plot(wt, 
     mpg, 
     main = "Scatterplot Example",  
     xlab = "Car Weight ", 
     ylab = "Miles Per Gallon ",
     pch = 19, 
     frame=FALSE)



# Add regression line
plot(wt, 
     mpg, 
     main="Scatterplot Example",  
     xlab="Car Weight ",
     ylab="Miles Per Gallon ", 
     pch=19, 
     frame=FALSE)


# Add fit lines
abline(lm(mpg ~ wt), col="red") # regression line (y~x)
lines(lowess(wt,mpg), col="blue") # lowess line (x,y)

# Statistical note: LOWESS (Locally Weighted Scatterplot Smoothing), 
# sometimes called LOESS (locally weighted smoothing), is a popular tool
# used in regression analysis that creates a smooth line through a timeplot 
# or scatter plot to help you to see relationship between variables and foresee trends.


# Enhanced scatter plots: car::scatterplot()
# The function scatterplot() [in car package] makes enhanced scatter plots, with:
#- box plots in the margins, 
#- a non-parametric regression smooth, 
#- smoothed conditional spread, 
#- outlier identification, and a regression line

# Install car package:
# install.packages("car")
# Use scatterplot() function:
library("car")
scatterplot(wt ~ mpg, data = mtcars)

# Scatterplots: grouped
# Scatter plot by groups ("cyl")
scatterplot(wt ~ mpg | cyl, 
            data = mtcars,
            smoother = FALSE, 
            grid = FALSE, 
            frame = FALSE)

# Scatterplots: 3D
# Function scatterplot3D [in scatterplot3D package can be used].
# The following R code plots a 3D scatter plot using iris data set found in R
# Prepare the data set
x <- iris$Sepal.Length
y <- iris$Sepal.Width
z <- iris$Petal.Length
grps <- as.factor(iris$Species)
# Plot
library(scatterplot3d)

scatterplot3d(x, y, z, pch = 16)

# Scatterplots: 3D- Change color by groups
# add grids and remove the box around the plot
# Change axis labels: xlab, ylab and zlab
colors <- c("#999999", "#E69F00", "#56B4E9")
scatterplot3d(x, y, z, pch = 16, color =
colors[grps], grid = TRUE, box = FALSE, xlab =
"Sepal length", ylab = "Sepal width", zlab =
"Petal length")



# Advanced Graphics
# Set a graphical parameter using par()
par()        # view current settings
opar <- par() # make a copy of current settings so we can use it to restore
par(col.lab="red") # red x and y labels
hist(mtcars$mpg) # create a plot with these new settings
par(opar)       # restore original settings


#Graphical Parameters
# Another approach is to set a graphical parameter within the plotting function
hist(mtcars$mpg, col.lab="red")

# Hint see the help for a specific high level plotting function e.g. help(plot), 
# help(hist) or help(boxplot) to determine which graphical parameters can be set this way.
# Graphical Parameters
# An Axis Example
# specify the data
x <- c(1:10)
y <- x
z <- 10/x
# create extra margin room on the right for an axis
par(mar=c(5, 4, 4, 8) + 0.1)

# Note: this numerical vector of the form c(bottom, left, top, right) 
# which gives the number of lines of margin to be specified on the four 
# sides of the plot. The default is c(5, 4, 4, 2) + 0.1. In the above case, the  
# default for the right side of the plot of 2 is changed to 8

# plot x vs. y
plot(x, y,type="b", pch=21, col="red", yaxt="n", lty=3, xlab="", ylab="", main = "")
# add x vs. 1/x
lines(x, z, type="b", pch=22, col="blue", lty=2)
# draw an axis on the left
axis(2, at=x,labels=x, col.axis="red", las=2)
# draw an axis on the right, with smaller text and ticks
axis(4, at=z,labels=round(z,digits=2),col.axis="blue", las=2, cex.axis=0.7, tck=-.01)
# add a title for the right axis
mtext("y=1/x", 
      side=4, 
      line=3, 
      cex.lab=1, 
      las=2, 
      col="blue")
# add a main title and bottom and left axis labels
title("An Example of Creative Axes", xlab="X values", ylab="Y=X")
                                               
# Graphical Parameters: reference Lines
# Add reference lines to a graph using the abline( ) function.
# abline(h=yvalues, v=xvalues)
# Other graphical parameters (such as line type, color, and width)
#     can also be specified in the abline( ) function.
   # add solid horizontal lines at y=1,5,7
     abline(h=c(1,5,7))
# add dashed blue verical lines at x = 1,3,5,7,9
abline(v=seq(1,10,2),
       lty=2,
       col="blue")
                      

# Graphical Parameters
# Legend Example
attach(mtcars)
boxplot(mpg ~ cyl, 
        main="Milage by Car Weight",
        yaxt="n", 
        xlab="Milage", 
        horizontal=TRUE,
        col=terrain.colors(3))

legend("topright", inset=.05, title="Number of
     Cylinders", c("4","6","8"), fill=terrain.colors(3), horiz=TRUE, box.lty = 1)


# Graphical Parameters: Combining Plots
# Combine multiple plots into one overall graph, using either the
     #par( ) or layout( ) function.
# With the par( ) function, you can include the option mfrow=c(nrows, ncols) to create a matrix of
#  nrows x ncols plots that are filled in by row. 
# mfcol=c(nrows, ncols) fills in the matrix by columns.

# Four figures arranged in 2 rows and 2 columns
attach(mtcars)
par(mfrow = c(2,2))
plot(wt,mpg, main="Scatterplot of wt vs. mpg")
plot(wt,disp, main="Scatterplot of wt vs disp")
hist(wt, main="Histogram of wt")
boxplot(wt, main="Boxplot of wt")

# Three figures arranged in 3 rows and 1 column
attach(mtcars)
par(mfrow=c(3,1))
hist(wt)
hist(mpg)
hist(disp)

#The layout( ) function has the form layout(mat) where
# mat is a matrix object specifying the location of the N figures to plot.
# One figure in row 1 and two figures in row 2

attach(mtcars)

layout(matrix(c(1,1,2,3), 
              2, 2, byrow = TRUE))
hist(wt)
hist(mpg)
hist(disp)


#Optionally, you can include widths= and heights= options in the layout( ) function to
#control the size of each figure more precisely. 
# One figure in row 1 and two figures in row 2
# row 1 is 1/3 the height of row 2
# column 2 is 1/4 the width of the column 1
# Note: drag to increase RStudio plot window size to
# avoid "Error in plot.new() : figure margins too large"

attach(mtcars)
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE),
widths=c(3,1), heights=c(1,2))
hist(wt)
hist(mpg)
hist(disp)

if(!require(rio)) install.packages('rio')

df <- import('GSSsubset.csv')

head(df)

attach(df)
# dev.off()
boxplot(income ~ hrswrk)
