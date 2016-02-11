# Before running this function, download Basis data using
# http://www.richk.net/wiki/BasisRetriever/BasisRetriever
# and save to subdirectory "data/base"

get.basis.data <- function(){
     require(readr)
     metrics.files <- paste("data/base/",
                            list.files("data/base")[grep("metrics",list.files("data/base"))],
                            sep="")
     
     for (i in 1:length(metrics.files)){
          if (i == 1){
               df <- read_csv(metrics.files[1])
          } else {
               df <- rbind(df, read_csv(metrics.files[i]))
          }
     }
     df
}