# Name: Naiqing Cai
# Email: ncai5@wisc.edu

rm(list = ls())

# Implement Connect Four in the same manner that we
# implemented Tic-tac-toe in class. Start by implementing
# the helper functions, below, and testing them by running
#   source("hw3test.R")
# Then write code for the game itself.
#
# We'll test your code by running
#   source("hw3.R")
# We might also play Connect Four, read your code, and do other tests.

# Returns TRUE if vector v (of character strings) contains
# (at least) four in a row of player (character string). e.g.
#   four.in.a.row("X", c("O","X","X","X","X","O"))
# is TRUE, while
#   four.in.a.row("O", c("O","X","X","X","X","O"))
# is FALSE.
four.in.a.row = function(player, v, debug=FALSE) {
  if (debug) {
    cat(sep="", "four.in.a.row(player=", player, ", v=", v, ")\n")
  }
  with(rle(v), any(lengths== 4 & values == player))
}

# Returns TRUE if (matrix) board (of character strings)
# contains at least four in a row of (string) player, who
# just played in position (r, c). (Here "r" means "row" and
# "c" means "column").
#
# Hint: this function should call four.in.a.row() four times, once
# each for the current row, column, diagonal, and reverse diagonal.
won = function(player, board, r, c, debug=FALSE) {
  if (debug) {
    cat(sep="", "won(player=", player, ", board=\n")
    print(board)
    cat(sep="", ", r=", r, ", c=", c, ")\n")
  }
  return(four.in.a.row(player, board[r, ]) | four.in.a.row(player, board[, c]) | four.in.a.row(player, board[row(board) - col(board) == r - c]) | 
           four.in.a.row(player, board[row(board) + col(board) == r + c])) # correct this return() statement
}

# Returns largest index of an empty position in column col
# of (matrix) board. If there is no such empty position in
# board, return value is NULL.
largest.empty.row = function(board, col, debug=FALSE) {
  if (debug) {
    cat(sep="", "largest.empty.row(board=\n")
    print(board)
    cat(sep="", ", col=", col, ")\n")
  }
  v = board[, col]
  count = 0
  for (i in 1:6) {
    if (v[i] == "E") 
      count = count + 1
  }
  return(count) # correct this return() statement
}

source("hw3test.R") # Run tests on the functions above.

# ... your code to implement Connect Four using the
# functions above ...
m<-7
n<-6
x<-rep(1:m,each=n)
y<-rep(1:n,times=m)

plot(x,y,type = "n",xlim = c(0,m+1),ylim = c(n+1,0))

segments(x0=c(rep(0.5, n+1), seq(0.5, m+0.5, 1)),
         y0=c(seq(0.5, n+0.5, 1), rep(0.5, m+1)),
         x1=c(rep(m+0.5, n+1), seq(0.5, m+0.5, 1)),
         y1=c(seq(0.5, n+0.5, 1), rep(n+0.5, m+1)))

board = matrix(data=rep("E", times=n*m), nrow=n, ncol=m)

player = "X"
for (i in 1:(n*m)) {
  if (player == "X") { # human player
    repeat {
      index = identify(x, y, n=1, plot=FALSE)
      col = x[index]
      row = largest.empty.row(board,col)
      if (is.null(row) == FALSE) {
        break
      } else {
        text(x=2, y=n+0.7, labels="This is a full colunm, please choose another one.")
      }
    }
  } else { # computer player
    index = sample(x=which(c(board) == "E"), size=1)
    col = x[index]
    row = largest.empty.row(board, col)
  }
  board[row, col] = player
  text(x=col, y=row, labels=player)
  cat(sep="", "i=", i, ", player=", player, ", index=", index,
      ", row=", row, ", col=", col, ", board:", "\n")
  print(board)
  if (won(player, board, row, col, debug=TRUE)) {
    text(x=2, y=0.15, labels=paste(player, " won!"), col="red")
    break
  }
  player = ifelse(test=(player == "X"), yes="O", no="X")
}



# Hint: this program is modeled on the tic-tac-toe program we did in
# class, so studying the latter program is worthwhile.

# Note that a user click in a column indicates that a checker should
# go to that column's lowest empty row (unless the column is full).

# Note that you should implement a computer player. At the least, it
# should choose randomly from among the non-full columns. (Feel free
# to do much more! If your computer player beats me on its first try,
# you will earn a package of M&Ms. This is a hard task. Feel free to
# ask for tips.)
# function test cases