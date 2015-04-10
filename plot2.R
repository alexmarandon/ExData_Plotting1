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

png(filename = "plot2.png",
    width = 480, height = 480, units = "px")
par(mfrow= c(1,1))
Sys.setlocale("LC_TIME", 'en_GB.UTF-8')
plot(dataset0$datetime, dataset0$Global_active_power, "n"
     , xlab="", ylab="Global Active Power (kilowatts)")
lines(dataset0$datetime, dataset0$Global_active_power)

dev.off()