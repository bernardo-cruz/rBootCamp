###############################################
###############################################
## R-studio ##

# - four panels
#    . script
#    . R-console
#    . graphs and help
#    . environment
# - coloured syntax
# - send line ("Ctrl + Enter" or click on "Run")
# - assignment symbol i.e. <- ("Alt + Minus") 



## assignments
a.1 <- 10
a.2 <- 3 * a.1
a.2


## overwriting is irreversible
a.2 <- 0
a.2



###############################################
###############################################
## Vectors ##

## creating numeric vectors
c(2,3,15)

v.1 <- c(15,23,55,10,19)

v.2 <- c(1,2,10, 10^2,      1) ## empty spaces do not matter (but not elegant)


## alternatives to c()
1:12 ## sequences can be created via ":"


## string vectors
c("Tana", "Bernd", "Lorenzo", "Andy L.") ## strings can contain empty spaces


## logical vectors
c(TRUE, FALSE, TRUE, FALSE) 


## logical operators
v.1
v.1 > 18

v.1 < 18

v.1 >= 19
v.1 <= 23 

v.1 == 19
v.1 != 19


## NB: TRUE and FALSE are reserved names
TRUE <- 6
## but
true <- 6
true
T <- 6
## ... R is case-sensitive


## operations with vectors ... are applied elementwise
c(10,20,100) + 1:3
c(10,20,100) * 1:3

c(10,20,100) / 1:3


## recycling of elements
c(10,20, 30) + 1:6
## the shorter vector is "recycled" to match the length of the longest one


## warnings
c(10,20, 30) + 1:5


## accessing elements of a vector
v.1
v.1[2]
v.1[2:4]
v.1[c(TRUE, FALSE, FALSE, FALSE, TRUE)] ## first and last elements


## elements can be dropped
v.1[-1]
v.1[-c(1, 5)]
v.1[c(-1, -5)]



###############################################
###############################################
## Matrices ##

## creating a numeric matrix
M.1 <- matrix(data = 6:1, nrow = 2, ncol = 3)
M.1


## same with rbind()
rbind(c(6, 4, 2), c(5, 3, 1))


## same with cbind()
cbind(1:2, 3:4, 5:6)


## very often r- and cbind() are used to add columns to an existing matrix
cbind(M.1, c(99, 102))


## logical and string matrices
matrix(data = c("a", "b", "c", "d", "e", "f"), nrow = 3) ## ncol not necessary here

matrix(data = c(TRUE, FALSE, FALSE, FALSE), ncol = 1)


## operations apply elementwise 
M.aa <- matrix(data = 1:6, ncol = 3)
M.aa

M.bb <- matrix(data = c(10, 0, 10, 0, 100, 1), nrow = 2)
M.bb

M.aa * M.bb


## negative indexes can also be used with matrices
M.aa
M.aa[-1, ]
M.aa[ , -c(2, 3)]

M.aa[-1 , -c(2, 3)] ## double dropping... is not often used (unclear)



###############################################
###############################################
## Data frames ##

## creating a data frame
v.participant.name <- c("Max", "Tony M?ller", "Andreas", "Ramona", "Nick Q.")
v.age <- c(17, 23, 45, 11, 44)
v.minor.YES <- c(TRUE, FALSE, FALSE, TRUE, FALSE)
##
d.test <- data.frame(v.participant.name, v.age, v.minor.YES)
d.test


## class of the single elements
class(v.participant.name)
class(v.age)
class(v.minor.YES)
class(d.test)
## more on classes (i.e. str()) comes later


## accessing elements
d.test[1,2]
d.test[1, ]
d.test[ ,2]
d.test[ , -c(1,3)]


## Attributes: column names
colnames(d.test)
d.test[1:2, "v.age"]
## !! column names have to be preferred over indexes
  # * clearer to the reader/writer
  # * the code is more resilient (e.g.~when columns are added)


## excursus on column names
## colnames() can be used to retrieve column names
## OR set them
d.test.2 <- d.test
colnames(d.test.2) <- c("a", "b", "???")
d.test.2
## more on attributes comes later


## accessing columns via "$" symbol
d.test[, "v.age"]
d.test$v.age
## note partial matching
d.test$v.a
## but 
d.test$v. ## does not work because not unambiguous


## adding elements to a data frames
d.test
d.test[ , "new.col"] <- 0
d.test
## same as
d.test$new.col.2 <- 0
d.test


## elements can be overwritten
d.test$new.col <- 10:14
d.test


## operations with data frames
d.test$new.col <- d.test$new.col  + 150
d.test$new.col



###############################################
###############################################
## Functions ##

