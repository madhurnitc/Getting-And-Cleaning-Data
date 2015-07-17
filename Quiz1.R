# Ques 1 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="Ques1.csv")
data <- read.table("Ques1.csv", sep=",", header=TRUE)
sum(!is.na(data$VAL[data$VAL==24]))

#Ques 2

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="Ques2.csv")
data <- read.table("Ques2.csv", sep=",", header=TRUE)
data$FES

# Ques 3
library(xlsx)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile="Ques3.xlsx",mode="wb")
data <- read.xlsx("Ques3.xlsx", sheetIndex=1, header=TRUE, colIndex=7:15, rowIndex=18:23)
sum(data$Zip*data$Ext,na.rm=T)

#Ques 4
data <-  XML::xmlTreeParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", useInternal=TRUE)
rootNode <- XML::xmlRoot(data)
sum(XML::xpathSApply(rootNode, "//zipcode", XML::xmlValue)==21231)




