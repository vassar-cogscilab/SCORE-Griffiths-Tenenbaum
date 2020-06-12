library(tidyverse)

##Creating a set of fake data to work with

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

## Loading in data
## We will be loading in the raw data from the experiment, which will not need to be
## filtered besides by the inclusion criteria which will be described below

all.data <- read_csv('fake_data.csv')

## Inclusion Criteria
## Inclusion requires that:
## Responses must be greater than tpast
## Responses must be within 3 standard deviations from the mean

good.subjects <- all.data %>%
  filter(answer >= 103) %>%
  group_by(info) %>%
  filter(abs(answer - mean(answer)) / sd(answer) <= 3) %>%
  group_by(subject) %>%
  summarize(n = n()) %>%
  filter(n == 3) %>%
  pull(subject)

taxi.inclusion <- all.data %>%
  filter(subject %in% good.subjects)