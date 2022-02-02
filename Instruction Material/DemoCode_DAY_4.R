###############################################
###############################################
## Generic and methods functions ##

## "plot()" example
methods(plot)
plot.methods <- methods(plot)
length(plot.methods)

## help pages
?plot    ## help page of the generic function
?plot.lm ## help page for the method function

## note that packages also contain methods functions
library(mgcv)
plot.methods.with.mgcv <- methods(plot)
length(plot.methods.with.mgcv)

## finding the methods
setdiff(plot.methods.with.mgcv, 
        plot.methods)
## e.g. plot.gam() only exist in {mgcv}



###############################
###############################
## writing your own function ##

## pseudo-code
# function.Name <- function(arguments){body of the function}

## a simple example
my.mean <- function(x){
  N <- length(x)
  Sum <- sum(x)
  computed.mean <- Sum / N
  return(computed.mean)
}

v.1 <- rnorm(n = 10^3, mean = 2)
v.2 <- rnorm(n = 10^3, mean = 2)

my.mean(v.1)


## return more than one object (and name them)
my.mean.sd <- function(x){
  N <- length(x)
  Sum <- sum(x)
  my.mean <- Sum / N
  my.sd <- sd(x)
  
  return(c(average = my.mean, std = my.sd))
}

my.mean.sd(v.1)


## several arguments (with and without defaults)
my.plot <- function(N = 100, ColOur = "blue"){
  sim.data <- runif(n = N)
  x <- 1:N
  plot(sim.data ~ x, col = ColOur)
}

my.plot(ColOur = "red")
my.plot(N = 20, ColOur = "blue")
my.plot()


## the "..." argument
my.plot(ColOur = "green", main = "Some sim data")

my.plot_2 <- function(N = 100, ColOur, ...){
  sim.data <- runif(n = N)
  x <- 1:N
  plot(sim.data ~ x, col = ColOur, ...)
}

my.plot_2(ColOur = "green", main = "Some sim data")


## further details
## debug() and traceback()
## note that "x" only exist within the function (in its environment)
## the object returned can also be a vector/list/..



#################
#################
## source code ##

## to get the source code of a function, type its name without round brackets

lm
my.plot
write.csv
read.table
summary ## the generic function
summary.lm ## the method function



#########################
#########################
## Regular expressions ##

v.char <- c("Anna", "Anna ", "Johnny Cashout", "12 Luc @")
## number of characthers
nchar(v.char)

## get first three characters
substr(v.char, start = 1, stop = 3)

## contains "c" 
grepl(v.char, pattern = "c")

## contains "c" (which element?)
grep(v.char, pattern = "c")

## contains "c" or "C"
grepl(v.char, pattern = "c", ignore.case = TRUE)

## starts with "a"
grep(v.char, pattern = "^A")

## ends with "t"
grep(v.char, pattern = "out$")

## starts with a letter (any letter, any case)
grep(v.char, pattern = "^[A-z]")

## starts with a number
grep(v.char, pattern = "^[0-9]")

## substitute some text
gsub(v.char, pattern = "Anna", replacement = "Annamaria")


## very fancy... ##
## extract a group
v.char.2 <- c("agagamemem 12 Euro",
              "A 13 CHF",
              "ZZ 24 Dollars")
gsub(v.char.2, pattern = "\\s", replacement = "--")
## gets the empty space and replaces it with ""

gsub(v.char.2, pattern = "([A-z]+\\s)([0-9]+)(.+)", 
     replacement = "\\2")
## finds 3 groups 
## 1. any letters one several times ended by an empty space
## 2. any number one or several times
## 3. anything (number of letter) one or several times
## replace all with the second group



#########################
#########################
## Various ##

## recoding factors example ##
# require(magrittr)
# require(dplyr)
require(forcats)

str(iris)
table(iris$Species)

iris <- iris %>% 
  mutate(species_new = fct_recode(Species, 
                                  "A" = "versicolor",
                                  "B" = "setosa",
                                  "C" = "virginica"))
table(iris$species_new)
