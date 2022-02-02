###############################################
###############################################
## Graphics I ##

## Puromycin data ##
## inspect "Puromycin"
head(Puromycin)

# data()
## shows all built-in datasets

## simple scatterplot
plot(y = Puromycin$rate, 
     x = Puromycin$conc)

## changing plotting character
plot(y = Puromycin$rate, 
     x = Puromycin$conc,
     pch = ".")
## 
plot(y = Puromycin$rate, 
     x = Puromycin$conc,
     pch = 19)
## pch 19 is a filled circle

## changing colour
plot(y = Puromycin$rate, 
     x = Puromycin$conc,
     col = "red") ## or col = 2
## good practice: prefer names over numbers

## changing point size
plot(y = Puromycin$rate, 
     x = Puromycin$conc,
     cex = 6)

## add a title and axis labels
plot(y = Puromycin$rate, 
     x = Puromycin$conc,
     main = "Reaction rates vs. Conc",
     xlab = "substrate conc [ppm]",
     ylab = "reaction rates [counts/min]")


## Custom dataset ##
## changing style of drawing
plot(y = c(0,1.8,2,2.7,5,3.7,4,3.9,4.1,4.4), 
     x = 1:10)
##
plot(y = c(0,1.8,2,2.7,5,3.7,4,3.9,4.1,4.4), 
     x = 1:10,
     type = "l") ## lines
##
plot(y = c(0,1.8,2,2.7,5,3.7,4,3.9,4.1,4.4), 
     x = 1:10,
     type = "b") ## both (points and lines)
##
plot(y = c(0,1.8,2,2.7,5,3.7,4,3.9,4.1,4.4), 
     x = 1:10,
     type = "n") ## nothing

## changing line type
plot(y = c(0,1.8,2,2.7,5,3.7,4,3.9,4.1,4.4), 
     x = 1:10,
     type = "l")
##
plot(y = c(0,1.8,2,2.7,5,3.7,4,3.9,4.1,4.4), 
     x = 1:10,
     type = "l",
     lty = "dashed") ## or lty = 2
## good practice: prefer names over numbers


## arguments values can be vectors
plot(y = c(0,1.8,2,2.7,5,3.7,4,3.9,4.1,4.4), 
     x = 1:10,
     pch = 1:10,
     col = 1:10)
##
plot(y = Puromycin$rate, 
     x = Puromycin$conc,
     pch = 19,
     col = Puromycin$state)

## formula interface
plot(rate ~ conc, data = Puromycin)



###############################################
###############################################
## Graphics II ##

## low-level plotting functions ##
## abline()
plot(Examination ~ Fertility, data = swiss,
     col = "green", pch = 19)
abline(a = 45, b = -0.4, 
       col = "red", lty = "dotted", lwd = 3)
## also in "vectorised" form
abline(h = c(15, 25), 
       col = c("lightgray", "darkgray"),
       lty = 1:2)

## NB: low-level fz adds elements to the existing graph!
abline(a = 45, b = -0.4, 
       col = "black", lwd = 1.5)

## text
text(x = 40, y = 5, labels = "some text here", col = "magenta")

## points
points(y = 15:25, x = rep(40, times = 11), cex = 0.5)

## legend
# legend()
## see ... graphs III for a time-consuming and less error option


## control functions ##
## par()
par(mfrow = c(1, 2))
plot(y = 1:8, x = 1:8, col = 1:8, pch  = 16) ## 8 default colours
plot(1:19, 1:19, pch = 1:19, col = 1:19) ## 19 pchs
##
par(mfrow = c(2, 1))
plot(y = 1:8, x = 1:8, col = 1:8, pch  = 16) 
plot(1:19, 1:19, pch = 1:19, col = 1:19)
##
par(mfrow = c(3, 2))
plot(y = 1:8, x = 1:8, col = 1:8, pch  = 16) 
plot(1:19, 1:19, pch = 1:19, col = 1:19)
boxplot(Petal.Length ~ Species, data = iris)
# ...

## get back to default values
dev.off()

## par() to control "global" parameters
par("pch")
par(pch = 4)
plot(y = 1:8, x = 1:8) 

## all graphical parameters
par()
graphical.parameters <- par()
head(graphical.parameters)
str(graphical.parameters)


## device control functions
pdf(file = "../Testing_ThePdfFunction.pdf")
plot(1:10, 1:10, main = "test")
abline(v = 5)
dev.off()
## remember...the working directory
getwd()

## or via Rstudio
## Plots pane --> Export --> Save as Image/PDF


## interactive functions ##
## identify
plot(Agriculture ~ Fertility, data = swiss)
identify(y = swiss$Agriculture, x = swiss$Fertility)
## click on "finish" icon
swiss[c(46,19,7), ]

