#Testing and Debugging
scan("numbersBug.txt", what=integer()) #there is an character 180th
file.edit("numbersBug.txt")
scan("numbersBug.txt", what=integer(),nlines = 180) #increasing number ore decreasing number until find the bug

source("baby.dbinom.R")
# 

#Test code in small chunks. 

#set the default condition if-then statement

soft_threshold=function(x){
  if (x>3){
    return(1)
  } else if(x< -3){
    return(-1)
  } else{
    return(0)
  }
}


n=10000
z<-sample(-100:100,n,replace=T)
length(z)

fz<-c()
for(i in 1:n){
  cat("i=",i,"\n")
  fz[i]=soft_threshold(z[i])
}
z[2]
fz[1]

# Use descriptive variable names to write “self-documenting” code
func_21 <- c(21)




#hw2
install.packages("robust_0.1.tar.gz",repos = NULL,type="source")
require("robust")
example(lad)
example(lad)
?lad
?predict.lad
?print.lad
?coef.lad
?area

