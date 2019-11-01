
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
