# Using the open air package for plotting time series 
# 24 April 2018 
# WGB 

# Before we start notes: 
# This program was made to analyze air pollution so every time it says in the function `pollutant = ` it's just referring to the concentration of the parameter we are interested in 
# I have enjoyed using it to analyze time series data - specifically high-frequency meteorological and water quality data 
# there are ~40 functions within this package and I will go over using 4 plotting ones! 

# Plots we will make/exploring we will do
# summaryPlot: getting to know your dataset first
# windRose:
# timePlot: 
# calendarPlot: calendar of wind direction and intensity
# 

# Preliminaries 
library(openair)
library(dplyr)

#-----------------------------------------------------------------
# trying to get a summary plot to start, using summaryPlot 
dbBuoy <- read.csv("HF_MB_forOpenAirApril2018.csv")
# need date and time in the correct format 
dbBuoy$date <- as.POSIXct(strptime(dbBuoy$timestamp,format = "%m/%d/%Y %H:%M", tz = "Etc/GMT-4"))


# making a summary plot to see days missing data, distribution of the data, and automatically displays the mean, median, and 95th percentile on the graph
summaryPlot(select(dbBuoy, date, windSpeed, CHL_CONC, PC_RFU, wTEMP))
# can see the days where you have missing values 

# can change the time period of the stats to "months" 
summaryPlot(select(dbBuoy, date, windSpeed, CHL_CONC, PC_RFU, wTEMP), period = "months")

# and can change what values the graph displays: avg.time = "sec", "hour", "day" (default), "week", "month", "quarter", "year", or "2 month" etc. 
summaryPlot(select(dbBuoy, date, windSpeed, CHL_CONC, PC_RFU, wTEMP), period = "months", avg.time="week")

#-------------------------------------------------------------
# windRose 
# can see the proportion the wind was blowing in a certain direction for the entire dataset 
windRose(dbBuoy, ws="windSpeed", wd="windDir")

# can split it up by season and add "pollution" to see how the wind direction correlated to a parameter you're measuring
pollutionRose(dbBuoy, ws="windSpeed", wd="windDir", pollutant="PC_RFU", type="season")

#------------------------------------------------------------
# timePlot 
# different scales 
timePlot(dbBuoy,pollutant=c("wTEMP", "PC_RFU", "CHL_CONC"))
# have different scales for y axis
timePlot(dbBuoy,  pollutant=c("wTEMP","PC_RFU", "CHL_CONC"), y.relation="free")
# get a daily average 
timePlot(dbBuoy,  pollutant=c("wTEMP", "PC_RFU", "CHL_CONC"), avg.time="day", y.relation="free")
# add in names and reference line 
timePlot(dbBuoy,  pollutant=c("wTEMP", "PC_RFU", "CHL_CONC"), y.relation="free", ref.y = list(h = 8, lty = 5), name.pol = c("water temp (C)", "PC (RFU)", "Chl (ug/L)"))


#----------------------------------------------------------
# calendarPlot
dbBuoy <- rename(dbBuoy,wd = windDir,  ws = windSpeed)
# with the default colors 
calendarPlot(dbBuoy, pollutant = "PC_RFU")
# customizing the colors and adding in wind vectors 
calendarPlot(dbBuoy, pollutant = "PC_RFU", annotate = "ws", cols = c("white", "dodgerblue", "dodgerblue3", "dodgerblue4"))


# or can just look at the wind speed and direction in one plot 
calendarPlot(dbBuoy, pollutant = "ws", annotate = "wd")


             