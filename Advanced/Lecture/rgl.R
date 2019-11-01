install.packages("rgl")

## macOS users!!! 
# Need to install XQuartz and ...
# ... log out the system and back.
browseURL("https://www.xquartz.org")


# Example from GP#1 - Multi-dim'l optimization

require(rgl)

conc <- function(x,y){
  z <- 7.9 + 0.13*x + 0.21*y - 0.05*x^2 - 0.016*y^2 - 0.007*x*y
  return(z)
}

x <- seq(from=-10, to=10, by=0.5)
y <- seq(from= 0, to=20, by=0.5)
z <- outer(x,y,conc)

open3d()
bg3d("white")
material3d(col = "black")

persp3d(x, y, z, 
        aspect = c(1, 1, 0.5), col = "lightblue",
        xlab = "X", ylab = "Y", zlab = "Z")



k=120
z = function(x, y, k) {
  ifelse (test=((abs(x) > k) | (abs(y) > k)),
          yes=0,
          no=(1 - x/k)*(1 - y/k)*(1 + x/k)*(1 + y/k)*
            (-(y + 47) * sin(sqrt(abs(y + x/2 + 47))) - x*sin(sqrt(abs(x - (y + 47)))))
  )
}

x <- seq(from=-k,to=k, by=10)
y <- seq(from=-k, to=k, by=10)
xy<-expand.grid(x,y)
library(rgl)
h<- z(xy[,1],xy[,2],k=120)
persp3d(x, y, h, 
        aspect = c(1, 1, 0.5), col = "ivory",
        xlab = "X", ylab = "Y", zlab = "Z")

optim(par=c(0,0),fn=-z,k=120)


points3d(x,y,z,size=10,col="red")
box3d()
points(trans3d(x,y,z,size=10,col='red'))




k=120
z = function(x, y, k) {
  k=120
  ifelse (test=((abs(x) > k) | (abs(y) > k)),
          yes=0,
          no=(1 - x/k)*(1 - y/k)*(1 + x/k)*(1 + y/k)*
            (-(y + 47) * sin(sqrt(abs(y + x/2 + 47))) - x*sin(sqrt(abs(x - (y + 47)))))
  )
}

x <- seq(from=-k,to=k, by=10)
y <- seq(from=-k, to=k, by=10)
xy<-expand.grid(x,y)
library(rgl)
h<- z(xy[,1],xy[,2])
persp3d(x, y, h, size=10,main="3-D",
        aspect = c(1, 1, 0.5), col = "lightblue",
        xlab = "X", ylab = "Y", zlab = "Z")
f = function(x, k) {
  ifelse (test=((abs(x[1]) > k) | (abs(x[2]) > k)),
          yes=0,
          no=-(1 - x[1]/k)*(1 - x[2]/k)*(1 + x[1]/k)*(1 + x[2]/k)*
            (-(x[2] + 47) * sin(sqrt(abs(x[2] + x[1]/2 + 47))) - x[1]*sin(sqrt(abs(x[1] - (x[2] + 47)))))
  )
}

localoptim=optim(c(0,0),fn=f,k=120)
znew=-1*localoptim$value
xnew=localoptim$par[1]
ynew=localoptim$par[2]
points3d(x=xnew,y=ynew,z=znew,col="red")

list=list()
for (i in seq(-120,120,by=10)){
  for (j in seq (-120,120,by=10))
    for (k in 1:nrow(xy)){
      list[[k]]=(optim(c(i,j),fn=f,k=120))
    }
}
list

localoptims=






