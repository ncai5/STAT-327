# Lecture 12/03/2018

# Topic: Rcpp

# setwd("~/Dropbox/stat327_3/lec_note/")


###### Install compilers ######################

# macOS users: Xcode from App Store
# Windows users: Rtools; 
## http://cran.r-project.org/bin/windows/Rtools

# ---------------------------------------------

###### Install/Load package ###################

install.packages("Rcpp")
require(Rcpp)

# ---------------------------------------------

###### cppFunction() ##########################


# R function 
fibonacci = function(n) { 
  if (n == 0) return(0)
  if (n == 1) return(1)
  return(fibonacci(n-1) + fibonacci(n-2))
}
system.time(f <- fibonacci(30))
print(f) # Result of fibonacci(30)


# Cpp function 
cppFunction("
  int Fibonacci(int n) { // C++ code
  if (n == 0) return 0;
  if (n == 1) return 1;
  return(Fibonacci(n-1) + Fibonacci(n-2));
  } ")

system.time(F <- Fibonacci(30))
stopifnot(f == F)

# Compare using microbenchmark()

#install.packages("microbenchmark")
require(microbenchmark)
vs = microbenchmark(fibonacci(30), 
                    Fibonacci(30), 
                    times=10)
print(vs)

# ---------------------------------------------

###### Longer C++ code - sourceCpp() ##########

# Write down longer C++ code 
## File - New File - C++ File

###############
## Example1 : mean() function
# file.edit("meanC.cpp")
# 
sourceCpp("meanC.cpp") 

# compare all the functions
x <- runif(1e5)
microbenchmark(mean(x), meanC(x))

###############
## Example2 : sum of each column

X <- matrix(runif(10000),100,100)
# ??
apply(X,2,sum)
colSums(X)
# Let's write down together!
# file.edit("colSumC.cpp")
# 
sourceCpp("colSumC.cpp")

# compare all the functions
# ??
microbenchmark(apply(X, 2, sum),colSums(X),colSumC(X))
# ---------------------------------------------

###### Translating basic R to basic C++ #######

# Conditional Statement

cppFunction("
  int signC(int x){
    if (x > 0){
      return 1;
    } else if (x==0) {
      return 0;
    } else {
      return -1;
    }
  } ")

signC(-94)
microbenchmark(sign(20),signC(20))

# Loops: while-loop

file.edit("cumsumC.cpp")
sourceCpp("cumsumC.cpp")
cumsumC(3)

# Corresponding Types

cppFunction("
  bool test(){
    int a = 3;
    return(a==4);
  } ")

test()

#        R                    C++
# x = integer(1)      <-->  int x;
# x = numeric(1)      <-->  double x;
# x = logical(1)      <-->  bool x;
# x = charactor(1)    <-->  String x;
# x = logical(n)      <-->  LogicalVector x(n);
# x = integer(n)      <-->  NumericVector x(n);
# x = numeric(n)      <-->  CharacterVector x(n);
# X = matrix(...)     <-->  NumericMatrix X(m,n);
# z = data.farme(..)  <-->  List z (usually for input)

# n = length(x)       <-->  n = x.size();
# x[i]                <-->  x[i]
# X[i,j]              <-->  X(i,j)
# a <- a + 1          <-->  ++a
# ans = ifelse(a < b, b, -b)
#                     <-->  ans = (a < b) ? b : -b;

# For detalis and more examples, check
browseURL("http://adv-r.had.co.nz/Rcpp.html")

# ---------------------------------------------