## help pages
?mean
## same as
help(mean)
## same as 
## ... using the Rstudio "help" pane


## arguments:
## function with compulsory arguments
mean(x = 1:13)

## function that does not require any argument
ls()

## matrix() called with all default values
matrix()
## unlikely to be of any use
## usually at least "data" and "nrow" resp. "ncol" are defined by the user


## arguments position:
## dropping argument names
matrix(data = 1:12, nrow = 2, ncol = 6)
## same as
matrix(1:12, 2, 6)
## Note: Rstudio provides a nice auto completion activity (use "Tab") 
## that suggest the arguments of a function
matrix()


## but be careful with
matrix(data = 1:12, nrow = 2, byrow = TRUE) ## ncol not specified 
## same as
matrix(1:12, 2, ,TRUE)


## changing order (but keep names)
matrix(data = 1:12, nrow = 2, byrow = TRUE)
## same as
matrix(nrow = 2, byrow = TRUE, data = 1:12)

## but 
matrix(2, TRUE, 1:12)
## produces nonsense


## arguments: partial matching
seq(from = 1, to = 10, length.out = 5)
## same as 
seq(from = 1, to = 10, l = 5)
## possible as no other argument starts with "l"


## Good practices:
## leave one space between argument names and values
rep(x = 1:3, times = 4)
## don't leave space between functionName and the round brackets
mean (x = 1:19)
## write on several lines long function calls
plot(x = 1:10, 
     
     y = 10:1,
     pch = 19, ## filled circle
     col = 2,  ## red
     cex = 2)  ## expansion factor
## writing on several lines makes the code more readable 
## and allows you to add comments for each argument

## compare to
plot(x=1:10,y=10:1,pch=19,col= 2,cex=2)



###############################################
###############################################
## Importing data ##

## import data
read.table("../DataSets/BlaueEier.txt",
           header = TRUE)

## import and ... store data in an object
d.blueEggs <- read.table("../DataSets/BlaueEier.txt",
                         header = TRUE)
##
d.blueEggs
str(d.blueEggs)

## "header"
d.blueEggs.2 <-  read.table("../DataSets/BlaueEier.txt")
head(d.blueEggs.2)
str(d.blueEggs.2)
## R tries to guess the class of each column by looking at the values 
## present in it
## If no names are present in the data (or provided via col.names argument)
## default names are V1, V2, ...

## "going up" path
d.Framingham <- read.table("../DataSets/Framingham.dat", 
                           header = TRUE)
str(d.Framingham)

## absolute path (to be avoided)
d.birthRates <- read.table("/home/tana/Dropbox/Teaching/Boot_R_Camp_@_HSLU/Course_Material/DataSets/Framingham.dat", 
                           header = TRUE)
str(d.birthRates)

## getting the current working directory
getwd()
## 
## setting the working directory
# setwd("/home/tana/Desktop")

## getting data from a url
d.sports <- read.table("http://stat.ethz.ch/Teaching/Datasets/sport.dat",
                       header = TRUE)
head(d.sports)
str(d.sports)

## writing/creating data files
# write.csv2(d.sports, "SportsDataset.csv")
# write.csv()
# write.table()
# ...

## importing via Rstudio
## file --> import dataset --> ... --> BlauerEier.txt



###############################################
###############################################
## Some R-functions to inspect data

## data was not imported properly
d.birthRates <- read.csv2("../DataSets/birthrates.csv")
str(d.birthRates)
## everything pasted together

## column names where take as being observations
d.Fram <- read.table("../DataSets/Framingham.dat")
str(d.Fram)
##
d.Fram <- read.table("../DataSets/Framingham.dat", header = TRUE)
str(d.Fram)

## the kind of data was not properly recognised 
## (e.g.~numeric data that is imported as a character)
d.Fert <- read.csv("../DataSets/birthratesDots.csv")
str(d.Fert)
head(d.Fert$fertility)
d.Fert$fertility[4]
##
# d.Fert$fertility.corrected <- as.numeric(as.character(d.Fert$fertility))
# head(d.Fert$fertility.corrected)
# d.Fert$fertility.corrected[4]

## useful functions to inspect data
## iris is a dataset that comes with base R
str(iris)
dim(iris) ## nrow(iris); ncol(iris)
head(iris)
summary(iris)
table(iris[, "Species"])

## further useful functions
min(iris$Sepal.Length)
max(iris$Sepal.Length)
range(iris$Sepal.Length)
levels(iris$Species)
nlevels(iris$Species)
length(unique(iris$Sepal.Length))
## see also n_distinct() in package {dplyr}

## note: No exercises on that topic