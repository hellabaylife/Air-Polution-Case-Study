library(dplyr)

#load data files
classification <- readRDS("./data/Source_Classification_Code.rds")
PMdata <- readRDS("./data/summarySCC_PM25.rds")
head(PMdata)
head(classification)

#join relevent data together
joineddf <- left_join(PMdata,classification,by = "SCC")
colnames(joineddf)
head(joineddf)
df0 <-joineddf[,-c(7,16,17,18)] 

#aggregate our data by year
emissions_by_year <- aggregate(Emissions ~ year, df0, sum)

#plot emmisions by year as a line graph
plot(emissions_by_year$year, emissions_by_year$Emissions, type = "o", col = "blue", main = expression("Total US "~ PM[2.5]~ "Emissions by Year"), ylab = expression("Total US "~   PM[2.5] ~ "Emissions"), xlab = "Year")

#save plot to png file
dev.copy(png, file = "plot1.png",width = 480,height = 480)  ## Copy my plot to a PNG file
dev.off() 