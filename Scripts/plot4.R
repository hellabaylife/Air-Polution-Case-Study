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

#search for level three combustion material that contains "Coal"
coal_output <- grep("Coal",df0$SCC.Level.Three)
coal_combustion <- df0[coal_output,] #subset our joined dataframe by rows that contain "Coal"

#aggregate emissions by year and by type of combustion output.
emissions_by_year <- aggregate(Emissions ~ year+type, coal_combustion, sum)

#plot emissions by year by type of combustion output.
ggplot(emissions_by_year,aes(year,Emissions))+ 
  geom_line(aes(color = type)) +
  labs(main ="Total Coal Related "~ PM[2.5]~ "Emissions by Year", y="Total Coal Related "~   PM[2.5] ~ "Emissions", x = "Years" )

#save plot to png file
dev.copy(png, file = "plot4.png",width = 480,height = 480)  ## Copy my plot to a PNG file
dev.off() 



