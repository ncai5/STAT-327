rm(list=ls())

# 1) install 'devtools' and 'roxygen2'
install.packages(c("devtools","roxygen2"))

# ----------------------------------------------------

# 2) (Important!) Set working directory
## 
setwd("/Users/cainaiqing/Desktop/ncai5hw2")

# ----------------------------------------------------

# 3) Load packages
require("devtools")
# give access tocheck(), build()

require("roxygen2")
# give access to document()

# ----------------------------------------------------

# 4) Create a template for the package
create_package("robust", open =FALSE) #package name "mypackage"

# ----------------------------------------------------

# 5) Go to pckg_prac_mac/mypackage/ and open DESCRIPTION
## Just click the file (or load in RStudio directly)

# ----------------------------------------------------

# 6) Change the 'License' part and save. For example:
## License: GPL-2 

# ----------------------------------------------------

# 7) Write down (or copy and paste) main functions and ...
# help documents under the folder "R".

# ----------------------------------------------------

# 8) Generate an example dataset, if any. For example,
area=read.csv("http://www.stat.wisc.edu/~jgillett/327-3/2/farmLandArea.csv")
use_data(area, overwrite = T, compress = "gzip")

getwd() #check
list.files() #check
# ----------------------------------------------------

# 9) Write a help document for the dataset (e.g, "x.R") ...
# under the "R" folder.

# ----------------------------------------------------

# 10) Generate package following command lines below
## If some errors happens here, make reload the packages
## require("devtools"); require("roxygen2")

document(pkg = "robust") # make (help-) documents
check(pkg = "robust") 
build(pkg = "robust")

# (Some warnings might happen. As long as no errors, it is ok.)

# ----------------------------------------------------

# 11) Install and load your own package

rm(list=ls())
install.packages("robust_0.1.tar.gz", 
                 repos = NULL, 
                 type = "source")

# ----------------------------------------------------

# 12) (Important!!!) Shutdown R studio and open "master.R" 

require("robust")
# ----------------------------------------------------

# 13) Test your package

example(lad)


?lad
?predict.lad
?print.lad
?coef.lad
?area

# run example under the help document of 'baby.factorial()'
## If something went wrong here, quit R studio and re-try ...
## from the step 12.

example(baby.factorial)

# ----------------------------------------------------