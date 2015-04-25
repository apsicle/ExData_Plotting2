# Exploratory Data Analysis Course Project 2
# Coded by: Ryan Yan
#
# Plots the total emissions of Motor Vehicles in Baltimore City, Maryland 
# over the years of 1999-2008 to answer the question of whether or not they have diminished over time.

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
vehicleInCity <- subset(hasSCCVehicle, fips == "24510")

#Sums by year
year1total <- sum(subset(vehicleInCity, year == 1999, select = 'Emissions'))
year2total <- sum(subset(vehicleInCity, year == 2002, select = 'Emissions'))
year3total <- sum(subset(vehicleInCity, year == 2005, select = 'Emissions'))
year4total <- sum(subset(vehicleInCity, year == 2008, select = 'Emissions'))
years <- with(vehicleInCity, unique(year))

totals <- c(year1total, year2total, year3total, year4total)

plot(years, totals, main = "Vehicle Emissions in the Baltimore City, MD From 1999-2008",
     xlab = "Years", ylab = "Emissions (tons)", type = 'l')

dev.copy(png, file = "plot_5.png", height = 500, width = 600)
dev.off()
