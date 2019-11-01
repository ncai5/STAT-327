a<-c(2,3,4)

a[c(1,3,2,1,1,2)]

n=100
x<-rnorm(n)
y<-rnorm(n)
k<-factor(sample(1:2,n,replace=T),labels=c("M","F"))
z=data.frame(x=x,y=y,k=k)

plot(z$x,z$y)
plot(z$x,z$y,pch=16,col=z$k,cex=2,xlab = "x",ylab = "y",main = "Title is here")

palette()
z$k
# male black & female red

color<-palette()
color[z$k]

# over 8 levels they will reuse

# set color
palette(rainbow(12))
palette()

legend("topright",legend = c("M","F"),col = c("black","red"),pch=16)

levels(z$k)
palette()
palette("default")# back to 8 colors
