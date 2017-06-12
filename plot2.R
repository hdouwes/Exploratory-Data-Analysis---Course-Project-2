#Course project 2: plot2. Part of Exploratory Data Analysis course.

#Download and unzip data
if(!file.exists("./course project 2/summarySCC_PM25.rds")){
        if(!file.exists("./course project 2/")){dir.create("./course project 2")}
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile="./course project 2/Dataset.zip")
        unzip(zipfile="./course project 2/Dataset.zip",exdir="./course project 2")
        }

#Read data
NEI <- readRDS("./course project 2/summarySCC_PM25.rds")
SCC <- readRDS("./course project 2/Source_Classification_Code.rds")

#Subest Baltimore and sum emissions by year and convert to a dataframe
baltNEI <- subset(NEI, fips == "24510")
sumbalt <- tapply(baltNEI$Emissions, baltNEI$year, sum, na.rm=TRUE)
dbalt <- data.frame(year=names(sumbalt), emissions=sumbalt, row.names = NULL)

#Plot data and save to a PNG file
png(filename="./course project 2/plot2.png")
barplot(dbalt$emissions, xlab="Year", ylab="PM2.5 emissions", main="Total PM2.5 emissions in Baltimore by year")
dev.off()