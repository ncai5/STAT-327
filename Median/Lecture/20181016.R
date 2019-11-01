#20181016
# generate an array
a = array(data=-(1:24), dim=c(3,4,2))
dimnames(a) = list(c("slow", "medium", "fast"), c("cold", "tepid", "warm", "hot"),
                   c("Monday", "Tuedsay"))
a
a[2,3,1]
# change dim
dim(a) = c(4, 6) # 4 by 6
a
dim(a) = NULL # vector
a
dim(a) = c(2, 3, 2, 2) # 2 by 3 by 2 by 2
a
dim(a) = c(3, 4, 2) # back to start
a
# index
a[2,3,1]
a[,3:4,2]
length(dim(a))

index = matrix(data=c(1,1,1, 2,2,2), nrow=2, ncol=length(dim(a)), byrow=TRUE)
index
a[index]

(a %% 2) == 0 # Which values are even?
a[(a %% 2) == 0] # Get even values.
a[(a %% 2) == 0] = -a[(a %% 2) == 0] # Set even values: multiply by -1
a[(a %% 2) == 0]

# matrix
m = matrix(data=1:12, nrow=3, ncol=4, byrow=TRUE)
m
kids = matrix(data=c(c(1,2,6,7,9,11), c(1,5,100,100,100,100)),
              nrow=2, ncol=6, byrow=TRUE,
              dimnames=list(c("Age","#Toys"),c("Teresa","Margaret","Monica","Andrew","Mary","Philip")))
kids

cbind(m, 101:103)
rbind(m, 101:104)

row(m)
col(m)

row(m) == col(m)
m[row(m) == col(m)] # main diagonal
row(m) - col(m)
r = 2; c = 3
m[row(m) - col(m) == r - c] # diagonal through (r, c)
# reverse
m[row(m) + col(m) == r + c] # reverse diagonal through (r, c)


A=matrix(data=1:4, nrow=2, ncol=2)
B=matrix(data=1:4, nrow=2, ncol=2)
A * B
A %*% B 
A = matrix(data=1:4, nrow=2, ncol=2)
b = c(7, 10)
(x = solve(a=A, b=b))
A %*% x
solve(A)





