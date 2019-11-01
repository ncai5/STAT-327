# for() loop through sequence

for (file.name in head(list.files())) {
  cat("file.name =", file.name, "\n")
}

n = 3 # also try 0
for (i in seq_len(n)) { # SEQUENCE is 1:n (or, for n=0, integer(0))
  even.or.odd = ifelse(i %% 2 == 0, "even", "odd")
  cat(i, "is", even.or.odd, "\n")
}

x = c(2, 3, 5)
total = 0
for (x.i in x) { # loop through values
  total = total + x.i
}

product = 1
for (i in seq_len(length(x))) { # or indices
  product = product * x[i]
}

# while() loop (zero or more times)
x = 1
while (x < 10) {
  cat("x =", x, "\n")
  x = 2*x
}

# repeat until break loop (one or more times)
repeat {
  cat("Please answer 'yes' or 'no':")
  decision = scan(what=character(), n=1, quiet=TRUE) # ?scan
  if ((decision == "yes") | (decision == "no")) {
    break
  }
}

repeat {
  cat("Pete and Repeat were sitting on fence. Pete fell off. Who was left?\n")
  answer = scan(what=character(), n=1)
  if (answer != "Repeat") {
    break
  }
}

# Note that the "while" loop is all we really need. The other two are
# for convenience. e.g. Here's the "for" loop for iterating through a
# known sequence:
#   for (VARIABLE in SEQUENCE) {
#     EXPRESSION
#   }
# and here's how to do (almost) the same thing with "while":
#   i = 1
#   while (i <= length(SEQUENCE)) {
#     VARIABLE = SEQUENCE[i]
#     EXPRESSION
#     i = i + 1
#   }
# The "for" version is easier to write and read.
#
# e.g. Here's a "repeat" loop for running EXPRESSION one or more times:
#   repeat {
#     EXPRESSION
#     if (CONDITION) {
#      break
#     }
#   }
# and here's how to do the same thing with "while":
#   EXPRESSION
#   while (!CONDITION) {
#     EXPRESSION
#   }
# The "repeat" version is better because having two copies of
# "EXPRESSION" is hard to maintain.

# Play with matrices to see some standard loops. (There are easier ways
# to do many of these things, e.g. set first row to 1's with "m[ ,1] = 1",
# but these make nice loop exampes.)

n = 3
M = matrix(rep(x=0, times=n^2), nrow=n, ncol=n) # M is a matrix of zeros

m = M # m is a copy I'll mess with
# Set first row to 1's.
for (col in 1:n) {
  m[1, col] = 1
}

m = M
# Set first column to 1's.
for (row in 1:n) {
  m[row, 1] = 1
}

m = M
# Set diagonal to 1's.
for (i in 1:n) {
  m[i, i] = 1
}

m = M
# Set reverse diagonal to 1's.
for (i in 1:n) {
  m[i, n-i+1] = 1
}

m=M
# Use nested loops to set upper triangle to 1's.
for (row in 1:n) {
  for (col in row:n) {
    m[row, col] = 1
  }
}
