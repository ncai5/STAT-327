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

optim(c(0,0),fn=f,k=120)

localoptim=optim(c(0,0),fn=f,k=120)
znew=-1*localoptim$value
xnew=localoptim$par[1]
ynew=localoptim$par[2]
points3d(x=xnew,y=ynew,z=znew,size=10,col="red")



list=list()
for (i in seq(-120,120,by=10)){
  for (j in seq (-120,120,by=10))
    for (k in 1:nrow(xy)){
      list[[k]]=(optim(c(i,j),fn=f,k=120))
    }
}
list

list=list()
for (i in xy[,1]){
  for (j in xy[,2]){
    for (k in 1:nrow(xy)){
      list[[k]]=(optim(c(i,j),fn=f,k=120))
    }
  }
}
list




