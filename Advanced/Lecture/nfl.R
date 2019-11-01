rm(list=ls())

require("parallel")
require("XML")

teams.url = "http://www.nfl.com/teams"
# http://www.nfl.com/teams/statistics?team=GB
lines = readLines(teams.url)
# <option value="/teams/greenbaypackers/statistics?team=GB">Statistics</option>
team.lines = grep(pattern=".*/teams/.*/statistics\\?team=.*", x=lines, value=TRUE)
team.abbreviations = sub(pattern=".*/teams/.*/statistics\\?team=(.*)\">Stat.*", replacement="\\1", x=team.lines)

get.yards = function(team) {
  url = paste0("http://www.nfl.com/teams/statistics?team=", team)
  cat(sep="", team, "\n")
  tables = readHTMLTable(url, skip.rows=1, colClasses=c("character", rep("numeric", 5)), which=c(3,4))
  rushing = sum(tables[[1]][ ,3])
  receiving = sum(tables[[2]][ ,3])
  return(c(rushing, receiving))
}

print("Timing lapply(), one core ...")
print(system.time(l <- lapply(X=team.abbreviations, FUN=get.yards))) # no multicore
n.cores = detectCores()
if (.Platform$OS.type == "windows") {
  cluster = makePSOCKcluster(names=n.cores)
  clusterEvalQ(cl=cluster, expr=require("XML")) # Run the setup code,
  # require("XML"), on each cluster node, which, in Windows, has a
  # fresh R session; otherwise readHTMLTable() is unavailable.
  cat(sep="", "Timing parLapply(), ", n.cores, " cores ...")
  print(system.time(l <- parLapply(cl=cluster, X=team.abbreviations, fun=get.yards)))
  stopCluster(cl=cluster)
} else { # It's easier on Mac or Linux.
  cat(sep="", "Timing mclapply(), ", n.cores, " cores ...")
  print(system.time(l <- mclapply(X=team.abbreviations, FUN=get.yards, mc.cores=n.cores)))
}
# m = matrix(data=unlist(l), nrow=2, ncol=32)
# best.rushing   = m[1, ]
# best.receiving = m[2, ]
# print(best.rushing)
# print(best.receiving)

# plot(x=best.rushing, y=best.receiving)
# abline(lm(best.receiving ~ best.rushing))
# cor(best.rushing, best.receiving)
