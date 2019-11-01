# This code is from "Data Visualization with ggplot2 Cheat Sheet" at
# www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf.
#
# I've marked with "# ----------" those lines I'll run in class.

rm(list=ls())
if (!require("ggplot2")) { # ----------
  install.packages("ggplot2")
  stopifnot(require("ggplot2"))
}

# Work with ggplot2's "mpg" data frame.
?mpg  # ----------
str(mpg)
head(mpg)
mpg

# Basics
qplot(x=cty, y=hwy, color=cyl, data=mpg, geom="point") # ----------
ggplot(data=mpg, aes(x=cty, y=hwy))
ggplot(data=mpg, aes(x=cty, y=hwy)) +
  geom_point(aes(color=cyl)) +
  geom_smooth(method="lm") +
  coord_cartesian() +
  scale_color_gradient() +
  theme_bw()

last_plot()
ggsave("plot.png", width=5, height=5)

# Geoms
#   One Variable
#     Continuous
a <- ggplot(mpg, aes(hwy))
a + geom_area(stat="bin")
a + geom_density(kernel="gaussian") # ----------
a + geom_dotplot() # ----------
a + geom_freqpoly()
a + geom_histogram(binwidth=5) # ----------
#     Discrete
b <- ggplot(mpg, aes(fl)) # ----------
b + geom_bar() # ----------

#   Graphical Primitives
c <- ggplot(map, aes(long, lat))   # doesn't run: map unknown (maybe require("maps"), ...)
c + geom_polygon(aes(group=group)) # doesn't run: c unknown
d <- ggplot(economics, aes(date, unemploy)) # ----------
d + geom_path(lineend="butt", linejoin="round", linemitre=1) # ----------
d + geom_ribbon(aes(ymin=unemploy-900, ymax=unemploy+900))
e <- ggplot(seals, aes(x=long, y=lat))
e + geom_segment(aes(xend=long+delta_long, yend=lat+delta_lat))
e + geom_rect(aes(xmin=long, ymin=lat, xmax=long+delta_long, ymax=lat+delta_lat))

#   Two Variables
#     Continuous X, Continuous Y
f <- ggplot(mpg, aes(cty, hwy))
f + geom_blank()
f + geom_jitter()
f + geom_point() # ----------
f + geom_quantile()
f + geom_rug() # ---------- also: f + geom_point() + geom_rug()
f + geom_smooth() # ---------- also: f + geom_point() + geom_smooth(method="lm")
f + geom_text(aes(label=cty), nudge_x=1, nudge_y=1, check_overlap=TRUE) # ----------

#     Discrete X, Continuous Y
g <- ggplot(mpg, aes(class, hwy)) # ----------
g + geom_bar(stat="identity")
g + geom_boxplot() # ----------
g + geom_dotplot(binaxis="y", stackdir="center") # ----------
g + geom_violin(scale="area") # ----------

#     Discrete X, Discrete Y
h <- ggplot(diamonds, aes(cut, color))
h + geom_jitter() # ---------- also: h + geom_point()

#     Continuous Bivariate Distribution
if (!require("ggplot2movies")) {
  install.packages("ggplot2movies")
  stopifnot(require("ggplot2movies"))
}
i <- ggplot(movies, aes(year, rating))
i + geom_bin2d(binwidth=c(5,0.5))
i + geom_density2d()
i + geom_hex()

#     Continuous Function
j <- ggplot(economics, aes(date, unemploy))
j + geom_area()
j + geom_line()
j + geom_step(direction="hv")

#     Visualizing error
df <- data.frame(grp=c("A","B"), fit=4:5, se=1:2)
k <- ggplot(df, aes(grp, fit, ymin=fit-se, ymax=fit+se))
k + geom_crossbar(fatten=2)
k + geom_errorbar()
k + geom_linerange()
k + geom_pointrange()

#     Maps
data <- data.frame(murder=USArrests$Murder, state=tolower(rownames(USArrests))) # ----------
map <- map_data("state") # ----------
l <- ggplot(data, aes(fill=murder)) # ----------
l + geom_map(aes(map_id=state), map=map) + expand_limits(x=map$long, y=map$lat) # ----------

#   Three Variables
seals$z <- with(seals, sqrt(delta_long^2 + delta_lat^2)) # ----------
m <- ggplot(seals, aes(long, lat)) # ----------
m + geom_contour(aes(z=z)) # ----------
m + geom_raster(aes(fill=z), hjust=0.5, vjust=0.5, interpolate=FALSE)
m + geom_tile(aes(fill=z))

