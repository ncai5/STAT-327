#20181009
# if sttt
x = -3
if (x<0){
  x=-x
}
x

# if~else sttt
x=3
if((x%%2)==0){
  parity="even"
} else{
  parity="odd"
}
parity

# bad
rm(parity)
x=5
if((x%%2)==0){parity="even"} 
else{parity="odd"}
parity

# if~else if~else sttt
# Celcius version/32, 212 for Fahrenheit
temperature=60
if (temperature<0){
  state ="frozen"
} else if(temperature>100){
  state="boiling"
} else {
  state=""
}
state

# be careful
total.percent=89;

if(total.percent>=92){
  letter="A"
} else if(total.percent>=88){
  letter="B"
} else letter="C"

letter
  

x=sample(1:100,10);
x
ifelse((x%%2)==0,"even","odd")


#####
baby.max=function(a,b){
  if(a>b){
    return(a)
  } else{
    return(b)
  }
}

baby.max(3,4)

## exams: know what function it is
is.heads=function(){
  r=rnorm(1)
  if (r<0){
    return(TRUE)
  } else {
    return(FALSE)
  }
}
is.heads()

## another way
is.heads=function(){
  return(rnorm(1)<0)
}
is.heads()
  
n=100;
coins= replicate(n, is.heads())
coins

sum(coins)/n

X:  the number of heads
n: 100

### X~binom(n=100,p=.5)



#########################
# 2. parameter/argmt
square.a=function(a=1,b=2){
  cat(sep = "","square.a(a=",a,", b=",b,")\n")
  b=100
  c=a*a
  return(c)
}
square.a(3,4)
square.a()
square.a(b=4,3)

nx=rnorm(100);
?rnorm

### 3. local

square.a=function(a=1,b=2){
  cat(sep = "","square.a(a=",a,", b=",b,")\n")
  b=100
  c=a*a
  return(c)
}

a=5; b=6; c=7
square.a(b)
a
b
c

### 4.return, end of expression
# until excution meets return or last braces

baby.tan1<- function(x){
  ...
}


result1=1e-10
tan(pi)
result1==tan(pi)

all.equal(result1,tan(pi)) # if the difference smaller than ... it will be ture
?all.equal
.Machine$double.eps

#########
baby.tan2<- function(x){
  ...
}

result2=1e-3
all.equal(result2,tan(pi))
isTRUE(all.equal(result2,tan(pi)))

#############
stopifnot(0<1,3<4)
stopifnot(0<1,4<2)

baby.tan2<- function(x){
  ...
}


# result1=1e-10
# result2=1e-3

stopifnot(isTRUE(all.equal(result1,tan(pi))))
stopifnot(isTRUE(all.equal(result2,tan(pi))))


###

baby.t.test = function(x, mu=0, conf.level=.95) {
  stopifnot(length(x) >= 2)
  stopifnot((0 < conf.level) & (conf.level < 1))
  n = length(x)
  x.bar = mean(x)
  s.x = sd(x)
  t = (x.bar - mu) / (s.x / sqrt(n))
  r = list() # set up r as return value, results have different length
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
t = t.test(x=1:10, mu=5, conf.level=.90)
baby.t
# check is there any error
stopifnot(isTRUE(all.equal(baby.t$statistic, as.numeric(t$statistic))))
stopifnot(isTRUE(all.equal(baby.t$parameter, as.numeric(t$parameter))))
stopifnot(isTRUE(all.equal(baby.t$p.value, as.numeric(t$p.value))))
stopifnot(isTRUE(all.equal(baby.t$conf.int, as.numeric(t$conf.int))))
stopifnot(isTRUE(all.equal(baby.t$estimate, as.numeric(t$estimate))))
stopifnot(isTRUE(all.equal(baby.t$null.value, as.numeric(t$null.value))))

names(baby.t$statistic)
names(t$statistic)

# hw1









