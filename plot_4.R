# Exploratory Data Analysis Course Project 2
# Coded by: Ryan Yan
#
# Plots the total emissions for Coal-based sources from 1999-2008 to answer the question of 
# which direction they have shifted over these years.

library(ggplot2)
library(reshape2)
library(plyr)

path <- "C:/Users/ryan/Desktop/datasciencecoursera/exdata_data_NEI_data"
setwd(path)

#Reads in data if it does not already exist
if(!exists("NEI") | !exists("SCC")) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

#Finds the rows in SCC that have anything to do with "Coal", and records the SCC code associated.
#Then checks which rows in the NEI data set are related to "Coal" and takes that subset
hasCoal <- grep("Coal", as.character(SCC$Short.Name))
byCoal <- SCC[hasCoal, ]
hasSCCCoal <- subset(NEI, as.character(SCC) %in% as.character(byCoal$SCC))

#Calculates the sum of Emissions per year
year1total <- sum(subset(hasSCCCoal, year == 1999, select = 'Emissions'))
year2total <- sum(subset(hasSCCCoal, year == 2002, select = 'Emissions'))
year3total <- sum(subset(hasSCCCoal, year == 2005, select = 'Emissions'))
year4total <- sum(subset(hasSCCCoal, year == 2008, select = 'Emissions'))
years <- with(hasSCCCoal, unique(year))

totals <- c(year1total, year2total, year3total, year4total)

plot(years, totals, main = "Coal Emissions in the United States From 1999-2008",
     xlab = "Years", ylab = "Emissions (tons)", type = 'l')

dev.copy(png, file = "plot_4.png", height = 500, width = 600)
dev.off()
