###############################################
###############################################
## Fitting models ##

## the t-test for iris ##
## preparing data
d.iris.2.sp <- iris[iris$Species != "setosa", ]
## same as
d.iris.2.sp_same <- iris[iris$Species %in% 
                           c("versicolor", "virginica"), ]
## 
all.equal(d.iris.2.sp, d.iris.2.sp_same)
## see also identical()


## visualising data
boxplot(Sepal.Length ~ Species, data = d.iris.2.sp)
str(d.iris.2.sp)
table(d.iris.2.sp$Species, useNA = "always")
## drop unused levels
boxplot(Sepal.Length ~ Species, 
        data = droplevels(d.iris.2.sp))
## --> we will look at factors later


## running the test
t.test(Sepal.Length ~ Species, data = d.iris.2.sp)
## - note scientific notation (i.e. 2e-07 = 2 * 10^(-7) = 0.0000002)
## - note the test actually carried out
##
t.test(Sepal.Length ~ Species, var.equal = TRUE,
       data = d.iris.2.sp) 
## - NB: the machine runs the t-test ...
## YOU must understand-interpret-communicate the resutls


## the linear model for iris ##
## visualise data
pairs(Sepal.Length ~ ., data = d.iris.2.sp)
pairs(Sepal.Length ~ ., data = d.iris.2.sp,
      upper.panel = panel.smooth)
## fit LM
lm.iris <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width + Species,
              data = d.iris.2.sp)
## get results
summary(lm.iris)

## further "model-related" functions
lm.iris.no.species <- lm(Sepal.Length ~ Sepal.Width + Petal.Length +
                         Petal.Width,
                         data = d.iris.2.sp)
## same as 
lm.iris.no.species_same <- update(lm.iris, . ~ . - Species)

## comparing models
anova(lm.iris.no.species, lm.iris)

## getting fitted values
fit.iris <- fitted(lm.iris)
head(fit.iris)
fit.iris.no.species <- fitted(lm.iris.no.species)
head(fit.iris.no.species)

## model diagnostics
plot(lm.iris.no.species)
par(mfrow = c(2,2))
plot(lm.iris.no.species)
# dev.off()

## produce plots residuals plots by yourself
library(ggplot2)
ggplot(mapping = aes(y = resid(lm.iris),
                     x = fitted(lm.iris))) +
  geom_point() +
  geom_smooth()
##
## let's add a reference on zero
ggplot(mapping = aes(y = resid(lm.iris),
                     x = fitted(lm.iris))) +
  geom_point() +
  geom_smooth() +
  geom_hline(yintercept = 0, 
             colour = "violet", size = 4)
##
## ordering of the layers matter
ggplot(mapping = aes(y = resid(lm.iris),
                     x = fitted(lm.iris))) +
  geom_hline(yintercept = 0, colour = "violet") +
  geom_point() +
  geom_smooth()
##
ggplot(mapping = aes(y = resid(lm.iris),
                     x = fitted(lm.iris),
                     colour = abs(resid(lm.iris)))) +
  geom_hline(yintercept = 0, colour = "violet") +
  geom_point() +
  geom_smooth() +
  scale_y_continuous(minor_breaks = FALSE) # +
  # theme_bw()


## linear models are indeed lists
class(lm.iris)
is.list(lm.iris)
##
str(lm.iris)
str(lm.iris, max.level = 0)
str(lm.iris, max.level = 1)
## 
coef(lm.iris) ## prefererrd over
lm.iris$coefficients



###############################################
###############################################
## Missing values ##

## airquality dataset ##
head(airquality)

anyNA(airquality)

## Column "Ozone"
anyNA(airquality$Ozone)
is.na(airquality$Ozone)
which(is.na(airquality$Ozone))

## NB: == NA does not work
airquality$Ozone[1:6] 
airquality$Ozone[1:6] == NA

## how many missing values?
sum(is.na(airquality$Ozone))
## NB: TRUE are then converted to ones and FALSE to zero
sum(c(TRUE, FALSE, FALSE, TRUE, FALSE))
mean(c(TRUE, FALSE, FALSE, TRUE, FALSE))

## setting NAs
airquality$Ozone[1:5]
airquality$Ozone[1] <- NA
airquality$Ozone[1:5]
## OR
is.na(airquality$Ozone) <- c(2,4)
airquality$Ozone[1:5]

