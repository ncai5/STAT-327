sex=c(1,2,1,1,2,1)
name=c("A","B","C","D","E","F")
data=data.frame(name=name,sex=sex)
sex2=factor(sex,labels = c("M","F"))
data$sex=sex2
summary(data)

a1=scan()#read data as a list
a2=data.table()#read data as data frame


