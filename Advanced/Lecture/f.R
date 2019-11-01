# This form takes (x, y) and k as three parameters.
e = function(x, y, k) {
  ifelse (test=((abs(x) > k) | (abs(y) > k)),
          yes=0,
          no=(1 - x/k)*(1 - y/k)*(1 + x/k)*(1 + y/k)*
            (-(y + 47) * sin(sqrt(abs(y + x/2 + 47))) - x*sin(sqrt(abs(x - (y + 47)))))
  )
}

# This form takes (x, y) as the 2-vector x and k as a second parameter.
f = function(x, k) {
  ifelse (test=((abs(x[1]) > k) | (abs(x[2]) > k)),
          yes=0,
          no=(1 - x[1]/k)*(1 - x[2]/k)*(1 + x[1]/k)*(1 + x[2]/k)*
            (-(x[2] + 47) * sin(sqrt(abs(x[2] + x[1]/2 + 47))) - x[1]*sin(sqrt(abs(x[1] - (x[2] + 47)))))
  )
}