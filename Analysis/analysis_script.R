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
tea.transform <- final.include %>%
  filter(category == "teacake") %>%
  mutate(question1.transform = question1/34,
         question2.transform = question2/34,
         question3.transform = question3/34)

toxin.transform <- final.include %>%
  filter(category == "toxin") %>%
  mutate(question1.transform = question1/34,
         question2.transform = question2/34,
         question3.transform = question3/34)

train.transform <- final.include %>%
  filter(category == "train") %>%
  mutate(question1.transform = question1/103,
         question2.transform = question2/103,
         question3.transform = question3/103)

taxi.transform <- final.include %>%
  filter(category == "taxi") %>%
  mutate(question1.transform = question1/103,
         question2.transform = question2/103,
         question3.transform = question3/103)

## Create a data frame with the new transformed data added in
final.transform <- rbind(tea.transform, toxin.transform, train.transform, taxi.transform)

## Now we need to code for the ANOVA test
final.transform$category <-factor(final.transform$category, 
                                  levels = c("teacake", "toxin", "train", "taxicab"))

formulae <- lapply(colnames(final.transform) [5:ncol(final.transform)],
                   function(x) as.formula(paste0(x, "~ category")))

lapply(formulae, function(x) summary(aov(x, data = final.transform)))

##question1.results <- aov(question1.transform ~ category, 
      ##data = final.transform)

##summary(question1.results)

##question2.results <- aov(question2.transform ~ category, 
                         ##data = final.transform)

##summary(question2.results)

##question3.results <- aov(question3.transform ~ category, 
                         ##data = final.transform)

##summary(question3.results)
