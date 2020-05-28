library(tidyverse)

DF1 <- data.frame(category = c("teacake", "toxin"),
                   question1 = seq(1, 34, 1),
                   question2 = seq(1, 34, 1),
                   question3 = seq(1, 34, 1))

r <- sample(nrow(DF1))
DF1 <- DF1[r, 1:4]
head(DF1, n = 40)

DF2 <- data.frame(category = c("train", "taxicab"),
                  question1 = seq(1, 103, 1),
                  question2 = seq(1, 103, 1),
                  question3 = seq(1, 103, 1))

r <- sample(nrow(DF2))
DF2 <- DF2[r, 1:4]
head(DF2, n = 41)

DF3 <- data.frame(category = c("train", "taxicab"),
                   question1 = seq(1, 103, 1),
                   question2 = seq(1, 103, 1),
                   question3 = seq(1, 103, 1))

r <- sample(nrow(DF3))
DF3 <- DF3[r, 1:4]
head(DF3, n = 41)

total <- rbind(DF1, DF2)