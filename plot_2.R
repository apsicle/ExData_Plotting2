# Exploratory Data Analysis Course Project 2
# Coded by: Ryan Yan
#
# Plot for total emissions in Baltimore City, Maryland, over time

library(ggplot2)
library(reshape2)
library(dplyr)

path <- "C:/Users/ryan/Desktop/datasciencecoursera/exdata_data_NEI_data"
setwd(path)

if(!exists("NEI") | !exists("SCC")) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

#Subsets the data to show only Baltimore City, MD data
bycity_year1 <- subset(NEI, fips == "24510" & year == 1999, select = Emissions)
bycity_year2 <- subset(NEI, fips == "24510" & year == 2002, select = Emissions)
bycity_year3 <- subset(NEI, fips == "24510" & year == 2005, select = Emissions)
bycity_year4 <- subset(NEI, fips == "24510" & year == 2008, select = Emissions)

#Finds the yearly totals
year1total <- with(bycity_year1, sum(Emissions)) 
year2total <- with(bycity_year2, sum(Emissions))
year3total <- with(bycity_year3, sum(Emissions))
year4total <- with(bycity_year4, sum(Emissions))
totals <- c(year1total, year2total, year3total, year4total)

plot(years, totals, type = 'l', xlab = "Years", ylab = "Total Emissions (tons)", 
     main = "Total PM2.5 Emissions over Time in Baltimore City, Maryland ")

dev.copy(png, file = "plot_2.png", width = 800, height = 600)
dev.off()
