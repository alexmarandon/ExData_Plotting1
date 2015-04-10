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

png(filename = "plot4.png",
    width = 480, height = 480, units = "px")
par(mfcol= c(2,2), ps=12, mar = c(4,4,4,2))
Sys.setlocale("LC_TIME", 'en_GB.UTF-8')
#Top Left Plot
plot(dataset0$datetime, dataset0$Global_active_power, "n"
     , xlab="", ylab="Global Active Power")
lines(dataset0$datetime, dataset0$Global_active_power, col = "black")
#Bottom Left Plot
plot(dataset0$datetime, dataset0$Sub_metering_1, "n"
     , xlab="", ylab="Energy sub metering")
lines(dataset0$datetime, dataset0$Sub_metering_1, col = "black")
lines(dataset0$datetime, dataset0$Sub_metering_2, col = "red")
lines(dataset0$datetime, dataset0$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, col=c("black", "red", "blue"), 
       box.lty=0, box.lwd=0, y.intersp=0.7)
#Top Right Plot
plot(dataset0$datetime, dataset0$Voltage, "n"
     , xlab="datetime", ylab="Voltage")
lines(dataset0$datetime, dataset0$Voltage, col = "black")
#Bottom Right Plot
plot(dataset0$datetime, dataset0$Global_reactive_power, "n"
     , xlab="datetime", ylab="Global_reactive_power")
lines(dataset0$datetime, dataset0$Global_reactive_power, col = "black", lty=1, lwd=1)
dev.off()