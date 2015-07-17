# Ques 1
library(httr)
oauth_endpoints("github")
myapp <- oauth_app("github", "ClientID", "ClientSecret")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)
BROWSE("https://api.github.com/users/jtleek/repos",authenticate("Access Token","x-oauth-basic","basic"))



#Ques 2

library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = "Ques2.csv" )
acs <- read.csv("Ques2.csv", header=T, sep=",")
sqldf("select pwgtp1 from acs where AGEP < 50")


#Ques 3
sqldf("select distinct AGEP from acs")

#Ques 4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html" )
htmlCode <- readLines(con)
close(con)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)

# Ques 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",destfile = "Ques5.csv")
data <- read.csv("Ques5.csv", header = TRUE)
df <- read.fwf(file="Ques5.csv",widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)sum(df[, 4])
sum(df[, 4])


