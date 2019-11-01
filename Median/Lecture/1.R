four.in.a.row = function(player, v) {
  if (TRUE) {
    # use FALSE to disable this debugging code
    cat(sep = "", "four.in.a.row(player=", player, ", v=", v, ")\n")
  }
  if (length(v) < 4) {
    return(FALSE)
  } else {
    count = 1
    i = 2
    while (i <= length(v)) {
      if (v[i] == v[i - 1]) {
        count = count + 1
      } else count = 1
      if ((count >= 4) & (v[i] == player)) {
        return(TRUE)
      }
      i = i + 1
    }
  }
  return(FALSE)
}

won = function(player, board, r, c) {
  if (TRUE) {
    # use FALSE to disable this debugging code
    cat(sep = "", "won(player=", player, ", board=\n")
    print(board)
    cat(sep = "", ", r=", r, ", c=", c, ")\n")
  }
  
  return(four.in.a.row(player, board[r, ]) | four.in.a.row(player, board[, 
                                                                         c]) | four.in.a.row(player, board[row(board) - col(board) == r - c]) | 
           four.in.a.row(player, board[row(board) + col(board) == r + c]))
  return(FALSE)
}

largest.empty.row = function(board, col) {
  if (TRUE) {
    # use FALSE to disable this debugging code
    cat(sep = "", "largest.empty.row(board=\n")
    print(board)
    cat(sep = "", ", col=", col, ")\n")
  }
  v = board[, col]
  count = 0
  for (i in 1:6) {
    if (v[i] == "E") 
      count = count + 1
  }
  return(count)
  return(6)
}

par(pty="s") # square plot type
x = rep(1:7, each = 6)
y = rep(1:6, times = 7)

symbols(x, y, squares=rep(1, times=42),
        inches=FALSE, # match squares to axes
        xlim=c(0,8),
        ylim=c(7,0)) # flip y axis to match matrix format
board = matrix(rep("E", times=42), nrow=6, ncol=7)
player = "X"
for (i in 1:42) { # loop through 42 turns
  if (player == "X") {
    repeat { # get user input on empty square
      index = identify(x, y, n=1,plot=FALSE) # , plot=FALSE
      #row = y[index]
      col = x[index]
      row=largest.empty.row(board, col)
      if (is.null(row)){
        next
      }else if (is.null(col)){
        next
      } else if (board[row, col] == "E") {
        break
      }else {next}
    }
  }
  else { # computer chooses random empty square
    open.indices = which(c(board)=="E")
    index = sample(x=open.indices, size=1)
    #row = y[index]
    col = x[index]
    row=largest.empty.row(board, col)
  }
  board[row, col] = player
  #text(x=x[index], y=y[index], labels=player)
  text(x=col, y=row, labels=player)
  print(board)
  if (won(player, board, row, col)) {
    text(x=2, y=.2, labels=paste(player, "won!"), col="red")
    break
  }
  player = ifelse(player == "X", "O", "X")
}