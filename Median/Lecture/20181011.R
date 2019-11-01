# 20181011
#loop

n=3
M=matrix(rep(x=0,times=n^2),nrow=n,ncol=n)

m=M
for(i in 1:n){
  m[i,i]=1
}
m

m=M
for(row in 1:n){
  for(col in row:n){
    m[row,col]=1
  }
}
m

n=3
for(i in seq_len(n)){
  even.or.odd=ifelse(i%%2==0,"even","odd")
  cat(i,"is",even.or.odd,"\n")
}
seq_len(n)
seq_len(length(x))

############
setwd()

for (file.name in list.files()){
  cat("file.name=",file.name,"\n")
}

setwd()


###############

  

repeat{
  cat("please answer 'yes' or 'no':")
  decision=scan(what = character(),n=1,quiet=TRUE)
  if((decision=="yes")|(decision=="no")){
    break
  }
}



# after class exercise
x = c(2, 3, 5)
total = 0
for (x.i in x) { # loop through values
  total = total + x.i
}

seq_len(length(x))
product = 1
for (i in seq_len(length(x))) { # or indices
  product = product * x[i]
}

repeat {
  cat("Pete and Repeat were sitting on fence. Pete fell off. Who was left?\n")
  answer = scan(what=character(), n=1)
  if (answer != "Repeat") {
    break
  }
}




#######loops
# break and next

x<-1:5
for (val in x){
  if(val==3){
    break
  }
  cat("val=",val,"\n")
}


for (n in 1:5){
  if(n==3) next
  cat(n,"\n")
}


n<-0
repeat{
  n=n+1
  if(n>5) break
  if(n==3) next
  cat(n,"\n")
}

######
##wrapping

red.density=function(x,...){
  plot(density(x),col="red",...)
}
red.density=function(x){
  plot(density(x),col="red")
}
red.density(x=rnorm(100),main="two rxtra arguments",lty="dashed")

########
## lapply (list apply)
z=mtcars
str(z)
is.list(z)

?lapply

result.1<-lapply(z,FUN=mean)
result.1

sum(result.1) # does not work

## sapply (simplfied apply)
result.s<-sapply(z, FUN=mean)
result.s

sum(result.s) # does work

sapply(z,quantile)

## mapply (mutiple apply)

x=1:4
y=5:8
z=9:12

mapply(sum,x,y,z)
mapply(prod,x,y,z)
mapply(mean,x,y,z) # not a vector

rep(1:4,4:1)
mapply(rep, 1:4,4) # rep(1,4) rep(2,4) rep(3,4) rep(4,4)

##apply

m=matrix(1:6,nrow = 2,ncol = 3)

apply(X=m, MARGIN = 1,FUN = sum) # 1:row direction
apply(m, 2, sum) # 2:col direction

m[c(1,4)]<-NA
apply(m, 1, sum,na.rm=T)

### ????

n=5
A=matrix(sample(1:100,n^2),5,5)
apply(A, 1, function(x) sum(ifelse(x%%5,0,1))) # x%%5==0, then choose 1, 0 False choose 1

### tapply

tapply(X=mtcars$mpg, INDEX=mtcars$cyl, FUN=mean)

tapply(X=mtcars$mpg,INDEX = list(mtcars$cyl,mtcars$gear),FUN=mean)
mtcars[(mtcars$cyl==6) & (mtcars$gear==3), ] # check tapply() output

table(mtcars$cyl,mtcars$gear)

## use... to pass extra argument "probs=c(.25,.75)" to FUN = quantile:
tapply(X=mtcars$mpg, INDEX=mtcars$cyl, FUN=quantile,probs=c(0.25, 0.75))

