## reading "incomplete" datasets
d.testNAs <- read.csv("../DataSets/dataset_NAs.csv", header = TRUE)
d.testNAs
## empty cells in numeric vectors are taken as NAs
## empty celly in string vectors are taken as empty
## actually -999 is also a NAs

d.testNAs$Gender[d.testNAs$Gender == ""] <- NA
d.testNAs
is.na(d.testNAs$Gender)
## NB: there are different types subtypes of NAs, in practice for the user
## they are all the same 

## reading in -999 as an NA
d.testNAs_2 <- read.csv("../DataSets/dataset_NAs.csv", 
                        na.strings = c(-999, ""),
                        header = TRUE)
d.testNAs_2
## it is good practice to code NAs when reading the data into R
## indeed, we may mistakenly compute the mean value of salary when 
## it still contains -999...

## "simple" function can "remove" NAs
mean(d.testNAs_2$Age)
mean(d.testNAs_2$Age, na.rm = TRUE)


## "higher" functions work with na.action
lm.1 <- lm(Age ~ Gender, data = d.testNAs_2)
summary(lm.1)

lm.1 <- lm(Age ~ Gender, data = d.testNAs_2,
           na.action = na.fail)
## see also na.pass

## drop NAs
d.testNAs_2
na.omit(d.testNAs_2)

nrow(airquality)
airquality.no.NAs <- na.omit(airquality)
nrow(airquality.no.NAs)


## introducing apply() functions (***)
apply(airquality, MARGIN = 2, FUN = class)
apply(airquality, MARGIN = 2, FUN = anyNA)
apply(airquality, MARGIN = 1, FUN = anyNA)
apply(airquality, MARGIN = 2, 
      FUN = function(x) {sum(is.na(x))})


## imputation
## Q: how would you proceed?
d.testNAs
d.testNAs$Gender[d.testNAs$FirstName == "Andrea"] <- "F"
d.testNAs 
## but actually Andrea...

mean.age <- mean(d.testNAs$Age, na.rm = TRUE)
mean.age
d.testNAs$Age[is.na(d.testNAs$Age)] <- mean.age
## but actually age is not missing at random...
## creating a factor with age classes and an "unknown" class for
## the missing values may a better solution

# install.packages("mice")
library(mice)
md.pattern(airquality, plot = FALSE)



###############################################
###############################################
## Packages ##

## Default R packages ## 
sessionInfo()

find("lm")
?lm


## Add-on packages ##
## installing add-on packages
install.packages("boot")
## quotation marks do matter here!

## loading add-on packages
library("boot")
## same as
library(boot)
## quotation marks don't matter here!
sessionInfo()

## installing != loading
# install.packages("lme4")
?lmer
library(lme4)
?lmer
## note also that package "Matrix", which is a "dependency", was loaded

## help about a package
?lme4
## note lme4 needs to be loaded

library(randomForest)
?randomForest ## this leads to the function help, not the package one
help(package = "randomForest") 
## here {randomForest} does not need to be loaded (but at least installed)


## Same via Rstudio pane ##
## - install
## - load
## - see documentation
## - update packages


## Where are packages installed? ##
.libPaths()
## - first path refers to add-on packages
## - second path refers to the "default" packages
## - these paths may change from machine to machine
## - most of the time default location is ok
## - if not, specify the desired path when downloading the package
##   via the the "lib" argument


## Finding functions? ##
find("boxplot")
apropos("packages")


## Conflicts ##
library(mgcv)
gam.1 <- gam(Sepal.Width ~ s(Petal.Width), data = iris)
summary(gam.1)

library(gam)
## note the conflict message
## from here on the gam() function in package {mgcv} is not used anymore
gam.2 <- gam(Sepal.Width ~ s(Petal.Width), data = iris)
summary(gam.2)

class(gam.1)
class(gam.2)

## NB: the order of loading packages matters!
## --> load packages at the very beginning of your code
##     indeed, bits of analysis often move around in analyses...
## --> pay attention to possible conflicts (will save you a lot of time)


## Explicitly calling a given function ##
gam.3 <- mgcv::gam(Sepal.Width ~ s(Petal.Width), data = iris)
summary(gam.3)


## Add-on packages evolve ##
packageVersion("lme4")