# Stats
#   1D distributions
c + stat_bin(binwidth=1, origin=10) # doesn't work: c undefined
c + stat_count(width=1) # doesn't work: c undefined
c + stat_density(adjust=1, kernel="gaussian") # doesn't work: c undefined
#   2D distributions
e + stat_bin2d(bins=30, drop=T) # cheatsheet typo: not "stat_bin_2d"
e + stat_bin_hex(bins=30) # doesn't work: probably need require("hexbin")
e + stat_density2d(contour=TRUE, n=100) # cheatsheet typo: not "stat_density_2d"
e + stat_ellipse(level=0.95, segments=51, type="t") # doesn't work
if (!require("maps")) {
  install.packages("maps")
  stopifnot(require("maps"))
}
l + stat_contour(aes(z=z)) # doesn't work
l + stat_summary_hex(aes(z=z), bins=30, fun=max) # doesn't work
l + stat_summary2d(aes(z=z), bins=30, fun=mean) # cheatsheet typo: not "stat_summary_2d"; doesn't work
#   3 variables
#   Comparisons
f + stat_boxplot(coef=1.5) # no comparison?
f + stat_ydensity(kernel="gaussian", scale="area") # no comparison?
#   Functions
e + stat_ecdf(n=40)
e + stat_quantile(quantiles=c(0.1, 0.9), formula=y~log(x), method="rq") # need require("quantreg")
e + stat_smooth(method="lm", formula=y~x, se=T, level=0.95)
ggplot() + stat_function(aes(x=-3:3), n=99, fun=dnorm, args=list(sd=0.5)) # ----------
e + stat_identity(na.rm=TRUE)
ggplot() + stat_qq(aes(sample=1:100), dist=qt, dparam=list(df=5)) # ----------
e + stat_sum()
e + stat_summary(fun.data="mean_cl_boot") # need require("Hmisc")
h + stat_summary_bin(fun.y="mean", geom="bar") # doesn't work
#   General purpose
e + stat_unique()

# Scales
(n <- b + geom_bar(aes(fill=fl))) # ---------- # cheatsheet typo: not "d + geom_bar(aes(fill=fl))"
n + scale_fill_manual(values=c("skyblue","royalblue","blue","navy"), # ----------
                      limits=c("d","e","p","r"), breaks=c("d","e","p","r"), # ----------
                      name="fuel", labels=c("D","E","P","R")) # ----------

#    Color and fill scales (Discrete)
n + scale_fill_brewer(palette="Blues") # ----------
n + scale_fill_grey(start=0.2, end=0.8, na.value="red") # ----------

#    Color and fill scales (Discrete)
o <- c + geom_dotplot(aes(fill=..x..)) # doesn't work
o + scale_fill_distiller(palette="blues") # doesn't work, missing "o"
o + scale_fill_gradient(low="red",high="yellow") # doesn't work, missing "o"
o + scale_fill_gradient2(low="red",high="blue", mid="white", midpoint=25) # doesn't work, missing "o"
o + scale_fill_gradientn(colours=top.colors(6)) # doesn't work, missing "o"

#    Shape and size scales
p <- f + geom_point(aes(shape=fl, size=cyl)) # ---------- # cheatsheet typo: not "e + geom_point..."
p + scale_shape() + scale_size() # ----------
p + scale_shape_manual(values=c(3:7)) # ----------
p + scale_radius(range=c(1,6)) # doesn't work
p + scale_size_area(max_size=6) # ----------

#   Coordinate Systems
r <- d + geom_bar() # doesn't work
r + coord_cartesian(xlim=c(0, 5)) # doesn't work, missing "r"
r + coord_fixed(ratio=1/2) # doesn't work, missing "r"
r + coord_flip() # doesn't work, missing "r"
r + coord_polar(theta="x", direction=1) # doesn't work, missing "r"
r + coord_trans(ytrans="sqrt") # doesn't work, missing "r"
r + coord_quickmap() # cheatsheet typo: not "pi + "?
#   Faceting
t <- ggplot(mpg, aes(cty, hwy)) + geom_point() # ----------
t + facet_grid(. ~ fl) # ----------
t + facet_grid(year ~ .) # ----------
t + facet_grid(year ~ fl) # ----------
t + facet_wrap(~ fl) # ---------- also t + facet_wrap(year ~ fl)
t + facet_grid(drv ~ fl, scales="free") # ----------
t + facet_grid(. ~ fl, labeller=label_both)
t + facet_grid(fl ~ ., labeller=label_bquote(alpha ^ .(fl))) # doesn't work
t + facet_grid(. ~ fl, labeller=label_parsed)

#   Position Adjustments
# ... fill in later ...

#   Labels
t + labs(x="New x axis label", y="New y axis label", # ----------
         title="Add a title above the plot", # ----------
         subtitle="Add a subtitle below title", # ----------
         caption="Add a caption below plot") # ----------
         ... fill in later ...) # doesn't work
t + annotate(geom="text", x=8, y=9, label="A") # ----------

#   Legends
n + theme(legend.position="bottom") # ----------
n + guides(fill="none")
n + scale_fill_discrete(name="Title", labels=c("A","B","C","D","E"))

#   Themes
# ... fill in later ...

#   Zooming
# ... fill in later ...
