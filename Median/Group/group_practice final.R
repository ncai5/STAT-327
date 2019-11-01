# © Copyright by Yongsu Lee 2018, All Rights Reserved

# Guideline of Group Practice in Section 002

rm(list=ls())
install.packages("XML")
require(XML)
setwd("~/Desktop/STAT327(2)")

#################################
## Questions You need to Answer
#################################

# 1. Find the average score of metascores and userscores.
# 2. Which game has the largest difference between metascore and user score?
# 3. What are the top 4 frequent Genres in the games?
# 4. Based on Q3, check out the difference between metascore and user score
# ... (You might use graphs, table, whatever you want.)


##############################
## How to view the source
##############################

# Chrome: Right click mouse - View page source (Ctrl+U)
# Safari: In menu bar, select Safari - Preferences and go to Advanced tab. Check 'Show Develop menu in menu bar' and close the window. Go to menu bar and select Develop - Show Page Source (Option+Cmd+U)
# Internet Explorer / Microsoft Edge: press Ctrl+U
# Firefox: Right click mouse - View Page Source


##############################
## Step 1> Be Ready
##############################

# 1. Go to the website:
# http://www.metacritic.com/browse/games/score/metascore/all/pc?sort=desc 

# 2. Note that there are 41 pages in total

# 3. Check that each game has its own (average) meta-score and user-score

# 4. Click one of the games, and check there is 'Genre(s)' part.

# Note that each main page has 100 games except last page.

####################################################
## Step 2> Scraping: Ganme Name, Game-Links and Scores
####################################################

############
# Step 2-1 : How to scrape all links of games on each main-page?
############

# Check out web page address of each main-page and game-page.
# Make a plan how to extract game-page link from main-page.

# Try to make a loop considering only first two main-pages here.

game_links_total = c();
page_link=NULL
lines=NULL
for (i in 1:2){

page_link[i] = paste(sep="","https://www.metacritic.com/browse/games/score/metascore/allpc?sort=desc&page=",i-1)
lines = c(lines,readLines(page_link[i]))

write(lines,"lines.txt")

  
  # !! Do not see lines in the r console. It will makes your system slower!
  # If you want to check out the lines, use
  # > write(lines,"lines.txt") # and open lines.txt file in your working folder
  
    
  including_links = grep(pattern = "href",x=lines,value=T)
  
  # ... using pattern/regular expression
    
  game_links = grep(pattern = "                       <a href=\"/game/.*/.*\">$",x=including_links,value=T)
  
  # stack all the game links with previous one  
  game_links_total = c(game_links_total, game_links)
}
game_links_total
############
# Step 2-2 : How to scrape meta-scores and user-scores on each main-page?
############

# Suppose you have main-page sources already. 
# Download pages.zip from Convans and unzip in your working folder
# See one of files and think how to extract meta-scores and user-scores.
# Note that those are numbers!!! But some score are not available (ex.tbd)
# Note that in each main-page there are 5 additional scores we should exclude

game_names_total = c();
metas = c(); 
users = c();

for (i in 1:41){ # try 1:1 first and then change to 1:41
  
  # read page sources as if we read from the online pages
  lines = scan(paste0("./pages/page",i,".txt"),sep="\n", what=character(),quiet=T)
  # !! Do not see lines in the r console. It will makes your system slower!
  # If you want to check out the lines, use
  # > write(lines,"lines.txt") # and open lines.txt file in your working folder
  
  including_names = # using pattern/regular expression
    
  # ... using pattern/regular expression
    
  names = # all game names from cuurent page i
    
  game_names_total = c(game_names_total, game_names)
  
  
  including_meta = #.... using pattern/regular expression
    
  # ... using pattern/regular expression
    
  meta = # ... all the meta scores from current page "i"
    
  metas = c(metas, meta) # combine meta scores with ones from previous page
  
  
  including_user = #.... using pattern/regular expression
    
    # ... using pattern/regular expression
    
  user = # ... all the meta scores from current page "i"
    
  metas = c(users, user) # combine meta scores with ones from previous page
  
}

save.image("name_scores.Rdata") # upload to your team page

####################################################
## Step 3> Scraping: Genres
####################################################

# Step 3: How to scrape Genre(s) from each game-page?

# Suppose you have all the main-page sources already. 
# Download each.zip from Convans and unzip in your working folder
# See one of files and make a plan how to extract Genres


range0 = 1:4017;

# there are two unavailabe game-page. Exclude those.
# keep in mind that and let other team member know this.
range = range[-c(2963,3855)]

genres = list()

for (i in range){ # first time, try i in 1:1 
  
  lines = scan(paste0("./each/lines",i,".txt"),sep="\n", what=character(), quiet=T)
  
  #
  # pattern/regular expression
  #
  
  genres[[i]] = # save Genres of each game only.
    
    # > genres[[1]]
    # [1] "Action"       "Shooter"      "First-Person" "Sci-Fi"
    # [5] "Arcade"
}

save.image("genres.Rdata") # upload to your team page

####################################################
## Step 4 > Answer the Questions
####################################################

# 0. Associate Team Leader, send your team codes to me no later than 11/6(T) 11:59pm.
# 1. Find the average score of metascores and userscores.
# 2. Which game has the largest difference between metascore and user score?
# 3. What are the top 4 frequent Genres in the games?
# 4. Based on Q3, check out the difference between metascore and user score
# ... (You might use graphs, table, whatever you want.)

# Downlaod from your team page
load("name_scores.Rdata")
load("genres.Rdata")

# write codes ..
#
#
#

save.image("Final.Rdata")

