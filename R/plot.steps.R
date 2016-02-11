plot.steps <- function(df.clean){
     require(dplyr)
     require(qcc)
     stepcount <- df.clean %>% filter(!is.na(steps) & !is.na(datetime.date)) %>%
          group_by(datetime.date) %>% 
          summarise(steps.total = sum(steps))
     
     setwd("./output/figs")
     
     png(filename = "steps_bydate.png", width=795, height=424)
     q <- qcc(stepcount$steps.total, type="xbar.one", 
              labels = stepcount$datetime.date, data.name = "Daily Step Count (Basis watch)",
              xlab = "Date", ylab = "Steps")
     print(q)
     dev.off()
     
     png(filename = "steps_hist_by_date.png")
     p <- ggplot(stepcount, aes(steps.total))+geom_histogram() + 
          ggtitle("Histogram of steps, by day\nData: remove NA's in steps & date") +
          
     
     print(p)
     dev.off()
     
     setwd("../..")
}