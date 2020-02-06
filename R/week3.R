# Data Import and Cleaning
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

raw_df <- read.csv(file ="../data/week3.csv", header=TRUE)
raw_df$timeStart<-as.POSIXct(raw_df$timeStart)
raw_df$timeEnd<-as.POSIXct(raw_df$timeEnd)
clean_df<-raw_df[(raw_df$timeEnd<as.POSIXct("2017-06-01 00:00:00") | raw_df$timeStart>=as.POSIXct("2017-07-01 00:00:00")) ,]
clean_df<-clean_df[grepl("[1]", clean_df$q6),]

# Analysis
clean_df$timeSpent<-difftime(clean_df$timeEnd,clean_df$timeStart, units="secs")
hist(as.numeric(clean_df$timeSpent))
frequency_tables_list <- lapply(clean_df[5:14] ,table)
lapply(frequency_tables_list[], barplot)
sum(clean_df$q1>=clean_df$q2 & clean_df$q2 != clean_df$q3)
for (list in frequency_tables_list)
  barplot(list)