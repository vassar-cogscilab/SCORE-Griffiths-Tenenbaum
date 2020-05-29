library(tidyverse)
## Loading in data
## We will be loading in the raw data from the experiment, which will not need to be
## filtered besides by the inclusion criteria which will be described below

all.data <- read_csv('fake_data')

## Inclusion Criteria
## Inclusion requires that:
## Responses must be greater than tpast
## Responses must be within 3 standard deviations from the mean

question1.answer <- all.data[!(abs(all.data$question1 - mean(all.data$question1)) / sd(all.data$question1)) >3,]

question2.answer <- all.data[!(abs(all.data$question2 - mean(all.data$question2)) / sd(all.data$question2)) >3,]

question3.answer <- all.data[!(abs(all.data$question3 - mean(all.data$question3)) / sd(all.data$question3)) >3,]

tea.inclusion <- all.data %>%
  filter(category=="teacake") %>%
  summarize(tea.answers = all.data$question1 && all.data$question2 && all.data$question3) %>%
  mutate(tea.include = tea.answers >= 34)

toxin.inclusion <- all.data %>%
  filter(category == "toxin") %>%
  summarize(toxin.answers = all.data$question1 && all.data$question2 && all.data$question3) %>%
  mutate(toxin.include = toxin.answers >= 34)

train.inclusion <- all.data %>%
  filter(category == "train") %>%
  summarize(train.answers = all.data$question1 && all.data$question2 && all.data$question3) %>%
  mutate(train.include = train.answers >= 103)

taxi.inclusion <- all.data %>%
  filter(category == "taxicab") %>%
  summarize(taxi.answers = all.data$question1 && all.data$question2 && all.data$question3) %>%
  mutate(taxi.include = taxi.answers >= 103)

final.include <- all.data %>%
  mutate(include = tea.include && toxin.include && train.include && taxi.include)

use.participants <- final.include %>%
  filter(include == T) %>%
  select(category)

## Now we apply these inclusion criterias

filtered.data <- all.data %>%
  filter(category == use.participants)

print(tea.include)
  