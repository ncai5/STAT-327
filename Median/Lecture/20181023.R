# 20181023

# 1. Draw tic-tac-toe board.
# 2. Add board and playing loop.
# 3. Add click-to-play.
# 4. Add check for a win.
# 5. Require play on empty square. (And change empty representation
#    from "E" to "" because it makes board easier to read.)

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
      all(diag(board[3:1, ]) == player)
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

board = matrix(data=rep("", times=9), nrow=3, ncol=3)
player = "X"
for (i in 1:9) {
  repeat {
    index = identify(x, y, n=1, plot=FALSE)
    col = x[index]
    row = y[index]
    if (board[row, col] == "") {
      break
    } else {
      text(x=2, y=3.7, labels="Please click on empty square.")
    }
  }
  board[row, col] = player
  text(x=col, y=row, labels=player)
  cat(sep="", "i=", i, ", player=", player, ", index=", index,
      ", row=", row, ", col=", col, ", board:", "\n")
  print(board)
  if (won(board, player, debug=TRUE)) {
    text(x=2, y=1/3, labels=paste(player, " won!"), col="red")
    break
  }
  player = ifelse(test=(player == "X"), yes="O", no="X")
}

# 6. Add computer player.

# review
x<-matrix(1:4,2,2)
x0=c(x)

sample(1:4,size = 2)

which(x0%%2==0)

sample(which(x0%/%2==1),size = 1)


##########################

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
      all(diag(board[3:1, ]) == player)
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

board = matrix(data=rep("", times=9), nrow=3, ncol=3)
player = "X"
for (i in 1:9) {
  if (player == "X") { # human player
    repeat {
      index = identify(x, y, n=1, plot=FALSE)
      col = x[index]
      row = y[index]
      if (board[row, col] == "") {
        break
      } else {
        text(x=2, y=3.7, labels="Please click on empty square.")
      }
    }
  } else { # computer player
    index = sample(x=which(c(board) == ""), size=1)
    col = x[index]
    row = y[index]
  }
  board[row, col] = player
  text(x=col, y=row, labels=player)
  cat(sep="", "i=", i, ", player=", player, ", index=", index,
      ", row=", row, ", col=", col, ", board:", "\n")
  print(board)
  if (won(board, player, debug=TRUE)) {
    text(x=2, y=1/3, labels=paste(player, " won!"), col="red")
    break
  }
  player = ifelse(test=(player == "X"), yes="O", no="X")
}

# 7. Generalize program to play n-by-n, not 3-by-3, tic-tac-toe.
#    ... coming soon ...

rm(list=ls()) # clear all defined objects

won = function(board, player, debug=FALSE) {
  if (debug) {
    cat(sep="", "player=", player, ", board=", "\n")
    print(board)
  }
  n = dim(board)[1]
  stopifnot(n == dim(board)[2])
  for (i in 1:n) {
    if (all(board[1:n, i] == player) | # won in column i
        all(board[i, 1:n] == player)) { # won in row i
      return(TRUE)
    }
  }
  return(all(diag(board) == player) |   # won in diagonal
           all(diag(board[n:1, ]) == player)) # won in reverse diagonal
}
test.board = matrix(data=c("X","O","E", "O","X","O", "X","O","X"), nrow=3, ncol=3)
stopifnot( won(test.board, "X"))
stopifnot(!won(test.board, "O"))
test.board[2, 2] = "O"
stopifnot(!won(test.board, "X"))
stopifnot( won(test.board, "O"))

n = 5
x = rep(1:n, each = n)
y = rep(1:n, times = n)

plot(x, y, type="n", xlim=c(0, n+1), ylim=c(n+1, 0))
#segments(x0=c(0.5, 0.5, 1.5, 2.5), y0=c(1.5, 2.5, 0.5, 0.5),
#         x1=c(3.5, 3.5, 1.5, 2.5), y1=c(1.5, 2.5, 3.5, 3.5))

segments(x0=c(rep(0.5, n-1), seq(1.5, n-0.5, 1)),
         y0=c(seq(1.5, n-0.5, 1), rep(0.5, n-1)),
         x1=c(rep(n+0.5, n-1), seq(1.5, n-0.5, 1)),
         y1=c(seq(1.5, n-0.5, 1), rep(n+0.5, n-1)))

board = matrix(data=rep("", times=n^2), nrow=n, ncol=n)
player = "X"
for (i in 1:(n^2)) {
  if (player == "X") { # human player
    repeat {
      index = identify(x, y, n=1, plot=FALSE)
      col = x[index]
      row = y[index]
      if (board[row, col] == "") {
        break
      } else {
        text(x=2, y=n+0.7, labels="Please click on empty square.")
      }
    }
  } else { # computer player
    index = sample(x=which(c(board) == ""), size=1)
    col = x[index]
    row = y[index]
  }
  board[row, col] = player
  text(x=col, y=row, labels=player)
  cat(sep="", "i=", i, ", player=", player, ", index=", index,
      ", row=", row, ", col=", col, ", board:", "\n")
  print(board)
  if (won(board, player, debug=TRUE)) {
    text(x=2, y=1/3, labels=paste(player, " won!"), col="red")
    break
  }
  player = ifelse(test=(player == "X"), yes="O", no="X")
}


# pattern matching
a = c("Brown,Joe 123456789 jbrown@wisc.edu 1000",
      "Roukos,Sally 456789123 sroukos@wisc.edu 5000",
      "Chen,Jean 789123456 chen@wisc.edu 24000",
      "Juniper,Jack 345678912 jjuniper@wisc.edu 300000")
a
grep(pattern = "j", x = a) # which element contain small j, default index
grep(pattern = "j", x = a, ignore.case=TRUE, value = TRUE) # whatever capital or small j, actual value

sub(pattern = "e", replacement = "E", x = a)
gsub(pattern = "e", replacement = "_E_", x = a)

# Regular Expressions




