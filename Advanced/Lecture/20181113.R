#20181113
rm(list=ls())

# e.g. Find the minimum of f(x) = x^2/10 -2*sin(x) in [0, 4].
f = function(x) {
  return(x^2/10 - 2*sin(x))
}

# Golden section  search minimizes a function f() whose opposite -f()
# is unimodal over an interval [lower, upper]. That is, there exists
# some minimizing value m such that x <= m implies f() is decreasing
# and x >= m implies f() is increasing. This search finds m.
#
# Here is the code without any graphing.
golden.section.search = function(f, lower, upper, tol=0.001, ...) {
  phi = (1 + sqrt(5))/2 # golden.ratio (allows cutting 1/2 of calls to f())
  repeat {
    range = upper - lower
    lower.middle = upper - (phi - 1)*range
    upper.middle = lower + (phi - 1)*range
    if (range < tol) {
      return(lower)
    }
    if (f(lower.middle, ...) < f(upper.middle, ...)) {
      upper = upper.middle
    } else {
      lower = lower.middle
    }
  }
}

# Here is the code again, this time code added to make a graph and
# show the progress of the search.
golden.section.search = function(f, lower, upper, tol=0.001, ...) {
  phi = (1 + sqrt(5))/2 # golden.ratio (allows cutting 1/2 of calls to f())
  curve(f, lower, upper) # for graph
  i = 0 # for graph
  repeat {
    range = upper - lower
    lower.middle = upper - (phi - 1)*range
    upper.middle = lower + (phi - 1)*range
    if (i < 4) { # for graph
      points(x=c(lower, lower.middle, upper.middle, upper), y=c(i,i,i,i), col=i+1)
    }
    if (range < tol) {
      abline(v=lower, col="orange") # for graph
      return(lower)
    }
    cat(sep="", "lower=", lower, ", lower.middle=", lower.middle,
        ", upper.middle=", upper.middle, ", upper=", upper, "\n")
    if (f(lower.middle, ...) < f(upper.middle, ...)) {
      upper = upper.middle
    } else {
      lower = lower.middle
    }
    i = i + 1 # for graph
    scan(what=character(), n=1, quiet=TRUE) # Require "Enter" to move.
  }
}

g = golden.section.search(f, 0, 4)
print(g)

h=golden.section.search(f, -15, 15)

optimize(f,c(0,4))

#
rm(list=ls())

f = function(x,y) { # Define function z = f(x, y).
  return(-(cos(x)^2 + cos(y)^2)^2)
}
gradient.f = function(x, y) { # Define function grad(z) = (df.dx, df.dy).
  df.dx = -2 * (cos(x)^2 + cos(y)^2) * (2 * cos(x) * (-sin(x)))
  df.dy = -2 * (cos(x)^2 + cos(y)^2) * (2 * cos(y) * (-sin(y)))
  return(c(df.dx, df.dy))
}

# Plot function, z = f(x, y) over the region -pi/2 <= x, y <= pi/2.
grid.n = 20
limit = pi/2
grid.x = seq(-limit, limit, length.out=grid.n)
grid.y = grid.x
grid.z = outer(grid.x, grid.y, f)
persp.out = persp(grid.x, grid.y, grid.z, theta = 45, phi=60,
                  main="Gradient descent", ticktype="detailed",
                  xlab="x", ylab="y", zlab="z")
legend.gradient = expression(gamma %.% (partialdiff * f / partialdiff * x
                                        * ", " * partialdiff * f / partialdiff * y))
legend(x="topright", legend=c("(x, y)", legend.gradient, "(x, y, z=f(x, y))"),
       pch=c(16, NA, 16), lty=c(0, 1, 0), col=c("blue", "green", "red"))

x = -.98*limit # Starting x
y = .7*limit   # Starting y
old.x = x
old.y = y
n = 20
gamma = .1 # Step size parameter. (Or, better: vary gamma with a line search.)

for(i in seq_len(n)) {
  g = gradient.f(x, y)
  x = x - gamma * g[1]
  y = y - gamma * g[2]
  if (TRUE) { # This block is not part of the algorithm. It just draws.
    z = f(x, y)
    points(trans3d(x=x, y=y, z=0, pmat=persp.out), col="blue", pch=16)
    points(trans3d(x=x, y=y, z=z, pmat=persp.out), col="red", pch=16)
    lines(trans3d(x=c(x, x), y=c(y, y), z=c(0, z), pmat=persp.out), col="red")
    lines(trans3d(x=c(old.x, x), y=c(old.y, y), z=c(0, 0), pmat=persp.out),
          col="green")
    old.x = x
    old.y = y
    scan(what=character(), n=1, quiet=TRUE) # Require "Enter" to move.
  }
}

cat(sep="", "f(", x, ", ", y, ")=", f(x, y), ", gradient.f()=(", g[1], ", ", g[2], ")\n")

