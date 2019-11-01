# Return TRUE or FALSE, simulating a coin flip.
is.heads = function() {
  r = rnorm(1)
  if (r < 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
#test cases ...
x=is.heads()
N=10000; coins = replicate(N, is.heads()); sum(coins)/N

# shorter version
is.heads = function() {
  r = rnorm(1)
  return(r < 0)
}

# even shorter version
is.heads = function() {
  return(rnorm(1) < 0)
}

# Return maximum of a and b.
baby.max = function(a, b) {
  if (a > b) {
    return(a)
  } else {
    return(b)
  }
}
stopifnot(isTRUE(all.equal(4, baby.max(3,  4))))
stopifnot(isTRUE(all.equal(3, baby.max(3, -4))))

# Description: baby.t.test performs a one-sample t-test and computes a
#   confidence interval for an unknown mean.
# Usage: baby.t.test(x, mu = 0, conf.level = .95)
# Parameters:
#   x: a numeric vector of data values (must have at least two values)
#   mu: the hypothesised true mean
#   conf.level: confidence level of the interval (must be in (0, 1))
# Details: the test is for the null hypothesis that the true mean is
#   mu against the alternative that the true mean is not mu
# Value: a list containing these components:
#   $statistic: the t statistic
#   $parameter: degrees of freedom for the t statistic
#   $p.value: probability of a t statistic more extreme than the one computed
#   $conf.int: a confidence interval for the true mean using
#     confidence level conf.level
#   $estimate: the estimated (sample) mean
#   $null.value: the specifited hypothesized value of the mean (mu)
#
# (In this exercise, we won't use the real t.test().)
baby.t.test = function(x, mu=0, conf.level=.95) {
  stopifnot(length(x) >= 2)
  stopifnot((0 < conf.level) & (conf.level < 1))
  n = length(x)
  x.bar = mean(x)
  s.x = sd(x)
  t = (x.bar - mu) / (s.x / sqrt(n))
  r = list() # set up r as return value
  r$statistic = t
  r$parameter = n - 1
  r$p.value = 2*pt(q=-abs(t), df=n-1)
  alpha = 1 - conf.level
  t.for.conf.level = -qt(p=alpha/2, df=n-1)
  error.margin = t.for.conf.level * s.x / sqrt(n)
  r$conf.int = c(x.bar - error.margin, x.bar + error.margin)
  r$estimate = x.bar
  r$null.value = mu
  return(r)
}
# test case
baby.t = baby.t.test(1:10, 5, .90)
t = t.test(x=1:10, mu=5, conf.level=.90) # Call the real function to check mine.
# Note: as.numeric(), below, removes names from components of t
stopifnot(isTRUE(all.equal(baby.t$statistic, as.numeric(t$statistic))))
stopifnot(isTRUE(all.equal(baby.t$parameter, as.numeric(t$parameter))))
stopifnot(isTRUE(all.equal(baby.t$p.value, as.numeric(t$p.value))))
stopifnot(isTRUE(all.equal(baby.t$conf.int, as.numeric(t$conf.int))))
stopifnot(isTRUE(all.equal(baby.t$estimate, as.numeric(t$estimate))))
stopifnot(isTRUE(all.equal(baby.t$null.value, as.numeric(t$null.value))))
