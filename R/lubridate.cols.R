# lubridate.cols.R
# Takes arguments: data frame, column name as POSIXct
# Returns: data frame with extra columns with lubridate functions applied

lubridate.cols <- function(df,datetime.col.name){
     require(lubridate)
     if(!is.data.frame(df) | !is.character(datetime.col.name)){
          stop("df must be data frame, & datetime.col.name, date.col.format must be character")
     }
     if(is.na(match(datetime.col.name, names(df)))){
          stop("data frame df must contain column datetime.col.name")
     }
     
     twochar <- function(x){
          if(nchar(x) == 1){
               paste("0",x,sep="")
          } else {
               x
          }
     }
     
     date.col.pos <- match(datetime.col.name, names(df))
     new.date.col <- df[,date.col.pos]
     date <- round(new.date.col,"days")
     week <- week(new.date.col)
     weekday <- wday(new.date.col)
     month <- month(new.date.col)
     day.of.month <- mday(new.date.col)
     quarter <- quarter(new.date.col)
     year <- year(new.date.col)
     day.of.year <- yday(new.date.col)
     year.week <- paste(year, sapply(week, twochar), sep="-w")
     year.month <- paste(year, sapply(month, twochar), sep="-m")
     year.quarter <- paste(year, sapply(quarter, twochar), sep="-q")
     hour <- hour(new.date.col)
     minute <- minute(new.date.col)
     
     df.extracols <- data.frame(date = date, week = week, weekday = weekday, month = month,
                                day.of.month = day.of.month, quarter = quarter, year = year,
                                day.of.year = day.of.year, year.week = year.week,
                                year.month = year.month, year.quarter = year.quarter,
                                hour = hour, minute = minute)
     
     names(df.extracols) <- paste(datetime.col.name, names(df.extracols), sep=".")
     cbind(df, df.extracols)
}