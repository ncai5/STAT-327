# source("nflProfile2.R", keep.source=TRUE)
# s2=summaryRprof(lines="show")
# s2$by.total

# rm(list=ls())
if (!require("XML")) {
  install.packages("XML")
  stopifnot(require("XML"))
}

Rprof(line.profiling=TRUE) # ----- turn profiling on -----

teams.url = "http://www.nfl.com/teams"
# http://www.nfl.com/teams/statistics?team=GB
lines = readLines(teams.url)
# <option value="/teams/greenbaypackers/statistics?team=GB">Statistics</option>
team.lines = grep(pattern=".*/teams/.*/statistics\\?team=.*", x=lines, value=TRUE)
team.abbreviations = sub(pattern=".*/teams/.*/statistics\\?team=(.*)\">Stat.*", replacement="\\1", x=team.lines)

best.rushing = numeric(length(team.abbreviations))
best.receiving = numeric(length(team.abbreviations))
i = 1
for (team in team.abbreviations) {
  url = paste0("http://www.nfl.com/teams/statistics?team=", team)
  print(url)
# tables = readHTMLTable(url)
# best.rushing[i]   = sum(as.numeric(as.character(tables[[3]][ ,3])))
# best.receiving[i] = sum(as.numeric(as.character(tables[[4]][ ,3])))
  # ----- speed up readHTMLTable() by selecting required tables and indicating column types -----
  tables = readHTMLTable(url, colClasses=c("character", rep("numeric", 5)), which=c(3,4))
  best.rushing[i]   = sum(tables[[1]][-1 ,3])
  best.receiving[i] = sum(tables[[2]][-1 ,3])
  i = i + 1
}

Rprof(NULL) # ----- turn profiling off -----

plot(x=best.rushing, y=best.receiving)
abline(lm(best.receiving ~ best.rushing))
cor(best.rushing, best.receiving)
