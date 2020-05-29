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

#filter for only for Balitmore City
baltimore <- df0$fips == "24510"
df_baltimore <- df0[baltimore,]

#agregate emissions by year for Balitmore City
emissions_by_year <- aggregate(Emissions ~ year, df_baltimore, sum)

#plot emissions by year for Balitmore City
plot(emissions_by_year$year, emissions_by_year$Emissions, type = "o", col = "blue", main = expression("Total Baltimore "~ PM[2.5]~ "Emissions by Year"), ylab = expression("Total Baltimore "~   PM[2.5] ~ "Emissions"), xlab = "Year")

#save plot to png file
dev.copy(png, file = "plot2.png",width = 480,height = 480)  ## Copy my plot to a PNG file
dev.off() 


