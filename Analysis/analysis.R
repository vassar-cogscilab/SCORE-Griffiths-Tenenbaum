library(tidyverse)

DF1 <- data.frame(subject = rep(c("1", "2", "3", "4", "5",
                                  "6", "7", "8", "9", "10",
                                  "11", "12", "13", "14", "15",
                                  "16", "17", "18", "19", "20",
                                  "21", "22", "23", "24", "25",
                                  "26", "27", "28", "29"), each = 3),
                  category = sample(c("taxicab"), size = 87, replace = T),
                  info = c("1", "3", "10"),
                  answer = sample(50:460, size = 87, replace = T))

write.csv(DF1, "fake_data.csv", row.names = F)

