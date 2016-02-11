library(lubridate)
library(dplyr)

source("R/get.basis.data.R")
source("R/clean.basis.data.R")
source("R/lubridate.cols.R")
source("R/cbind.basis.col.na.count.R")

df.raw <- get.basis.data()
df.clean <- clean.basis.data(df.raw)
df.clean <- lubridate.cols(df.clean,"datetime")
df.clean <- add.na.count.col(df.clean)

# Data frame of rows with all NA metrics
inactive <- df.clean %>% filter(is.na(skin_temp) & is.na(air_temp) & 
                                     is.na(heartrate) & is.na(steps) & 
                                     is.na(gsr) & is.na(calories) & 
                                     is.na(act_type) & is.na(sleep_type) & 
                                     is.na(toss_turn))

# Create data frame by date showing mean of # NA values given by basis.col.na.count
df.nacount.date <- df.clean %>% 
     group_by(datetime.date) %>% 
     summarise(na.count.mean = mean(basis.col.na.count),
               na.count.min = min(basis.col.na.count),
               na.count.max = max(basis.col.na.count)) %>%
     mutate(datetime.date2 = as.Date(datetime.date))

# Create data frame aggregating metrics by weekday/date/hour
df.clean.hour <- df.clean %>% 
     group_by(datetime.weekday, as.character(datetime.date), datetime.hour) %>% 
     summarise(skin_temp = mean(skin_temp), 
               air_temp = mean(air_temp), 
               heartrate = mean(heartrate), 
               steps = sum(steps), gsr = mean (gsr), 
               calories = sum(calories))

df.all.dates <- data.frame(
     all.dates = seq.Date(
          min(as.Date(df.nacount.date$datetime.date)), 
          max(as.Date(df.nacount.date$datetime.date)), 1))

df.clean.date.alldates <- left_join(df.all.dates, df.nacount.date, 
                                    by=c("all.dates" = "datetime.date2"))

# Write processed data to rds files in "data/processed" folder
write_rds(df.clean, "data/processed/df.clean.rds")
write_rds(inactive, "data/processed/inactive.rds")
write_rds(df.nacount.date, "data/processed/df.nacount.date.rds")
write_rds(df.clean.hour, "data/processed/df.clean.hour.rds")
write_rds(df.all.dates, "data/processed/df.all.dates.rds")
write_rds(df.clean.date.alldates, "data/processed/df.clean.date.alldates.rds")