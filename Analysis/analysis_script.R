library(tidyverse)
## Loading in data
## We will be loading in the raw data from the experiment, which will not need to be
## filtered besides by the inclusion criteria which will be described below

all.data <- read_csv('fake_data.csv')

## Inclusion Criteria
## Inclusion requires that:
## Responses must be greater than tpast
## Responses must be within 3 standard deviations from the mean

question1.answer <- all.data[!(abs(all.data$question1 - mean(all.data$question1)) / sd(all.data$question1)) >3,]

question2.answer <- all.data[!(abs(all.data$question2 - mean(all.data$question2)) / sd(all.data$question2)) >3,]

question3.answer <- all.data[!(abs(all.data$question3 - mean(all.data$question3)) / sd(all.data$question3)) >3,]

tea.inclusion <- all.data %>%
  filter(category=="teacake", 
         question1 >= 34, 
         question2 >= 34, 
         question3 >= 34)

toxin.inclusion <- all.data %>%
  filter(category == "toxin", 
         question1 >= 34, 
         question2 >= 34, 
         question3 >= 34)

train.inclusion <- all.data %>%
  filter(category == "train", 
         question1 >= 103, 
         question2 >= 103, 
         question3 >= 103)

taxi.inclusion <- all.data %>%
  filter(category == "taxicab", 
         question1 >= 103, 
         question2 >= 103, 
         question3 >= 103)

## Now we apply the inclusion criteria and create an updated data frame
final.include <- rbind(tea.inclusion, 
                       toxin.inclusion, 
                       train.inclusion, 
                       taxi.inclusion)

## We now need to transform the data to the form t/tpast
tea.toxin.transform <- final.include %>%
  filter(category == "teacake" | category == "toxin") %>%
  mutate(question1.transform = question1/34,
         question2.transform = question2/34,
         question3.transform = question3/34)

train.taxi.transform <- final.include %>%
  filter(category == "train" | category == "taxicab") %>%
  mutate(question1.transform = question1/103,
         question2.transform = question2/103,
         question3.transform = question3/103)

final.transform <- rbind(tea.toxin.transform, train.taxi.transform)


