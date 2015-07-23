### Question 1

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 

and load the data into R. The code book, describing the variable names is here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?

### Solution
```R
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","./data/Ques1.csv")
Ques1_Data <- read.csv("./data/Ques1.csv")
agricultureLogical <- Ques1_Data$ACR ==3 & Ques1_Data$AGS ==6
which(agricultureLogical)[1:3]

```
### Question 2
Using the jpeg package read in the following picture of your instructor into R 

https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

### Solution 
```R
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg ","./data/Ques2.jpg",mode = "wb")
array<-readJPEG("./data/Ques2.jpg",native = TRUE)
quantile(array,probs = c(0.3,0.8))
```
### Question 3
Load the Gross Domestic Product data for the 190 ranked countries in this data set: 

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

Load the educational data from this data set: 

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame? 

Original data sources: 
http://data.worldbank.org/data-catalog/GDP-ranking-table 
http://data.worldbank.org/data-catalog/ed-stats

### Solution 
```R
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","./data/Ques3_data1.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv ","./data/Ques3_data2.csv")
data1 <- read.csv("./data/Ques3_data1.csv", header = FALSE, na.strings = "", skip = 5,                   blank.lines.skip = TRUE, nrows = 190,
                colClasses = c("character", "integer", "NULL", "character", "character", rep("NULL", 5)))
data2 <- read.csv("./data/Ques3_data2.csv", na.strings = "", blank.lines.skip = TRUE)
data1<-data1[,c(colnames(data1)[1],colnames(data1)[2],colnames(data1)[4],colnames(data1)[5])]
colnames(data1)[1]<-"CountryCode"
colnames(data1)[2]<-"GDP"
merge_data<-merge(data1,data2,by = "CountryCode",all = TRUE)
number_of_matches <- nrow(data1)+nrow(data2)-nrow(merge_data)
print(sprintf("Total ID matched :  %d" ,number_of_matches))
merge_data<-merge_data[order(merge_data$GDP,decreasing = TRUE),]
print(sprintf("Name of the 13th  Country : %s ",merge_data[13,"Long.Name"]))
```

### Question 4
What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

### Solution 
```R
mean1<- mean(merge_data[merge_data$Income.Group=="High income: OECD","GDP"],na.rm = TRUE)
mean2<- mean(merge_data[merge_data$Income.Group=="High income: nonOECD","GDP"],na.rm = TRUE)
print(sprintf("Mean(High income: OECD) : %s",mean1))
print(sprintf("Mean(High income: nonOECD) : %s ",mean2))

```
### Question 5
Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

### Solution 
```R
merge_data$GDP.Rank.Group <- cut2(merge_data$GDP, g = 5)
total_countries <- sum(as.numeric(merge_data$GDP.Rank.Group) == 1 & merge_data$Income.Group == "Lower middle income", na.rm = TRUE)
print(sprintf("Q5. %s is the number of countries in the Lower middle income group With one of the 38 highest GDP", total_countries))

```