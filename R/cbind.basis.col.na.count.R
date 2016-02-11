add.na.count.col <- function(df){
     if(!is.data.frame(df)){
          stop("df must be class data frame")
     } else {
          cbind(df, basis.col.na.count = apply(df[,2:10],1,function(x) sum(is.na(x))))
     }
}