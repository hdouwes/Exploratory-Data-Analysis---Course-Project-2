#Course project 2: plot3. Part of Exploratory Data Analysis course.

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

#Subest Baltimore and sum emissions by year and type and convert to a dataframe
baltNEI <- subset(NEI, fips == "24510")
sumbalt2 <- tapply(baltNEI$Emissions, list(baltNEI$year, baltNEI$type), sum, na.rm=TRUE)
dbalt2 <- as.data.frame(as.table(sumbalt2))
colnames(dbalt2) <- c("year", "type", "emissions")

#Plot data and save to a PNG file
png(filename="./course project 2/plot3.png")
g <- ggplot(dbalt2, aes(x=year, y=emissions, group=type, color=type))
p <- g+geom_point()+
        geom_line()+ 
        ggtitle("Total PM2.5 emissions in Baltimore by Type")+ 
        xlab("Year")+ 
        ylab("PM2.5 Emissions")
print(p)
dev.off()