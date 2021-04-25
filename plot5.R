library(data.table)
library(ggplot2)
# create a temporary file on the local disk
tf <- tempfile()
# download data to the temporary file
download.file( "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" , tf , mode = 'wb' )

# unzip the contents 
data <- unzip( tf , exdir = tempdir() )

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))


# Gather the subset of the NEI data which corresponds to vehicles
condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip

NEIBaltimoreVehicle <- subset(NEI , fips=="24510")

png("plot5.png")

ggplot(NEIBaltimoreVehicle,aes(factor(year),Emissions)) +
  geom_bar(stat="identity" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()
