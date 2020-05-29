library(tidyverse)

DF1 <- data.frame(category = sample(c("teacake", "toxin"), size = 14, replace = T),
                   question1 = sample(1:100, size = 14, replace = T),
                   question2 = sample(1:100, size = 14, replace = T),
                   question3 = sample(1:100, size = 14, replace = T))

r <- sample(nrow(DF1))
DF1 <- DF1[r, 1:4]
head(DF1, n = 14)

DF2 <- data.frame(category = sample(c("train", "taxicab"), size = 15, replace = T),
                  question1 = sample(50:200, size = 15, replace = T),
                  question2 = sample(50:200, size = 15, replace = T),
                  question3 = sample(50:200, size = 15, replace = T))

r <- sample(nrow(DF2))
DF2 <- DF2[r, 1:4]
head(DF2, n = 15)


total <- rbind(DF1, DF2)
print(total)

write.csv(total, "fake_data", row.names = F)

