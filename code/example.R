runoff <- 130 #m3/s 

runoff_ts <- data.frame(time = as.Date(1:90, origin = '2020/12/31'), 
                        value = sample(c(130, 135, 140), 
                                       size = 90, replace = T))
head(runoff_ts, 10)
str(runoff_ts)

#data.table
install.packages("data.table")
library(data.table)

runoff_dt <- data.table(runoff_ts)
runoff_dt <- setDT(runoff_ts)
summary(runoff_dt)

runoff_dt[value > 130]

runoff_dt[value > 130, mean(value)]

runoff_dt[value > 130, mean(value), by = month(time)]


#new column
runoff_dt[, week := week(time)]

mon_mean <- runoff_dt[, mean(value), by = mon]


runoff_month <- runoff_dt[, .(mon, mon_mean)] 
runoff_month
unique(runoff_month)

saveRDS(runoff_dt, file = './data/dt_example.rds')