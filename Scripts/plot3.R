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

#filter data for balitmore city
baltimore <- df0$fips == "24510"
df_baltimore <- df0[baltimore,]

#aggregate dat by year and by type of combustion
emissions_by_year_by_type <- aggregate(Emissions ~ year+type, df_baltimore, sum)

#plot emissions data by year by type of combustion for baltimore city.
ggplot(emissions_by_year_by_type, aes(year,Emissions)) +
  geom_line(aes(color = type),size = 2) +
  labs(title = ~PM[2.5]~ "Emissions for Baltimore by Year by Source Type", x = "Year", y = "Total Baltimore "~ PM[2.5] ~ "Emissions")

#save plot to png file
dev.copy(png, file = "plot3.png",width = 480,height = 480)  ## Copy my plot to a PNG file
dev.off() 
