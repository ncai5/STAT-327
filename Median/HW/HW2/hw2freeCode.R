# ----------------------------------------------------------------------
# Don't change this file. It contains functions you'll need
# to complete hw2.R, which calls source() to read this file.
# ----------------------------------------------------------------------

# Returns the letter grade (character string) corresponding
# to percentage.
PercentageGrade = function(percentage) {
  # A = [92,100], AB = [88,92), B = [82,88), BC = [78,82), C = [70,78), D = [60,70), F = [0,60)
  if (is.na(percentage))
    return("F")
  if (percentage >= 92)
    return("A")
  else if (percentage >= 88)
    return("AB")
  else if (percentage >= 82)
    return("B")
  else if (percentage >= 78)
    return("BC")
  else if (percentage >= 70)
    return("C")
  else if (percentage >= 60)
    return("D")
  else
    return("F")
}

# Returns the letter grade (character string) corresponding
# to percentile.
PercentileGrade = function(percentile) {
  # A = 70, AB = 60, B = 45, BC = 30, C = 10, D = 5, F = 0
  if (is.na(percentile))
    return("F")
  if (percentile >= 70)
    return("A")
  else if (percentile >= 60)
    return("AB")
  else if (percentile >= 45)
    return("B")
  else if (percentile >= 30)
    return("BC")
  else if (percentile >= 10)
    return("C")
  else if (percentile >= 5)
    return("D")
  else
    return("F")
}

# Returns the higher of the two letter grades, x and y
# (character strings).
#
# (I intend this to be called on one letter grade from a
# percentage scale and one from a percentile grade.)
CourseGrade = function(x, y) {
  if (x == "A" | y == "A")
    return("A")
  else if (x == "AB" | y == "AB")
    return("AB")
  else if (x == "B" | y == "B")
    return("B")
  else if (x == "BC" | y == "BC")
    return("BC")
  else if (x == "C" | y == "C")
    return("C")
  else if (x == "D" | y == "D")
    return("D")
  else
    return("F")
}
