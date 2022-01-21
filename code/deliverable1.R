library(tidyverse)

data <- read_csv("data/processed/runexp.csv") %>% 
  select(half,batter_id,result,run_exp,count)

count_00 <- c("00","01","02","10","20","30","11","12","21","31","22","32")
count_01 <- c("01","11","21","31","02","12","22","32")
count_02 <- c("02","12","22","32")
count_10 <- c("10","20","30","11","21","31","12","22","32")
count_20 <- c("20","30","21","22","31","32")
count_30 <- c("30","31","32")
count_11 <- c("11","21","31","12","22","32")
count_12 <- c("12","22","32")
count_21 <- c("21","22","31","32")
count_22 <- c("22","32")
count_31 <- c("31","32")
count_32 <- c("32")

run_exp_00 <- mean(data$run_exp[data$count %in% count_00])
run_exp_01 <- mean(data$run_exp[data$count %in% count_01])
run_exp_02 <- mean(data$run_exp[data$count %in% count_02])
run_exp_10 <- mean(data$run_exp[data$count %in% count_10])
run_exp_20 <- mean(data$run_exp[data$count %in% count_20])
run_exp_30 <- mean(data$run_exp[data$count %in% count_30])
run_exp_11 <- mean(data$run_exp[data$count %in% count_11])
run_exp_21 <- mean(data$run_exp[data$count %in% count_21])
run_exp_31 <- mean(data$run_exp[data$count %in% count_31])
run_exp_12 <- mean(data$run_exp[data$count %in% count_12])
run_exp_22 <- mean(data$run_exp[data$count %in% count_22])
run_exp_32 <- mean(data$run_exp[data$count %in% count_32])

count_exp <- data.frame("count"=c("00","01","02","10","20","30","11","21","31",
                                  "12","22","32"),
                        "exp"=c(run_exp_00,run_exp_01,run_exp_02,run_exp_10,
                                run_exp_20,run_exp_30,run_exp_11,run_exp_21,
                                run_exp_31,run_exp_12,run_exp_22,run_exp_32))
write_csv(count_exp,"data/processed/count_exp.csv")
