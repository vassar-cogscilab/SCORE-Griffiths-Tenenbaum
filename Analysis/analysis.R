library(tidyverse)
data <- expand.grid(category = c("teacake", "train", "toxin", "taxicab"),
                    question1 = seq(1, 120, 1),
                    question2 = seq(1, 120, 1),
                    question3 = seq(1, 120, 1))
r <- sample(nrow(data))
data <- data[r, 1:4]
head(data, n = 81)

