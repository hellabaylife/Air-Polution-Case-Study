library(dplyr)
library(ggplot2)

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

#filter data for only balitmore city
baltimore <- df0$fips == "24510"
df_baltimore <- df0[baltimore,]

#filter data that is of combustion type "ON-ROAD"
onroad_output <- df_baltimore$type == "ON-ROAD"
motor_vehicle <- df_baltimore[onroad_output,]

#aggregate emissions by year for data that consists of type "ON-ROAD" and is in Balitmore City
emissions_by_year_onroad <- aggregate(Emissions ~ year, motor_vehicle, sum)

#plot emissions by year for data that consists of type "ON-ROAD" and is in Balitmore City
plot(emissions_by_year_onroad$year, emissions_by_year_onroad$Emissions, type = "o", col = "blue", main = expression("Total Motor Vehicle Related "~ PM[2.5]~ "Emissions by Year for Baltimore"), ylab = expression("Total Motor Related "~   PM[2.5] ~ "Emissions"), xlab = "Year")

#save plot as png file.
dev.copy(png, file = "plot5.png",width = 480,height = 480)  ## Copy my plot to a PNG file
dev.off() 

