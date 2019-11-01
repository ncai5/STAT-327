# 20181030
a = c("Brown,Joe 123456789 jbrown@wisc.edu 1000",
      "Roukos,Sally 456789123 sroukos@wisc.edu 5000",
      "Chen,Jean 789123456 chen@wisc.edu 24000",
      "Juniper,Jack 345678912 jjuniper@wisc.edu 300000")

gsub(pattern = "n\\>", replacement = "#", x = a)
gsub(pattern = "\\J", replacement = "#", x = a)

b="!abba%aba,ab_ba abba;abba3abba__abba#abba"

gsub(pattern = "\\<a", replacement = "A", x = b)
gsub(pattern = "a\\<", replacement = "A", x = b)
gsub(pattern = "a\\>", replacement = "A", x = b)



b=c("3","234","25v2c1","hello")
gsub(pattern = "\\d{2}",replacement = "#", x = b) 
gsub(pattern = "\\d{2,}",replacement = "#", x = b) 

b=c("3","234","25v2364c1","hello")
gsub(pattern = "\\d{2,3}",replacement = "#", x = b) 
gsub(pattern = "\\d{2,}",replacement = "#", x = b) 
gsub(pattern = "\\d{0,}",replacement = "#", x = b) 
gsub(pattern = "\\d{1,}",replacement = "#", x = b) 

a = c("Brown,Joe 123456789 jbrown@wisc.edu 1000",
      "Roukos,Sally 456789123 sroukos@wisc.edu 5000",
      "Chen,Jean 789123456 chen@wisc.edu 24000",
      "Juniper,Jack 345678912 jjuniper@wisc.edu 300000")
grep(pattern = "\\d{4}$", x = a) # 4 digits, end-of-line
grep(pattern = " \\d{4}$", x = a) # space, 4 digits, end-of-line
grep(pattern = " \\d{4,5}$", x = a) # space, 4 or 5 digits, end-of-line

gsub(pattern="\\d{1, }" , replacement="&", x=a)
gsub(pattern="\\d{1, }?" , replacement="&", x=a) # ? 


grep(pattern = "Joe|Jack", x = a)
grep(pattern = "J(o|a)", x = a)

strsplit(x=a, split=",")
strsplit(x=a, split=" +")
strsplit(x=a, split=",|( +)")

a = c("Brown,Joe 123456789 jbrown@wisc.edu 1000",
      "Roukos,Sally 456789123 sroukos@wisc.edu 5000",
      "Chen,Jean 789123456 chen@wisc.edu 24000",
      "Juniper,Jack 345678912 jjuniper@wisc.edu 300000")

b = sub(pattern = "(\\w+),(\\w+) +(\\d+) (\\w+).*", replacement = "\\2,\\1,\\4,\\3", x=a)
b

link = "blah blah blah ... <a href=http://www.google.com>Google</a> blah ..."
sub(pattern=".*<a href=(.*)>.*" , replacement="\\1", x=link) # match too much
sub(pattern=".*<a href=(.*?)>.*" , replacement="\\1", x=link) # one fix
sub(pattern=".*<a href=([^>]*)>.*", replacement="\\1", x=link) # another fix
sub(pattern=" *<a href=(.*)>.*" , replacement="\\1", x=link) # space


## ggplot
# fuel economy data
dim(mpg)
head(mpg)

summary(mpg)
for (i in 1:length(mpg)) {
  print(names(mpg[i]))
  col = mpg[[i]]
  if (is.integer(col)) {
    print(table(col))
  } else if (is.numeric(col)) {
    print(summary(col))
  } else {
    stopifnot(is.character(col) | is.factor(col))
    print(table(col))
  }
}

# 3 key components to each plot:
# - data
# - aesthetic mappings specifying x and y (and other things)
# - geom indicating how to render each observation
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
ggplot(mpg, aes(    displ,     hwy)) + geom_point() # "x=" and "y=" unnecssary

ggplot(mpg, aes(model, manufacturer)) + geom_point()

ggplot(mpg, aes(cty, hwy)) + geom_point()
ggplot(diamonds, aes(carat, price)) + geom_point()
ggplot(economics, aes(date, unemploy)) + geom_line()
ggplot(mpg, aes(cty)) + geom_histogram()

# colour, size, shape, etc.
g = ggplot(mpg, aes(cty, hwy,colour = class)) + geom_point()
g
g + aes(displ, hwy, colour = class)
g + aes(displ, hwy, shape = drv)
g + aes(displ, hwy, size = cyl)

ggplot(mpg, aes(displ, hwy, colour = "blue")) + geom_point() # can't specify uniform color here
ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")  # color is fixed at blue

# faceting
ggplot(mpg, aes(displ, hwy)) + geom_point() + facet_wrap(~class)

# geoms
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth()
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method="lm")
ggplot(mpg, aes(displ, hwy)) + geom_boxplot()
ggplot(mpg, aes(hwy)) + geom_histogram()
ggplot(mpg, aes(class)) + geom_bar() # categorical variable

