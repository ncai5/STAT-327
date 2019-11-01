# 20181106
rm(list=ls())

if (!require("ggplot2")) {      # If loading package fails,
  install.packages("ggplot2")   # download it from internet,
  stopifnot(require("ggplot2")) # and insist that it load.
}

# fuel economy data
dim(mpg)
head(mpg)

# geoms
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth()
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method="lm")
ggplot(mpg, aes(displ, hwy)) + geom_boxplot()
ggplot(mpg, aes(hwy)) + geom_histogram()
ggplot(mpg, aes(class)) + geom_bar() # categorical variable

# boxplots and jittered points
ggplot(mpg, aes(drv, hwy)) + geom_point() # repeated points overplotted, e.g. table(mpg$hwy)
ggplot(mpg, aes(drv, hwy)) + geom_jitter()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_violin()

# histograms and frequency polygons
ggplot(mpg, aes(hwy)) + geom_histogram()
ggplot(mpg, aes(hwy)) + geom_freqpoly()
ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth = 1)
ggplot(mpg, aes(displ)) + geom_freqpoly(binwidth = 0.5)

# ... map categorical variable to fill (geom_histogram()) or colour
# ... (geom_freqpoly())
ggplot(mpg, aes(displ, colour = drv)) + geom_freqpoly(binwidth = 0.5)
ggplot(mpg, aes(displ, fill = drv)) + geom_histogram(binwidth = 0.5)

# bar charts (categorical variable)
ggplot(mpg, aes(manufacturer)) + geom_bar() # for unsummarized data
drugs <- data.frame(drug = c("a", "b", "c"),
                    effect = c(4.2, 9.7, 6.1)
)
ggplot(drugs, aes(drug, effect)) + geom_bar(stat = "identity") # for summarized data

# time series
ggplot(economics, aes(date, unemploy / pop)) + geom_line()
ggplot(economics, aes(date, uempmed)) + geom_line()

# output: note next line doesn't display anything:
g = ggplot(mpg, aes(cty, hwy)) + geom_point()
# to see it, call print():
print(g) # or just g

# save to file
ggsave("plot.png", width=5, height=5)

# qplot for quick plots (with syntax more like base graphics)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, colour = class, data = mpg)
qplot(displ, data = mpg)
