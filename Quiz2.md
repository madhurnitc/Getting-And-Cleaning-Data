### Question 1

Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

### Solution
```R
library(httr)
oauth_endpoints("github")
myapp <- oauth_app("github", "ClientID", "ClientSecret")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)
BROWSE("https://api.github.com/users/jtleek/repos",authenticate("Access Token","x-oauth-basic","basic"))

```
### Question 2
The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called
 ``` acs ```


https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

### Solution 
```R
library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = "Ques2.csv" )
acs <- read.csv("Ques2.csv", header=T, sep=",")
sqldf("select pwgtp1 from acs where AGEP < 50")
```
### Question 3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

### Solution 
```R
sqldf("select distinct AGEP from acs")
```

### Question 4
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 

http://biostat.jhsph.edu/~jleek/contact.html 

(Hint: the nchar() function in R may be helpful)

### Solution 
```R
con <- url("http://biostat.jhsph.edu/~jleek/contact.html" )
htmlCode <- readLines(con)
close(con)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)
```
### Question 5
Read this data set into R and report the sum of the numbers in the fourth of the nine columns. 

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 

Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 

(Hint this is a fixed width file format)

### Solution 
```R
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",destfile = "Ques5.csv")
data <- read.csv("Ques5.csv", header = TRUE)
df <- read.fwf(file="Ques5.csv",widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
sum(df[, 4])
```
