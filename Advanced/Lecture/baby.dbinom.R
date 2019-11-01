# Demonstrate R's debugging functions.
# 
# (For "binary search" to find code bug, delete "}" of baby.choose()'s
# if() and then source().)

rm(list=ls())

# Description: baby.factorial computes n! ("n factorial") =
#   n(n-1)(n-2)...(3)(2)(1).
# Usage: baby.factorial(n)
# Arguments:
#   n: a non-negative ingeger
# Details: Note that 0! is defined to be 1.
# Value: n!
baby.factorial = function(n) {
  factors = seq_len(n) # ?seq_len; why doesn't 1:n work?
  return(prod(factors))
}

# Description: baby.choose(n, k) calculates n! / (k!(n-k)!).
# ...
baby.choose = function(n, k) {
  if ((k < 0) | (k > n)) {
    return(0)
  }
  numerator = baby.factorial(n)
  denominator = baby.factorial(k) * baby.factorial(n-k)
  return(numerator / denominator)
}

# Description: baby.dbinom(x, size, prob) returns P(X = x) for
#   X ~ Bin(n=size, p=prob).
# ...
baby.dbinom = function(x, size, prob) {
  n = size
  p = prob
  return(baby.choose(n, x) * (p^x)*(1-p)^(n-x))
}

stopifnot(isTRUE(all.equal(.25, baby.dbinom(0, 2, .5), dbinom(0, 2, .5))))
stopifnot(isTRUE(all.equal(.50, baby.dbinom(1, 2, .5), dbinom(1, 2, .5))))
stopifnot(isTRUE(all.equal(.25, baby.dbinom(2, 2, .5), dbinom(2, 2, .5))))
stopifnot(isTRUE(all.equal(.00, baby.dbinom(3, 2, .5), dbinom(3, 2, .5))))

baby.dbinom(0, 2, .5)
