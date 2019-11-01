# You should replace all occurrences of "..." with your
# code. If you'd like to replace a single "..." with more
# than one line of code (using your own variables), you may
# certainly do that. Please don't remove all my comments, as they
# help orient us when we're reading your code.
#
# My solution to this homework uses information from the first two
# handouts and the Vector portion of the third handout.
#
# We'll grade your homework by running this ".R" file via
#   source("hw2.R")
# (in a directory containing the data files) and reading your code.

# Name: Naiqing Cai
# Email: ncai5@wisc.edu

rm(list = ls()) # Remove all objects defined in workspace.

# Download WI_donations and NY_donations from the class website. (Do
# this outside of R. They are donations from Wisconsin and New York to
# the 2012 presidential candidates. I got them from files at
# www.fec.gov/disclosurep/PDownload.do, a Federal Election Commission
# website.)
#
# Read these two files into two vectors, one for each state.

v1<-scan(file="WI_donations",what=numeric())
v2<-scan(file="NY_donations",what=numeric())

# Find the sum of donations from WI and the sum of donations from NY.

WI.sum = sum(v1) #  set this variable correctly
NY.sum = sum(v2) #  set this variable correctly
cat(sep="", "WI sum=", WI.sum, "\n")
cat(sep="", "NY sum=", NY.sum, "\n")

# Find the sum of small donations from each state. I've set small=100
# (below). Let's say "small donation" are those such that
#   -100 <= donation <= 100.
# (Note that there are negative donations, which are refunds.)

small = 100
WI.sum.small = sum(v1[which((v1<100) & (v1> -100))]) # set this variable correctly
NY.sum.small = sum(v2[which((v2<100) & (v2> -100))]) # set this variable correctly
cat(sep="", "WI.sum.small=", WI.sum.small, "\n")
cat(sep="", "NY.sum.small=", NY.sum.small, "\n")

# Find the sum of big donations from each state. Let's say "big
# donations" are those such that
#   donation < -100 or donation > 100.
WI.sum.big = sum(v1[which(v1>100|v1< -100)]) # set this variable correctly
NY.sum.big = sum(v2[which(v2>100|v2< -100)]) # set this variable correctly
cat(sep="", "WI.sum.big=", WI.sum.big, "\n")
cat(sep="", "NY.sum.big=", NY.sum.big, "\n")

# Find the ratio of the sum of small donations to the sum of all
# donations from each state.
WI.small.ratio = WI.sum.small/WI.sum # set this variable correctly
NY.small.ratio = NY.sum.small/NY.sum # set this variable correctly
cat(sep="", "WI.small.ratio=", WI.small.ratio, "\n")
cat(sep="", "NY.small.ratio=", NY.small.ratio, "\n")

# Find the mean positive donation from each state. (Do not include
# zero or negative donations.)
WI.mean.pos = mean(v1[which(v1>0)]) # set this variable correctly
NY.mean.pos = mean(v2[which(v2>0)]) # set this variable correctly
cat(sep="", "WI.mean.pos=", WI.mean.pos, "\n")
cat(sep="", "NY.mean.pos=", NY.mean.pos, "\n")

# Find the median positive donation from each state. (Do not include
# zero or negative donations.)
WI.median.pos = median(v1[which(v1>0)]) # set this variable correctly
NY.median.pos = median(v2[which(v2>0)]) # set this variable correctly
cat(sep="", "WI.median.pos=", WI.median.pos, "\n")
cat(sep="", "NY.median.pos=", NY.median.pos, "\n")

# Find the largest and second-largest positive donation from each
# state. Write code, including a cat() statement or two, to produce
# formatted output exactly like this (except that the numbers should
# be correct, not 0):
#
# WI.largest=0, WI.second.largest=0
# NY.largest=0, NY.second.largest=0

WI.largest=max(v1[which(v1>0)])
WI.second.largest=max(v1[which(v1<WI.largest)])
NY.largest=max(v2[which(v2>0)])
NY.second.largest=max(v2[which(v2<NY.largest)])
cat(sep="", "WI.largest=", WI.largest, ",", "WI.second.largest=", WI.second.largest, "\n")
cat(sep="", "NY.largest=", NY.largest, ",", "NY.second.largest=", NY.second.largest, "\n")

# Note that your code should work on the current data set, and also on
# a new data set. For example, if I ask for a sum, don't use "17",
# even if the sum is 17, because 17 will probably be wrong for a new
# data set. Instead, use sum(...), since this second solution will be
# correct even for a new data set.
#
# I recommend checking that your code works on the files WI_tiny and
# NY_tiny, which are fake data files for which you can check your
# computations by hand. Get your code working on them, and then switch
# to the real data files specified above. Your submitted code should
# use the real files, "WI_donations" and "NY_donations".