# ----------------------------------------------------------------------
# Now convert the code above into a function in the style of R's optim():

# Description: gradient.descent minimizes a function whose gradient is given
# Usage: gradient.descent(par, gr, gamma=.1, epsilon=.01, n=20, verbose=FALSE, ...)
# Parameters:
#   par: a vector of initial values for the function to be minimized
#   gr: gradient function to be evaluated at par
#   gamma: step size parameter
#   epsilon: stop the algorithm as converged when the gradient
#     (as measured by the sum of the absolute values of its components)
#     is smaller than this value
#   n: stop after executing n iterations (to prevent an infinite loop)
#   verbose: if true, print x and |x_{i+1} - x_i| on each iteration
#   ...: additional arguments to be passed to gr()
# Details: gradient.descent iteratively steps in the direction
#   opposite the gradient, quitting after convergence or n iterations
# Value: the value of par at convergence or n iterations
#
gradient.descent = function(par, gr, gamma=.1, epsilon=.01, n=30, verbose=FALSE, ...) {
  for (i in seq_len(n)) {
    gradient = gr(par, ...)
    par = par - gamma * gradient
    gradient.size = sum(abs(gradient))
    if (verbose) {
      cat(sep="", "i=", i, ", par=c(", paste(signif(par, 4), collapse=","),
          "), gradient=c(", paste(signif(gradient, 4), collapse=","),
          "), size=", signif(gradient.size, 4), "\n")
    }
    if (gradient.size < epsilon) {
      break
    }
  }
  return(par)
}

# Test it on the simple function
f = function(x) { x^2 }
# which has a minimum at x=0. Use x=1 as the starting point.
g = function(x) { 2*x }
gradient.descent(par=c(1), gr=g, verbose=TRUE)

# Test it on the cosine mess above. First convert its gradient
# function to receive the current location as a vector "par", not as x
# and y.

gradient.f.using.par = function(par) { # Define gradient(z) = (df.dx, df.dy).
  x = par[1]
  y = par[2]
  df.dx = -2 * (cos(x)^2 + cos(y)^2) * (2 * cos(x) * (-sin(x)))
  df.dy = -2 * (cos(x)^2 + cos(y)^2) * (2 * cos(y) * (-sin(y)))
  return(c(df.dx, df.dy))
}
gradient.descent(par=c(.98*limit, .7*limit), gr=gradient.f.using.par, verbose=TRUE)


####################
rm(list=ls())

f = function(x) { # f(x)
  return(x + sin(x) - 3)
}
f.prime = function(x) { # f'(x)
  return(1 + cos(x))
}

