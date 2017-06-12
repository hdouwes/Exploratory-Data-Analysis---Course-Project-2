#Course project 2: plot4. Part of Exploratory Data Analysis course.

#Install and load required package
if (!require("ggplot2")){
        install.packages("ggplot2", dependencies = TRUE)
        library(ggplot2)
        }
        
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

#Subset coal combustion-related sources and sum emissions by year and convert to a dataframe
coalSCC <- SCC[grep("Coal", SCC$EI.Sector),]
coalNEI <- NEI[NEI$SCC %in% coalSCC$SCC,]

sumcoal <- tapply(coalNEI$Emissions, coalNEI$year, sum, na.rm=TRUE)
dcoal <- data.frame(year=names(sumcoal), emissions=sumcoal, row.names = NULL)

#Plot data and save to a PNG file
png(filename="./course project 2/plot4.png")
barplot(dcoal$emissions, xlab="Year", ylab="PM2.5 emissions", main="Total coal combustion-related PM2.5 emissions by year")
dev.off()