## locator
plot(1:10, 1:10, col = 1:10)
locator()
## click on "finish" icon



###############################################
###############################################
## Graphics III ##

## panelling with base-R graphical functions
head(Loblolly,  n = 8)
levels(Loblolly$Seed)
nlevels(Loblolly$Seed)
##
table(Loblolly$Seed)
##
plot(height ~ age, data = Loblolly)
##
plot(height ~ age, data = Loblolly,
     col = Seed)
## we can't really distinguish the different "Seed" on this graph
##
par(mfrow = c(2, 2))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[1],
     main = paste("Seed", levels(Loblolly$Seed)[1]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[2],
     main = paste("Seed", levels(Loblolly$Seed)[2]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[3],
     main = paste("Seed", levels(Loblolly$Seed)[3]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[4],
     main = paste("Seed", levels(Loblolly$Seed)[4]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[5],
     main = paste("Seed", levels(Loblolly$Seed)[5]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[6],
     main = paste("Seed", levels(Loblolly$Seed)[6]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[7],
     main = paste("Seed", levels(Loblolly$Seed)[7]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[8],
     main = paste("Seed", levels(Loblolly$Seed)[8]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[9],
     main = paste("Seed", levels(Loblolly$Seed)[9]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[10],
     main = paste("Seed", levels(Loblolly$Seed)[10]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[10],
     main = paste("Seed", levels(Loblolly$Seed)[10]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[12],
     main = paste("Seed", levels(Loblolly$Seed)[12]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[13],
     main = paste("Seed", levels(Loblolly$Seed)[13]))
plot(height ~ age, data = Loblolly,
     subset = Seed == levels(Loblolly$Seed)[14],
     main = paste("Seed", levels(Loblolly$Seed)[14]))
## the goal is actually fairly simple, one graph per Seed, but
## - code is way too long
## - code is not easy to read
## - copy and paste ... is bad practice, error-prone (indeed...)
## - appearance is not yet optimal 
##    . "age" and "height" repeated many times
##    . too much space among graphs
## - making any change to this code ...(e.g. type = "b") is very inefficient
## 
## - ok a for loop would make it in this case, but in most case
## this is not a viable solution

## {lattice} ##
library(lattice)
xyplot(height ~ age | Seed, data = Loblolly)

## {ggplot2} ##
library(ggplot2)
qplot(y = height, x = age, data = Loblolly, facets = ~ Seed)

## - code is much shorter
## - code is much more readable
## - code is easy to adapt (graphs are always an iteratice process)
## - appearance is way better (e.g. age is there once)
## - space is used way better
## - some fancy stuff for free (e.g. grid in the background)


## {lattice} ##
## i) panelling
xyplot(height ~ age | Seed, data = Loblolly)

## ii) grouping
xyplot(height ~ age, groups = Seed, data = Loblolly)
xyplot(height ~ age, groups = Seed, data = Loblolly,
       type = "b")

## iii) adding summary statistics
xyplot(height ~ age, data = Loblolly,
       type = c("p", "r"))
xyplot(height ~ age, data = Loblolly,
       type = c("p", "smooth"))
xyplot(height ~ age, data = Loblolly,
       type = c("p", "smooth", "g"))


## {ggplot2}
## base call ggplot()
ggplot(data = Loblolly,
       mapping = aes(y = height,
                     x = age)) +
  geom_point()

## i) panelling
ggplot(data = Loblolly,
       mapping = aes(y = height,
                     x = age)) +
  geom_point() +
  facet_wrap(~ Seed) ## !

## ii) grouping (colouring)
ggplot(data = Loblolly,
       mapping = aes(y = height,
                     x = age,
                     colour = Seed)) + ## !
  geom_point()
##
ggplot(data = Loblolly,
       mapping = aes(y = height,
                     x = age,
                     colour = Seed)) +
  geom_line() ## !

## ii) grouping (no colouring)
ggplot(data = Loblolly,
       mapping = aes(y = height,
                     x = age,
                     group = Seed)) + ## !
  geom_line()

## iii) adding summary statistics
ggplot(data = Loblolly,
       mapping = aes(y = height,
                     x = age)) +
  geom_point() +
  geom_smooth()
##
ggplot(data = Loblolly,
       mapping = aes(y = height,
                     x = age)) +
  geom_point() +
  geom_smooth(method = "lm")


## {lattice} and {ggplot2} ## 
## - both packages can be used to create a wide variety of graphs, not just scatterplot
## - see appendix 2 and 3 for more examples
## - google them for more examples
## - have a look in the corresponding books



