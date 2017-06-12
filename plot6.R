#Course project 2: plot6. Part of Exploratory Data Analysis course.

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

#Subset motor vehicle-related sources in Baltimore and LA and sum emissions by year and location and convert to a dataframe
vehNEI <- subset(NEI, type=="ON-ROAD")
baltlavehNEI <- subset(vehNEI, fips == "24510" | fips == "06037")
sumbaltlaveh <- tapply(baltlavehNEI$Emissions, list(baltlavehNEI$year, baltlavehNEI$fips), sum, na.rm=TRUE)
dsumbaltlaveh <- as.data.frame(as.table(sumbaltlaveh))
colnames(dsumbaltlaveh) <- c("year", "fips", "emissions")

#Plot data and save to a PNG file
png(filename="./course project 2/plot6.png")
g <- ggplot(dsumbaltlaveh, aes(x=year, y=emissions, group=fips, color=fips))
p <- g+geom_point()+
        geom_line()+ 
        ggtitle("Total PM2.5 emissions from motor vehicles in Baltimore (24510) \nvs Los Angelos (06037)")+ 
        xlab("Year")+ 
        ylab("PM2.5 Emissions")
print(p)
dev.off()