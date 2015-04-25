# Exploratory Data Analysis Course Project 2
# Coded by: Ryan Yan
#
# Plots the total emissions of Motor Vehicles in Baltimore City, Maryland vs. those in Los Angeles, CA
# over the years of 1999-2008 to answer the question of which have changed more over time.

library(ggplot2)
library(reshape2)
library(plyr)

path <- "C:/Users/ryan/Desktop/datasciencecoursera/exdata_data_NEI_data"
setwd(path)

if(!exists("NEI") | !exists("SCC")) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

#Finds rows in SCC with "Vehicle", then subsets the original NEI set by the corresponding SCC code
#Then subsets only baltimore city rows.
hasVehicle <- grep("Vehicle", as.character(SCC$SCC.Level.Two))
byVehicle <- SCC[hasVehicle, ]
hasSCCVehicle <- subset(NEI, as.character(SCC) %in% as.character(byVehicle$SCC))

#Takes a data frame and a city code and returns a vector sums for the years.
sumsCity <- function(df, cityCode) {
    InCity <- subset(df, fips == cityCode)
    year1total <- sum(subset(InCity, year == 1999, select = 'Emissions'))
    year2total <- sum(subset(InCity, year == 2002, select = 'Emissions'))
    year3total <- sum(subset(InCity, year == 2005, select = 'Emissions'))
    year4total <- sum(subset(InCity, year == 2008, select = 'Emissions'))
    
    totals <- c(year1total, year2total, year3total, year4total)
    totals
}

#Convert to percents in order for easy comparison
vehicleInBaltimoreCity <- sumsCity(hasSCCVehicle, cityCode = "24510")
percentBaltimoreCity <- ( vehicleInBaltimoreCity / vehicleInBaltimoreCity[1] ) * 100

vehicleInLA <- sumsCity(hasSCCVehicle, cityCode = "06037")
percentLA <- ( vehicleInLA / vehicleInLA[1] ) * 100

years <- with(vehicleInCity, unique(year))
data <- data.frame(percentBaltimoreCity, percentLA, years)
data <- melt(data, 'years')
colnames(data) <- c("Years", "Series", "value")

plot <- ggplot(data, aes(Years, value, col = Series))
plot <- plot + ggtitle("Change in Vehicle Emissions over Time in Baltimore City, MD vs. LA County, CA")
plot <- plot + ylab("Emissions (tons)") + geom_line() + 
    geom_hline(aes(yintercept = 100), linetype = "dotted") +
    geom_segment(aes(xend = ))
plot

dev.copy(png, file = "plot_6.png", height = 500, width = 800)
dev.off()