curve(f, from=0, to=6, xlim=c(0, 6), ylim=c(-.5, 1.5), # Plot function.
      main="Newton's method for finding a root\n
      f(x) = x + sin(x) - 3")
abline(h=0) # x axis
abline(v=0) # y axis
up.color = "black"
tangent.color = "red"
up.lty = "dotted"
tangent.lty = "dashed"
legend(x="top",
       legend=c("Move from (x, 0) up to (x, f(x)),",
                "and back to x axis along tangent."),
       lty=c(up.lty, tangent.lty), col=c(up.color, tangent.color))

# Here is the search code without any graphing.
x = 5 # starting point
for (i in seq_len(6)) {
  y = f(x)
  tangent.slope = f.prime(x)
  # The point-slope form of the line through (x0, y0) with slope m is
  #   y - y0 = m(x - x0).
  # Plug in y = 0 to see the x-intercept is x = x0 - y0/m.
  tangent.x.intercept = x - y/tangent.slope
  x = tangent.x.intercept # Prepare to repeat the process.
  cat(sep="", "x_", i, "=", x, ", f(x)=", y, "\n")
}

# Here is the search code again, this time code added to make a graph
# and show the progress of the search.
x = 5 # starting point
for (i in seq_len(6)) {
  y = f(x)
  tangent.slope = f.prime(x)
  # The point-slope form of the line through (x0, y0) with slope m is
  #   y - y0 = m(x - x0).
  # Plug in y = 0 to see the x-intercept is x = x0 - y0/m.
  tangent.x.intercept = x - y/tangent.slope
  text(x=x+.09, y=.05, labels=bquote(x[.(i)])) # x_i label
  segments(x0=x, y0=0, x1=x, y1=y, col=up.color, lty=up.lty) # vertical line
  points(x, y, pch=19) # point on curve
  scan(what=character(), n=1, quiet=TRUE) # Require "Enter" to move.
  segments(x0=x, y0=y, x1=tangent.x.intercept, y1=0, col=tangent.color, lty=tangent.lty) # tangent
  x = tangent.x.intercept # Prepare to repeat the process.
  cat(sep="", "x_", i, "=", x, ", f(x)=", y, "\n")
}


# Nelder-Mead, see https://en.wikipedia.org/wiki/Nelder-Mead_method.

rm(list=ls())

f.no.vector = function(x,y) { # Define function z = f(x, y).
  return(-(cos(x)^2 + cos(y)^2)^2)
}

if (FALSE) { # Here's another function to try. Maybe mess with its minimum.
  f.no.vector = function(x,y) {
    x0 = 0
    y0 = 0
    return((x-x0)^2 + (y-y0)^2)
  }
}

f = function(x) { # Define function z = f(x).
  return(f.no.vector(x[1], x[2]))
}

# Plot function, z = f(x, y) over the region -pi/2 <= x, y <= pi/2.
grid.n = 20
limit = pi/2
grid.x = seq(-limit, limit, length.out=grid.n)
grid.y = grid.x
grid.z = outer(grid.x, grid.y, f.no.vector)
persp.out = persp(grid.x, grid.y, grid.z, theta = 100, phi=60,
                  main="Nelder-Mead", ticktype="detailed",
                  xlab="x", ylab="y", zlab="z")
legend(x="topright", legend=c("xy plane", "xyz surface"),
       pch=c(2, 2), col=c("blue", "red"))

distance = function(a, b) {
  return(sum(abs(a-b)))
}

start.x = -.98*limit
start.y =   .7*limit
x1 = c(start.x, start.y)
x2 = x1 + c(.1*limit, 0       )
x3 = x1 + c(0       , .1*limit)
x = cbind(x1, x2, x3)
n = 2

nm = function(par, f, n.iterations=100,
              alpha=1, gamma=2, rho=1/2, sigma=1/2, epsilon=0.01,
              draw=FALSE, debug=FALSE) {
  x = par
  n = dim(x)[2] - 1
  old.x = x
  for(i in seq_len(n.iterations)) {
    f.x = apply(X=x, MARGIN=2, FUN=f)
    x = x[ , order(f.x)] # Order points according to f() (wiki step 1).
    d = distance(x, old.x)
    if (debug) {
      cat(sep="", "i=", i, ", x=\n")
      print(x)
      cat(sep="", "f.x=\n")
      print(f.x)
      cat(sep="", "d=", d, "\n")
    }
    if (d <epsilon) {
      break
    }
    old.x = x
    x.0 = rowSums(x[ , 1:n]) / n # Calculate centroid (wiki step 2).
    x.reflected = x.0 + alpha * (x.0 - x[ , n + 1]) # Relection (wiki step 3).
    if ((f(x[ , 1]) <= f(x.reflected)) && (f(x.reflected) < f(x[ , n]))) {
      x[ , n + 1] = x.reflected
    } else if (f(x.reflected) < f(x[ , 1])) { # Expansion (wiki step 4).
      x.expanded = x.0 + gamma * (x.reflected - x.0)
      if (f(x.expanded) < f(x.reflected)) {
        x[ , n + 1] = x.expanded
      } else {
        x[ , n + 1] = x.reflected
      }
    } else { # Contraction (wiki step 5).
      stopifnot(f(x.reflected) >= f(x[ , n]))
      x.contracted = x.0 + rho * (x[ , n + 1] - x.0)
      if (f(x.contracted) < f(x.reflected)) {
        x[ , n + 1] = x.contracted
      } else { # Shrink (wiki step 6).
        x[ , -1] = x[ , 1] + sigma * (x[ , -1] - x[ , 1])
      }
    }
    if (draw && (n == 2)) { # This block is not part of the algorithm. It just draws.
      x.2d = matrix(data=0, nrow=2, ncol=3)
      x.2d.z0 =x.2d
      for (j in 1:(n+1)) {
        p.x = x[1, j]
        p.y = x[2, j]
        z = f.x[j]
        x.2d[ , j]    = unlist(trans3d(x=p.x, y=p.y, z=z, pmat=persp.out))
        x.2d.z0[ , j] = unlist(trans3d(x=p.x, y=p.y, z=0, pmat=persp.out))
      }
      polygon(x=x.2d   [1, ], y=x.2d   [2, ], border="black", col="red")
      polygon(x=x.2d.z0[1, ], y=x.2d.z0[2, ], border="blue")
      Sys.sleep(1)
    }
  }
  return(x)
}

best.x = nm(x, f, draw=TRUE, debug=TRUE)
cat("best.x=\n")
print(best.x)

################
SSE = function(beta, x, y) { # usual least squares
  return(sum((y - (beta[1] + beta[2] * x))^2))
}
out = optim(par=c(0, 0), fn=SSE, x=mtcars$wt, y=mtcars$mpg)
m = lm(mpg ~ wt, data=mtcars)
m$coefficients
out2 = optim(par=c(0, 0), fn=SSE, x=mtcars$wt, y=mtcars$mpg, control=list(reltol=1e-12))
out2$par
# Try constant model too.

