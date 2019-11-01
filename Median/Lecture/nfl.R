rm(list=ls())

if (!require("XML")) { # for readHTMLTable()
  install.packages("XML")
  stopifnot(require("XML"))
}

TEAMS = "http://www.nfl.com/teams"
lines = readLines(TEAMS) # 2544 lines of HTML
team.lines = grep(pattern="statistics", x=lines, value=TRUE) # 32 team lines,
# each of the form:
# "\t\t\t\t\t\t\t\t<option value=\"/teams/greenbaypackers/statistics?team=GB\">Statistics</option>"
team.names = sub(pattern=".*teams/(.*)/statistics.*", replacement="\\1", x=team.lines)
team.abbreviations = sub(pattern=".*team=(.*)\".*", replacement="\\1", x=team.lines)
n.teams = length(team.names)
rushing = numeric(n.teams)
receiving = numeric(n.teams)
for (i in 1:n.teams) {
  # assemble a link like
  # http://www.nfl.com/teams/greenbaypackers/statistics?team=GB
  link = paste0(TEAMS, "/", team.names[i], "/statistics?team=", team.abbreviations[i])
  print(link)
  tables = readHTMLTable(link)
  rushing[i] = as.numeric(as.character(tables[[3]][2, 3]))
  receiving[i] = as.numeric(as.character(tables[[4]][2, 3]))
}

plot(x=rushing, y=receiving, xlim=c(0, max(rushing)), ylim=c(0, max(receiving)))
m = lm(receiving ~ rushing)
abline(m)
print(summary(m))
