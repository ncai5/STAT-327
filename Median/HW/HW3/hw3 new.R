rm(list=ls()) # clear all defined objects
#setting up the connect_four board
four.in.a.row = function(player, v, debug=FALSE) {
  if (debug) {
    cat(sep="", "four.in.a.row(player=", player, ", v=", v, ")\n")
  }
  with(rle(v), any(lengths== 4 & values == player))
}

won = function(player, board, r, c, debug=FALSE) {
  if (debug) {
    cat(sep="", "won(player=", player, ", board=\n")
    print(board)
    cat(sep="", ", r=", r, ", c=", c, ")\n")
  }
  return(four.in.a.row(player, board[r, ]) | four.in.a.row(player, board[, c]) | four.in.a.row(player, board[row(board) - col(board) == r - c]) | 
           four.in.a.row(player, board[row(board) + col(board) == r + c]))
}

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
  return(count)
}

par(pty = "s")
x = rep(1:7, each = 6)
y = rep(1:6, times = 7)
symbols(x = x, y = y, squares = rep(1, 42), inches = FALSE, xlim = c(0, 8), 
        ylim = c(8, 0))

board = matrix(rep("E", 42), nrow = 6, ncol = 7)
player = "X"
for (j in 1:42) {
  if (player == "X") {
    repeat {
      index = identify(x, y, n = 1, plot = FALSE)
      col = x[index]
      row = y[largest.empty.row(board, col)]
      if (board[row, col] == "E") {
        break
      }
    }
  } else {
    board.vector = c(board)
    empty.indices = which(board.vector == "E")
    index = sample(x = empty.indices, size = 1)
    col = x[index]
    row = y[largest.empty.row(board, col)]
  }
  text(col, row, player)
  board[row, col] = player
  print(board)
  if (won(player, board, row, col)) {
    cat(sep = "", player, " won!\n")
    break
  }
  player = ifelse(player == "X", "O", "X")
}




# function test cases
stopifnot(!four.in.a.row(player="X", v=c(rep("X", 3)), debug=TRUE))
stopifnot(!four.in.a.row(player="O", v=c(rep("X", 3)), debug=TRUE))

stopifnot(!four.in.a.row(player="X", v=c(rep("X", 3), rep("O", 3)), debug=TRUE))
stopifnot(!four.in.a.row(player="O", v=c(rep("X", 3), rep("O", 3)), debug=TRUE))

stopifnot(!four.in.a.row(player="X", v=c("O", rep("X", 3), "O"), debug=TRUE))
stopifnot(!four.in.a.row(player="O", v=c("O", rep("X", 3), "O"), debug=TRUE))

stopifnot(four.in.a.row(player="X", v=c(rep("X", 4)), debug=TRUE))
stopifnot(four.in.a.row(player="O", v=c(rep("O", 4)), debug=TRUE))

stopifnot(four.in.a.row(player="X", v=c("O", rep("X", 4), "O"), debug=TRUE))
stopifnot(four.in.a.row(player="O", v=c("X", rep("O", 4), "X"), debug=TRUE))

x = matrix(data=c(
  "E","E","E","E","E","E","E",
  "E","E","E","E","E","E","E",
  "E","E","E","E","E","E","E",
  "E","E","E","E","E","E","E",
  "E","E","E","E","E","E","E",
  "E","E","E","E","E","E","E"
), nrow=6, ncol=7, byrow=TRUE)
stopifnot(!won(player="X", board=x, r=1, c=1, debug=TRUE))
stopifnot(!won(player="O", board=x, r=1, c=1, debug=TRUE))
stopifnot(!won(player="X", board=x, r=2, c=3, debug=TRUE))
stopifnot(!won(player="O", board=x, r=2, c=3, debug=TRUE))

x = matrix(data=c(
  "E","E","E","E","E","E","O",
  "E","E","E","E","E","E","O",
  "E","E","E","E","E","E","O",
  "E","E","E","E","E","E","O",
  "E","E","E","E","E","E","X",
  "X","X","X","X","O","E","X"
), nrow=6, ncol=7, byrow=TRUE)
stopifnot( won(player="X", board=x, r=6, c=1, debug=TRUE))
stopifnot(!won(player="O", board=x, r=6, c=1, debug=TRUE))
stopifnot(!won(player="X", board=x, r=1, c=7, debug=TRUE))
stopifnot( won(player="O", board=x, r=1, c=7, debug=TRUE))

x = matrix(data=c(
  "E","E","E","E","E","E","E",
  "E","E","X","O","E","E","E",
  "E","E","O","X","O","E","E",
  "E","E","X","X","X","O","E",
  "E","E","O","X","O","X","O",
  "E","E","X","O","X","X","O"
), nrow=6, ncol=7, byrow=TRUE)
stopifnot( won(player="X", board=x, r=2, c=3, debug=TRUE))
stopifnot(!won(player="O", board=x, r=2, c=3, debug=TRUE))
stopifnot(!won(player="X", board=x, r=2, c=4, debug=TRUE))
stopifnot( won(player="O", board=x, r=2, c=4, debug=TRUE))

x = matrix(data=c(
  "E","E","E","E","E","E","E",
  "E","E","E","X","O","E","E",
  "E","E","X","O","X","E","E",
  "E","X","O","X","O","E","E",
  "X","O","O","O","X","E","E",
  "X","O","X","X","O","E","E"
), nrow=6, ncol=7, byrow=TRUE)
stopifnot( won(player="X", board=x, r=5, c=1, debug=TRUE))
stopifnot(!won(player="O", board=x, r=5, c=1, debug=TRUE))
stopifnot( won(player="X", board=x, r=4, c=2, debug=TRUE))
stopifnot(!won(player="O", board=x, r=4, c=2, debug=TRUE))
stopifnot(!won(player="X", board=x, r=2, c=5, debug=TRUE))
stopifnot( won(player="O", board=x, r=2, c=5, debug=TRUE))

stopifnot(4 == largest.empty.row(board=x, col=1, debug=TRUE))
stopifnot(3 == largest.empty.row(board=x, col=2, debug=TRUE))
stopifnot(2 == largest.empty.row(board=x, col=3, debug=TRUE))
stopifnot(1 == largest.empty.row(board=x, col=4, debug=TRUE))
stopifnot(1 == largest.empty.row(board=x, col=5, debug=TRUE))
stopifnot(6 == largest.empty.row(board=x, col=6, debug=TRUE))
stopifnot(6 == largest.empty.row(board=x, col=7, debug=TRUE))

