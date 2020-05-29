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

#subset data to only contain data from balitmore city and los angeles, and must be of type "ON-ROAD"
baltLAMotors <- subset(df0, df0$fips %in% c("24510","06037") & df0$type == "ON-ROAD")
baltLAMotorsAggregate <- aggregate(Emissions ~ year + fips, baltLAMotors, sum)

#plot the comparison of emission output by year for both cities.
ggplot(baltLAMotorsAggregate, aes(year,Emissions,color = fips))+
  geom_line()+
  geom_point()+
  ggtitle(expression("Total Motor Related "~ PM[2.5]~ "Emissions by Year by City"))+
  labs(y="Total Motor Related "~   PM[2.5] ~ "Emissions", x = "Years")+
  scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore")) 

#save plot as png
dev.copy(png, file = "plot6.png",width = 480,height = 480)  ## Copy my plot to a PNG file
dev.off() 

