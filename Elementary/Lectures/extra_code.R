###################
# lec_0925
###################

n = 100
x <- rnorm(n)
y <- rnorm(n)
k <- factor(sample(1:2,20,replace = TRUE), labels = c("M","F"))
z <- data.frame(x=x,y=y,k=k)

plot(z$x, z$y, pch=16, cex=2, col=z$k, xlab="x-value", ylab="y-value", main = "Title is here")

palette()
z$k

str(z$k)
palette()[z$k] # same as col=z$k

legend("topleft", legend=c("M","F"))
legend("topleft", legend=c("M","F"), col =c("black","red"), pch = 16)

legend("bottomright", legend=c("M","F"), lty = c(1,2), lwd = c(1,2))
# But, do we need to specify all the level and color name like this?

# For much more levels
palette(rainbow(12))
palette()


###################
# lec_0920
###################

sex <- c(1,2,1,1,1,2)
name <- c("A","B","C","D","E","F")
data = data.frame(name=name, sex=sex)

summary(sex)

sex2 <- factor(sex,labels=c("M","F"))

summary(sex2)

data$sex <- sex2

a1 <- scan("test", what=numeric())
a2 <- read.table("test", header = F)

sort(a1)
sort(a2)

x <- mtcars
plot(x$mpg,x$wt,cex=3)
points(20,4, col="red", cex=3, pch=16)
lines(c(15,20),c(2,3), lwd=3)

abline(a=2,b=0.1, lwd=3)
abline(v=20, col="green", lty=2, lwd=3)
abline(h=4, col="blue", lwd=3)

par(mfrow=c(2,4))
layout.show(8)

par(mfrow=c(1,1))

