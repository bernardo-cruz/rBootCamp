###############################################
###############################################
## Reshaping data sets ##
setwd("~/HSLU_MBP/3_semester/RB01_R_Bootcamp/rBootCamp/InstructionMaterial")

## Wide-format ##
d.sports <- read.table(file = "./R_Bootcamp_Feb2022/DataSets/Sports_Results_En.txt")
d.sports
## each row contains several observations 
## this data set is said to be in "wide-format"
## most graphical and fitting functions work with "long-format" data sets


## Moving to long-format ##
library(tidyr)
d.sports.long <- pivot_longer(d.sports, 
                              cols = -athlete, ## variables that are not to put as results
                              ## mind the minus here
                              names_to = "discipline", ## new column with name of sport
                              values_to = "results") ## new column with value (unquoted also works)
head(d.sports.long, n = 10)
str(d.sports.long)
##
## 7 athletes and 6 disciplines + total score
dim(d.sports) 
dim(d.sports.long)


## Moving to wide-format ##
d.sports.wide.again <- pivot_wider(d.sports.long, 
                                   names_from = "discipline",
                                   values_from = "results")
d.sports.wide.again
# class(d.sports.wide.again)

## formerly gather() and spread() were popular functions
## used to move from long to wide and viceversa


## Use cases for a wide-format data sets ##
library(dplyr)
d.disciplines.results.only <- d.sports %>% 
  select(-athlete, -total.points)
d.disciplines.results.only
##
pairs(d.disciplines.results.only)
cor(d.disciplines.results.only) %>% 
  round(digits = 2)
## see correlation shot.put and long.jump (-0.73)
## see correlation shot.put and discus.throw (0.83)


## Use case for a long-format data sets ##
head(d.sports.long)
##
lm.sports <- lm(results ~ discipline + athlete, 
                data = d.sports.long)
## NB: The vast majority of the analyses done in R
## use functions such as lm() that 
## work with long-format data sets



###############################################
###############################################
## Joining data sets ##

## let's create a dataset with further athletes info
d.athletes <- data.frame(athlete = d.sports$athlete,
                         age = c(23, 21, 21, 18, 32, 34, 25),
                         Gender = c("M", "M", "F", "M", "F", "F", "F"))
d.athletes
# d.sports.long

## joining the two datasets
d.sports.long.info <- left_join(d.sports.long, 
                                d.athletes, 
                                by = "athlete")
head(d.sports.long.info, n = 10)
## this is a "left join" because we added information to
## the data set on the left (i.e. d.sports.long)

## when names does not match in the two data sets
d.athletes.2 <- data.frame(sportsperson = d.sports$athlete,
                           age = c(23, 21, 21, 18, 32, 34, 25),
                           Gender = c("M", "M", "F", "M", "F", "F", "F"))
d.athletes.2
##
d.sports.long.info.2 <- left_join(d.sports.long, 
                                  d.athletes.2, 
                                  by = c("athlete" = "sportsperson"))
head(d.sports.long.info.2, n = 10)

## see ?join for further functions to join two data sets together
## or type "apropos("join")"

## do write you own examples to look at 



###############################################
###############################################
## piping ##

## NB: no slides for piping


## load the package
library(magrittr)
## ("ceci n'est pas un pipe")


## simple  pipine example ##
round(mean(iris$Sepal.Length), digits = 2)
## OR
## with "pipe" operator
iris$Sepal.Length %>% 
  mean() %>% 
  round(digits = 2)
## 
## base R now has a pipe operator (since version 4)
# iris$Sepal.Length |> mean()


## exposition pipe operator ##
iris$Sepal.Length %>% 
  mean()
##
iris %>% 
  mean(Sepal.Length)
## does not work
## but
iris %$% 
  mean(Sepal.Length)
## works with exposition pipe operator
## "%$% is analogous to specifying data in lm()
## afterwards you can directly access elements


## more complex example ##
mean(scale(iris$Petal.Length[iris$Species == "setosa"],
           scale = TRUE, center = FALSE))
## OR
## with "pipe" and "exposition pipe" operator
iris %>% 
  filter(Species == "setosa") %$% 
  scale(Petal.Length, scale = TRUE, center = FALSE) %>% 
  mean()
## run bit of code to better understand what is happening



######################################
######################################
## A bit more on {dplyr} and friends ##
library(dplyr)

## selecting and filtering data ##
head(airquality)
airquality %>% 
  select(Ozone, Solar.R) %>% 
  head()

airquality$Temp.Kelvin <- airquality$Temp + 273.15
airquality %>% 
  filter(Ozone >= 90) %>% 
  select(Ozone, contains("temp"))
## see also starts_with(), ends_with(), ...


## arranging data ##
airquality %>% 
  filter(Ozone >= 80) %>% 
  select(Ozone, contains("Temp")) %>% 
  arrange(Ozone)

airquality %>% 
  filter(Ozone >= 80) %>% 
  select(Ozone, contains("Temp")) %>% 
  arrange(desc(Ozone))
## some ties for Ozone (e.g. 97 and 85)

airquality %>% 
  filter(Ozone >= 80) %>% 
  select(Ozone, contains("Temp")) %>% 
  arrange(desc(Ozone), Temp)


## get top N observations ##
iris %>% 
  slice_min(n = 5, order_by = Sepal.Width)
## see also slice_max()

iris %>% 
  group_by(Species) %>% 
  slice_max(n = 1, order_by = Sepal.Width)


## summarising data ##
mean(iris$Sepal.Length)

iris %>% 
  summarise(mean(Sepal.Length))

iris %>% 
  summarise(mean.Sepal.Length = mean(Sepal.Length),
            sd.Sepal.Length = sd(Sepal.Length))

iris %>% 
  group_by(Species) %>% 
  summarise(mean.Sepal.Length = mean(Sepal.Length))

iris %>% 
  filter(Petal.Length > 5) %>% 
  group_by(Species) %>% 
  summarise(N = n())
##
iris %>% 
  filter(Petal.Length > 5) %>% 
  group_by(Species, .drop = FALSE) %>% 
  summarise(N = n())
## see also count()
iris %>% 
  filter(Petal.Length > 5) %>% 
  group_by(Species, .drop = FALSE) %>% 
  count()

iris %>% 
  filter(Petal.Length > 5 | Sepal.Length <= 6) %>% # and is by comma, or one uses pipe |
  group_by(Species, .drop = FALSE) %>% 
  summarise(N = n())


## adding new variables to a data frame ##
## e.g. let's say Sepal.Length is in inches
iris_2 <- iris %>% 
  mutate(Sepal.Length.cm = cm(Sepal.Length))
head(iris_2)


## replacing NAs ##
d.testNAs_2 <- read.csv("../DataSets/dataset_NAs.csv", 
                        na.strings = c(-999, ""),
                        header = TRUE)
d.testNAs_2

library(tidyr)
d.testNAs_2 %>%
  replace_na(list(Age = 100,
                  Salary = 0))
d.testNAs_2 %>%
  replace_na(list(Age = 100,
                  Salary = 0,
                  Gender = "unknown"))
class(d.testNAs_2$Gender)
levels(d.testNAs_2$Gender)
## factors have fixed number of levels

## it is easier to work with strings...
d.testNAs_2$Gender.char <- as.character(d.testNAs_2$Gender)
d.testNAs_2 %>%
  replace_na(list(Age = 100,
                  Salary = 0,
                  Gender.char = "unknown"))

## note that there is also a function replace
replace(x = d.testNAs_2$Gender.char,
        list = d.testNAs_2$Gender == "M",
        values = "Male")
## no example :( for this function...


