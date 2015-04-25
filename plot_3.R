# Exploratory Data Analysis Course Project 2
# Coded by: Ryan Yan
#
# Of the four types of sources (point, nonpoint, onroad, nonroad), which of these four sources have seen
# decreases over the years 1999-2008 and which have seen increases? This code displays a plot that answers this.

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

#Gets years the data is recorded
years <- with(NEI, unique(year))

#Splits the data by the four types
byPoint <- subset(NEI, type == "POINT", select = c(Emissions, year)) 
byNonPoint <- subset(NEI, type == "NONPOINT", select = c(Emissions, year)) 
byOnRoad <- subset(NEI, type == "ON-ROAD", select = c(Emissions, year))
byOffRoad <- subset(NEI, type == "NON-ROAD", select = c(Emissions, year))

#Defines a function to sum by year given a data frame with two columns, Emissions, and year.
totals <- function(df) {
    sums <- vector()
    for (i in 1:length(years)) {
        yearsum <- sum(subset(df, year == years[i], select = Emissions))
        sums <- append(sums, yearsum)
    }
    sums
}

#Uses function to get sums of each type for each year
pointTotals <- totals(byPoint)
nonPointTotals <- totals(byNonPoint)
onRoadTotals <- totals(byOnRoad)
offRoadTotals <- totals(byOffRoad)

#Creates a data frame in long form split by type and years
typeTotals <- data.frame(pointTotals, nonPointTotals, onRoadTotals, offRoadTotals, years)
typeTotals <- melt(typeTotals, 'years')
colnames(typeTotals) <- c("Years", "Series", "value")

#Plots in ggplot all four type series by the same domain of years.
plot <- ggplot(typeTotals, aes(Years, value, col = Series)) + geom_line() + ylab("Emissions (tons)")
plot <- plot + ggtitle("Emissions of Four Types Over Time") + 
    geom_hline(aes(yintercept = pointTotals[1]), linetype = "dotted") +
    geom_hline(aes(yintercept = nonPointTotals[1]), linetype = "dotted") + 
    geom_hline(aes(yintercept = onRoadTotals[1]), linetype = "dotted") +
    geom_hline(aes(yintercept = offRoadTotals[1]), linetype = "dotted")
plot


dev.copy(png, file = "plot_3.png", width = 800, height = 600)
dev.off()
