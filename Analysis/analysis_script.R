library(tidyverse)
## Loading in data
## We will be loading in the raw data from the experiment, which will not need to be
## filtered besides by the inclusion criteria which will be described below

all.data <- read_csv('fake_data.csv')

## Inclusion Criteria
## Inclusion requires that:
## Responses must be greater than tpast
## Responses must be within 3 standard deviations from the mean

info1.df <- all.data %>%
  filter(info == "1")

info1.inclusion <-info1.df[!(abs(info1.df$answer - mean(info1.df$answer)) / sd(info1.df$answer)) >3,]

info3.df <- all.data %>%
  filter(info == "3")

info3.inclusion <-info3.df[!(abs(info3.df$answer - mean(info3.df$answer)) / sd(info3.df$answer)) >3,]

info10.df <- all.data %>%
  filter(info == "10")

info10.inclusion <-info10.df[!(abs(info10.df$answer - mean(info10.df$answer)) / sd(info10.df$answer)) >3,]

info.inclusion <- rbind(info1.inclusion, info3.inclusion, info10.inclusion)

taxi.inclusion <- info.inclusion %>%
  group_by(subject) %>%
  filter((info == "1" & answer >= 103) |
         (info == "3" & answer >= 103) |
         (info == "10" & answer >= 103)) %>%
  filter(subject, n() == 3)


## Now we apply the inclusion criteria and create an updated data frame

taxi.transform <- taxi.inclusion %>%
  mutate(answer.transform = answer/103)

## Now we need to code for the ANOVA test

taxi.results <- aov(answer.transform ~ info, data = taxi.transform)

summary(taxi.results)

