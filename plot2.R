# create a temporary file on the local disk
tf <- tempfile()
# download data to the temporary file
download.file( "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" , tf , mode = 'wb' )

# unzip the contents 
data <- unzip( tf , exdir = tempdir() )

NEI <- readRDS(file = "summarySCC_PM25.rds")
SCC <- readRDS(file = "Source_Classification_Code.rds")

NEIBaltimore <- subset(NEI , fips=="24510")
TotalNEI<-with( NEIBaltimore, tapply(Emissions , year , FUN = sum ))

png(filename='plot2.png')
barplot(TotalNEI
        , names = names(TotalNEI)
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years in Baltimore City")
dev.off()







