# name: Naiqing Cai
# email: ncai5@wisc.edu

#how.many function
how.many =function(item,n.max) {
    cat(sep = "","How many ",item,"?\n")
    n<-readline()
    while (n>n.max) {
      cat(" ERROR: too many for the budget\n")
      cat(sep = "","How many ",item,"?\n")
      n<-readline()
    }
    return(as.numeric(n))
}

#grocery.list function
grocery.list =function(file,budget) {
  groceries<-read.csv("groceries.csv",header = F,as.is = T)
  colnames(groceries)<-c("item","price")
  groceries[,2]<-as.numeric(groceries[,2])
  print(groceries)
  quantity<-rep( 0,nrow( groceries ))
  budget<-10
  for ( i in 1:nrow( groceries ) ) {
    if ( groceries[i,2] <= budget ) {
      quantity[i] <- how.many( groceries[i,1],budget/groceries[i,2] ) 
      budget <- ( budget - quantity[i]*groceries[i,2] )
    } 
  }
  list_purchase<-cbind(groceries,quantity)
  list_purchase<-list_purchase[list_purchase$quantity!=0,]
  rownames(list_purchase)<-NULL
  return(list_purchase)
}

shopping_list<-grocery.list("groceries.csv",10)
total_bill<-0
for (i in 1:nrow(shopping_list)) {
  total_bill<-total_bill+shopping_list[i,2]*shopping_list[i,3]
}
print(shopping_list)
cat(sep = "","Your bill is $",total_bill)
