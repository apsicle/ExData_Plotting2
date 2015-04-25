# Exploratory Data Analysis Course Project 2
# Coded by: Ryan Yan
#
# Plot for total emissions over time

library(ggplot2)
library(reshape2)
library(dplyr)

path <- "C:/Users/ryan/Desktop/datasciencecoursera/exdata_data_NEI_data"
setwd(path)

if(!exists("NEI") | !exists("SCC")) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

#Splits the data into a list with each element containing a data frame for each year of data
byyear <- split(NEI, NEI$year)
years <- with(NEI, unique(year))

#Finds the sums per year
year1total <- with(byyear$'1999', sum(Emissions))
year2total <- with(byyear$'2002', sum(Emissions))
year3total <- with(byyear$'2005', sum(Emissions))
year4total <- with(byyear$'2008', sum(Emissions))
totals <- c(year1total, year2total, year3total, year4total)

plot(years, totals, type = 'l', xlab = "Years", ylab = "Total Emissions (tons)", 
     main = "United States Total PM2.5 Emissions over Time")

dev.copy(png, file = "plot_1.png")
dev.off()
