library("dplyr")
dataset <- tbl_df(read.table("household_power_consumption.txt", 
                             sep =";", header = TRUE, na.strings = "?", 
                             #nrows=1000, 
                             colClass = c("character", "character", "numeric", 
                                          "numeric", "numeric", "numeric", "numeric", 
                                          "numeric", "numeric" )))

dataset0 <- dataset %>% 
        mutate(datetime = as.POSIXct(paste(Date, Time), tz="UTC", format="%d/%m/%Y %H:%M:%S")) %>%
        select(10,3:9) %>%
        filter(datetime>=as.POSIXct("2007-02-01 00:00:00", tz = "UTC")) %>%
        filter(datetime<as.POSIXct("2007-02-03 00:00:00", tz = "UTC")) %>%
        arrange(datetime)

remove(dataset)

png(filename = "plot3.png",
    width = 480, height = 480, units = "px")
par(mfcol= c(2,2), ps=12, mar = c(4,4,4,2))

par(mfrow= c(1,1))
Sys.setlocale("LC_TIME", 'en_GB.UTF-8')
plot(dataset0$datetime, dataset0$Sub_metering_1, "n"
     , xlab="", ylab="Energy sub metering")
lines(dataset0$datetime, dataset0$Sub_metering_1, col = "black")
lines(dataset0$datetime, dataset0$Sub_metering_2, col = "red")
lines(dataset0$datetime, dataset0$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, col=c("black", "red", "blue"))


dev.off()