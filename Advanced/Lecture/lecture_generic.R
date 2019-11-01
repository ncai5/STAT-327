# Lecture Nov. 15/20, 2018

toupper("aBcd")
tolower("ABcD")

a1 = 3.14
class(a1) 

a2 = 3
class(a2)

a3 = 3L
class(a3)

a4 = 1:5
class(a4)

a5 = matrix(1:6, 2,3)
class(a5)

a6 = as.factor(ifelse(rnorm(20)>0,"M","F"))
class(a6) # "factor"

a7 = rnorm(20)
class(a7) # "numeric"

summary(a7)
summary(a6)

# summary is a "generic" function
methods("summary")

# These are some of "methods"from the generic function: summary

summary.factor
summary.default

summary(mtcars)

class(mtcars)
summary.data.frame

# Example of generic functions: print(), plot(), print(), predict()

methods(print)
# print() is a special generic function. It changes the way
# of displayig an object based on their class, 
# when we call the object.

methods(plot)
plot(a6)
plot(a7)

# class and type are not necessarily same
m <- lm(mpg ~ wt, mtcars)
class(m)

methods(coef) # note coef.default() is a hidden method
getS3method("coef","default")
coef(m)

###########################################

rm(list=ls())

g = list(name = "Margaret", age = 2)
g
class(g) # orginal (built-in) class

class(g) <- "girl" # define (user-defined) new class
g

b = list(name = "Philip", age =11) 
class(b) # orginal (built-in) class
class(b) = "boy" # define (user-defined) new class
b

print.girl = function(x) {
  cat(sep="", toupper(x$name), ", ", x$age, "\n") 
  # girls get upper case
}


print.boy = function(x) {
  cat(sep="", tolower(x$name), ", ", x$age, "\n") 
  # boys get lower case
}

print(g)
print(b)

# (Skip) ##########################################

g
b

g$age
b$age

g <- unclass(g)
b <- unclass(b)

g
b

#########################################################
#########################################################


?abline

m <- lm(mpg ~ wt, mtcars)
names(m)

plot(mpg~wt, data=mtcars)
abline(reg=m)
?abline

methods("coef")
getS3method("coef", "default")

class(g) <- 'girl'
class(b) <- 'boy'

plot(x=0:3, y=3:0)

coef.girl = function(object, ...) {
  return(c(object$age, 0)) # horizontal line with y-intercept age
}

abline(g)

methods(class="lm")
