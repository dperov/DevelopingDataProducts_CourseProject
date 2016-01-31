# loading datasets
data_tool <- read.table("forkdata.table")
data_tool$course <- "tools"
data_ex <- read.table("forkdata_ex.table")
data_ex$course <- "ex"
data_repl <- read.table("forkdata_repl.table")
data_repl$course <- "repl"
data_rprogr <- read.table("forkdata_rprogr.table")
data_rprogr$course <- "rprogr"

data <- data_tool
data <- rbind(data, data_ex)
data <- rbind(data, data_repl)
data <- rbind(data, data_rprogr)

data$date = as.POSIXct(as.character(data$created_at), format = "%Y-%m-%dT%H:%M:%SZ")
data$count <- 1

aggregate_by_month <- function(date) {
  date_ct <- as.POSIXlt(date)
  sprintf(date_ct$year + 1900, date_ct$mon + 1, 1, fmt = "%d-%02d-%02d")
}
  
data_agg <- aggregate(x = data$count, by = list(month = aggregate_by_month(data$date), course = data$course), FUN = sum)


#library(ggplot2)
#library(scales)
#ggplot(data_agg, aes(x= as.Date(month), y= x, colour = course)) + geom_line()  + xlab("Date") + ylab("Number of students")
  
write.table(data_agg, file = "couses_data.table")
