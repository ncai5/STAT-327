# 20181018

# 1. Draw tic-tac-toe board.

rm(list=ls()) # clear all defined objects

n=3

x = rep(1:3, each = 3)
y = rep(1:3, times = 3)

plot(x,y,asp = 1,bty="n",cex=4) # nine points
plot(x,y,asp=1,bty="n",type="n")

plot(x, y, type="n", xlim=c(0, 4), ylim=c(4, 0),asp=1,bty="n")


segments(x0=c(0.5, 0.5, 1.5, 2.5), y0=c(1.5, 2.5, 0.5, 0.5),
         x1=c(3.5, 3.5, 1.5, 2.5), y1=c(1.5, 2.5, 3.5, 3.5))

# 2. Add board and playing loop.

rm(list=ls()) # clear all defined objects

x = rep(1:3, each = 3)
y = rep(1:3, times = 3)

plot(x, y, type="n", xlim=c(0, 4), ylim=c(4, 0),asp=1,bty="n")
segments(x0=c(0.5, 0.5, 1.5, 2.5), y0=c(1.5, 2.5, 0.5, 0.5),
         x1=c(3.5, 3.5, 1.5, 2.5), y1=c(1.5, 2.5, 3.5, 3.5))

board = matrix(data=rep("E", times=9), nrow=3, ncol=3)
player = "X" # start from x
for (i in 1:9) {
  cat(sep="", "i=", i, ", player=", player, "\n")
  # ... player takes a turn ...
  player = ifelse(test=(player == "X"), yes="O", no="X")
}



# identify function
plot(0:5,0:5,"n")
x0=1:2
y0=3:4
cbind(x0,y0)
identify(x=x0,y=y0,n=1)
#
rm(list=ls()) # clear all defined objects
plot(0:5,0:5,"n")
x1=c(3,4,1,2)
y1=c(1,3,2,1)
cbind(x1,y1)
identify(x=x1,y=y1,n=1)
identify(x=x1,y=y1,n=1,plot=F)


# 3. Add click-to-play.

rm(list=ls()) # clear all defined objects

x = rep(1:3, each = 3)
y = rep(1:3, times = 3)

plot(x, y, xlim=c(0, 4), ylim=c(4, 0))
segments(x0=c(0.5, 0.5, 1.5, 2.5), y0=c(1.5, 2.5, 0.5, 0.5),
         x1=c(3.5, 3.5, 1.5, 2.5), y1=c(1.5, 2.5, 3.5, 3.5))
cbind(x,y)

board = matrix(data=rep("E", times=9), nrow=3, ncol=3)
player = "X"
for (i in 1:9) {
  index = identify(x, y, n=1) # click 9 times
  col = x[index]
  row = y[index]
  board[row, col] = player # replace E with x
  text(x=col, y=row, labels=player)
  cat(sep="", "i=", i, ", player=", player, ", index=", index,
      ", row=", row, ", col=", col, ", board:", "\n")
  print(board)
  # ... player takes a turn ...
  player = ifelse(test=(player == "X"), yes="O", no="X")
}


# review all()
all(c(F,F,F))
all(c(T,F))
all(c(T,T,T))

x=c(1,2,3,4)
all(x%%2==0|x%%2==1)

# review break or next
for (i in 1:5) {
  if (i%%2==0){
    break
  }
  cat(i,"\n")
}

for (i in 1:5) {
  if (i%%2==1){
    next
  }
  cat(i,"\n")
}

# for(i in 1:n){
# ..
#   if(...) break
#}

# for (i in 1:n)[
#   ...
#   for (j in 1:n){
#   ...
#     if (...) break
#   } 
# ]


for (i in 1:3) {
  for (j in 1:3){
    if(j==2) break
    cat(i+j,"\n")
  }
}

# 4. Add check for a win.

rm(list=ls()) # clear all defined objects

won = function(board, player, debug=FALSE) {
  if (debug) {
    cat(sep="", "player=", player, ", board=", "\n")
    print(board)
  }
  return(
    all(board[1:3, 1] == player) |   # check columns 1-3
      all(board[1:3, 2] == player) |
      all(board[1:3, 3] == player) |
      all(board[1, 1:3] == player) | # check rows 1-3
      all(board[2, 1:3] == player) |
      all(board[3, 1:3] == player) |
      all(diag(board) == player) |   # check diagonals
      all(diag(board[3:1, ]) == player) # check reverse diagonals
  )
}
test.board = matrix(data=c("X","O","E", "O","X","O", "X","O","X"), nrow=3, ncol=3)
stopifnot( won(test.board, "X"))
stopifnot(!won(test.board, "O"))
test.board[2, 2] = "O"
stopifnot(!won(test.board, "X"))
stopifnot( won(test.board, "O"))

x = rep(1:3, each = 3)
y = rep(1:3, times = 3)

plot(x, y, type="n", xlim=c(0, 4), ylim=c(4, 0))
segments(x0=c(0.5, 0.5, 1.5, 2.5), y0=c(1.5, 2.5, 0.5, 0.5),
         x1=c(3.5, 3.5, 1.5, 2.5), y1=c(1.5, 2.5, 3.5, 3.5))

board = matrix(data=rep("E", times=9), nrow=3, ncol=3)
player = "X"
for (i in 1:9) {
  index = identify(x, y, n=1, plot=FALSE)
  col = x[index]
  row = y[index]
  board[row, col] = player
  text(x=col, y=row, labels=player)
  cat(sep="", "i=", i, ", player=", player, ", index=", index,
      ", row=", row, ", col=", col, ", board:", "\n")
  print(board)
  if (won(board, player, debug=TRUE)) {
    text(x=2, y=1/3, labels=paste(player, " won!"), col="red")
    break
  } # win function
  player = ifelse(test=(player == "X"), yes="O", no="X")
}

# guideline for hw2
# 2 submission !!
# part four

z<-resd.csv("groceries.csv",header=F)
n=dim(z)[1]
str(z)

for (i in 1:n) {
  cat(z[i,1],"\n")
  
}

str(z)

w<-resd.csv("groceries.csv",header=F,as.is=T)
for (i in 1:n) {
  cat(w[i,1],"\n")
  
}

str(w)

source("hw2grocery.R")

## part one













