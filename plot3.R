# create a temporary file on the local disk
tf <- tempfile()
# download data to the temporary file
download.file( "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" , tf , mode = 'wb' )

# unzip the contents 
data <- unzip( tf , exdir = tempdir() )

NEI <- readRDS(file = "summarySCC_PM25.rds")
SCC <- readRDS(file = "Source_Classification_Code.rds")

NEIBaltimore <- subset(NEI , fips=="24510")

library(ggplot2)
png(filename='plot3.png')
ggplot(NEIBaltimore,aes(factor(year),Emissions)) +
  geom_bar(stat="identity") +
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()




