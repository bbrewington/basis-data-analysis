# Takes data frame output from get.basis.data function, and converts
# all of its component vectors to appropriate numeric format

clean.basis.data <- function(df){
     require(lubridate)
     if(!is.data.frame(df)){
          stop("df must be a data frame")
     }

     # Convert sleep columns to factor
     cbind(
          #column set 1: datetime as POSIXct
          data.frame(datetime = ymd_hms(as.character(df$datetime))),
          #column set 2: metric columns (skin_temp, air_temp, heartrate, steps, gsr, calories)
          select(df,2:7) %>% mutate_each(funs(as.numeric)),
          #column set 3: convert to factor - act_type, sleep_type, and toss_turn
          select(df,8:10) %>% mutate_each(funs(factor))
          )
}