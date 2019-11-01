# Lecture 11/29/2018

# Topic: Profiling, Timing, and Code Efficiency
# Topic: Multicore programming

#setwd("~/Dropbox/stat327_3/lec_note/")

###### Profile a program ######################

## 1. Profiling in R script

file.edit("nflProfile1.R")
source("nflProfile1.R", keep.source=TRUE)
s1=summaryRprof(lines="show")
s1$by.total

# ---------------------------------------------

###### Time a code fragment ###################

## 2.

browseURL("https://www.imdb.com/chart/top")
system.time(
  readLines("https://www.imdb.com/chart/top")
  )

system.time({n=1000000; x=rnorm(n); 
              y=2*x+3+rnorm(n,0,.1); 
              m=lm(y~x)})

x = runif(50)
system.time(sqrt(x))

n = 1000000
system.time({ for (i in seq_len(n)) { sqrt(x) } })

# ---------------------------------------------

## 3. 

install.packages("microbenchmark")
require("microbenchmark")

a = 2
x = runif(50)

b = microbenchmark(2 + 2, 2 + a, sqrt(x), x ^ .5, times=200)
print(b)

# ---------------------------------------------


###### Code Efficiency ########################
## 4.

# (1) Read necessary part only
file.edit("nflProfile2.R")

# (2) Avoid unnecessary copying
file.edit("loopTiming.R")

# (3) Vetorize 

n=10000; m=matrix(data=as.numeric(1:(n^2)), nrow=n, ncol=n)
system.time(s <- apply(m, 1, sum))
system.time(rs <- rowSums(m))

## Check: rowSums(), colSums(), rowMeans(), colMeans(), 
## ... cumsum(), diff()

# (4) Use 'bytecode' compliation

baby.sapply = function(X, FUN) {
  n = length(X)
  values.FUN = numeric(n)
  for (i in seq_len(n)) {
    values.FUN[i] = FUN(X[i])
  }
  return(values.FUN)
}
x = rnorm(n=10000)
microbenchmark(baby.sapply(X=x, FUN=abs))

# Compilation here.
require(compiler)
baby.sapply.compiled = cmpfun(baby.sapply) 


microbenchmark(baby.sapply.compiled(X=x, FUN=abs))

# ---------------------------------------------


###### Avoid gathering data repeatedly ########

site_src <- 1:10
save(site_src, file="site_src")

# Check working directory

rm(list=ls()) # check Environment
load("site_src") 

top250 <- readLines(
  "https://www.imdb.com/chart/top"
  )

save(top250, file="site_src_top250")

# Check working directory

rm(list=ls())

load("site_src_top250")

# ---------------------------------------------


###### Multicore Programming ##################

rm(list=ls())
require("parallel")

# How many cores does your computer's CPU have?
detectCores()

# Check your OS platform (unix or windows)
.Platform$OS.type 

file.edit("nfl.R")

###### Announcement ###########################

# macOS users

# Before next class, install Xcode
browseURL("https://developer.apple.com/xcode/downloads")
# You need your apple ID 
# .. (or you can download from AppStore)

# ------------------------------------------

# Windows users

# Before next class, install Rtools
browsURL("http://cran.r-project.org/bin/windows/Rtools")