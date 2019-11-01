# Name: ...
# Email: ...

# We'll grade your homework by running
#   source("hw1.R")
# in a directory containing your "hw1.R" file, by running other test
# cases on your code, and by reading your code.
#
# Implement the following functions by replacing "..." with your own
# code. While your functions should pass the test cases, below, we'll
# also try them with different test cases.
#
# Hint: if you have a bug, study a single test case that manifests it.

rm(list = ls())

# Description: convert fahrenheit temperature to celsius.
# Usage: celsius(fahrenheit)
# Arguments:
#   fahrenheit: the temperature in degrees Fahrenheit
# Value: the equivalent temperature in degrees Celsius
celsius = function(fahrenheit) {
  # ...
}
stopifnot(isTRUE(all.equal(celsius(32), 0)))
stopifnot(isTRUE(all.equal(celsius(212), 100)))

# Write a function "sign.string()" with an integer
# parameter, n, that returns one of the character strings,
#   "negative"
#   "zero"
#   "positive"
# according to the sign of n.
sign.string = function(n) {
  # ...
}
stopifnot(sign.string(-2) == "negative")
stopifnot(sign.string( 0) == "zero")
stopifnot(sign.string( 3) == "positive")

# Write a function "letter.grade()" with a numeric argument,
# score, that returns a character (string) letter grade
# according to this scale:
#   score             grade
#   [90, 100]         "A"
#   [80,  90)         "B"
#   [70,  80)         "C"
#   [60,  70)         "D"
#   [ 0,  60)         "F"
#   outside [0, 100]  NULL
# (The notation "[80, 90)" refers to the set of scores such
# that 80 <= score < 90. 80 is included, but not 90.)
#
# Use "if ... else if ... else".
letter.grade = function(score) {
  # ...
}
stopifnot(letter.grade(100) == "A")
stopifnot(letter.grade( 95) == "A")
stopifnot(letter.grade( 90) == "A")
stopifnot(letter.grade( 89.99) == "B")
stopifnot(letter.grade( 80) == "B")
stopifnot(letter.grade( 75) == "C")
stopifnot(letter.grade( 60) == "D")
stopifnot(letter.grade( 40) == "F")
stopifnot(is.null(letter.grade( -3))) # "... == NULL" doesn't do the right thing

# Write a function "discriminant()" that takes three numeric parameters,
# a, b, and c, and returns b^2 - 4ac.
discriminant = function(a, b, c) {
  # ...
}
stopifnot(isTRUE(all.equal(discriminant(0, 0,  0), 0)))
stopifnot(isTRUE(all.equal(discriminant(0, 0,  1), 0)))
stopifnot(isTRUE(all.equal(discriminant(0, 1,  0), 1)))
stopifnot(isTRUE(all.equal(discriminant(0, 1,  1), 1)))
stopifnot(isTRUE(all.equal(discriminant(1, 0,  0), 0)))
stopifnot(isTRUE(all.equal(discriminant(1, 0,  1), -4)))
stopifnot(isTRUE(all.equal(discriminant(1, 1,  1), -3)))
stopifnot(isTRUE(all.equal(discriminant(1, -1,  -1), 5)))
stopifnot(isTRUE(all.equal(discriminant(-1, -1,  -1), -3)))

# Write a function "quadratic.formula()" with three numeric
# parameters, a, b, and c. Its return value is as follows:
#
# If a is 0, return NULL. ("0x^2 + bx + c = 0" isn't a quadratic
# equation.)
#
# If there are no real-number solutions (because the discriminant
# is negative), return a numeric vector of length 0. (Use your
# discriminant() function to find the discriminant.)
# 
# Otherwise return a vector of the two (possibly identical) solutions
# to a*x^2 + b*x + c = 0. If the two solutions are different, the
# smaller solution should be first in the vector.
#
# Note: Call your discriminant() function to get the discriminant.
quadratic.formula = function(a, b, c) {
  # ...
}
stopifnot(isTRUE(all.equal(quadratic.formula(0, 0,  0), NULL)))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 0,  1), numeric(0))))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 0, -1), c(-1, 1))))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 0, -4), c(-2, 2))))
stopifnot(isTRUE(all.equal(quadratic.formula(2, 0, -8), c(-2, 2))))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 5,  6), c(-3,-2))))
stopifnot(isTRUE(all.equal(quadratic.formula(1, 1, -6), c(-3, 2))))

# Description: baby.prop.test performs a z-test and computes a
#   confidence interval for an unknown proportion.
# Usage: baby.prop.test(x, n, p, conf.level = .95)
# Parameters:
#   x: the number of successes in a sample (must be in [0, n])
#   n: the sample size (must be greater than 0)
#   p: the hypothesized true proportion (must be in (0, 1)) 
#   conf.level: confidence level of the interval (must be in (0, 1))
# Details: The test is for the null hypothesis that the true proportion
#   is p against the alternative that it isn't p. The statistic is
#     z = (p.hat - p) / sqrt(p*(1-p)/n),
#   where
#     p.hat = x / n
#   Note: This z is approximately N(0,1) under the null hypothesis.
#   The interval is
#     p.hat +/- z_{alpha/2} * sqrt(p.hat*(1-p.hat)/n),
#   where alpha = 1 - conf.level.
# Value: a list containing these components:
#   $statistic: the z statistic
#   $p.value: probability of a z-statistic more extreme than the one computed
#   $conf.int: a confidence interval for the true proportion using
#     confidence level conf.level (Note: the interval must not extend
#     outside [0, 1].)
#   $estimate: the estimated (sample) proportion, p.hat
#   $null.value: the specifited hypothesized value of the proportion, p
#
# (You may not use the real prop.test() or chisq.test() or related
# functions. Use stopifnot() to check the arguments according to the
# "must" statements above.)
#
baby.prop.test = function (x, n, p, conf.level = 0.95) {
  # ...
}
# test case
baby.prop = baby.prop.test(72, 100, .7, conf.level=.99)
stopifnot(isTRUE(all.equal(as.numeric(baby.prop$statistic), .43643578)))
stopifnot(isTRUE(all.equal(as.numeric(baby.prop$p.value), .66252058)))
stopifnot(isTRUE(all.equal(as.numeric(baby.prop$conf.int), c(.60434555, .83565445))))
stopifnot(isTRUE(all.equal(as.numeric(baby.prop$estimate), .72)))
stopifnot(isTRUE(all.equal(as.numeric(baby.prop$null.value), .7)))
