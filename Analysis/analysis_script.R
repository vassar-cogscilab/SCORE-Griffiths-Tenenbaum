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

## plot the results graph

info1.plot <- taxi.transform %>%
  group_by(subject, category, info, answer, answer.transform) %>%
  filter(info == "1") %>%
  summarize(mean = mean(info1.inclusion$answer)/103, 
            se = sd(info1.inclusion$answer/103) / sqrt(n()))

info3.plot <- taxi.transform %>%
  group_by(subject, category, info, answer, answer.transform) %>%
  filter(info == "3") %>%
  summarize(mean = mean(info3.inclusion$answer)/103, 
            se = sd(info3.inclusion$answer/103) / sqrt(n()))

info10.plot <- taxi.transform %>%
  group_by(subject, category, info, answer, answer.transform) %>%
  filter(info == "10") %>%
  summarize(mean = mean(info10.inclusion$answer)/103, 
            se = sd(info10.inclusion$answer/103) / sqrt(n()))

plotting.data <- rbind(info1.plot, info3.plot, info10.plot)

ggplot(plotting.data, aes(x = info, y = mean)) +
  geom_point() +
  geom_line()

# plot(x=1,
#      type = "n",
#      xlim = c(1, 10),
#      ylim = c(1, 5),
#      pch = 19,
#      xlab = "Amount of Prior Information",
#      ylab = "Predicted t/tpast",
#      main = "Results")
# 
# points(x = 1,
#        y = info1.mean,
#        pch = 19,
#        col = "black")
# 
# points(x = 3,
#        y = info3.mean,
#        pch = 19,
#        col = "black")
# 
# points(x = 10,
#        y = info10.mean,
#        pch = 19,
#        col = "black")
# 
# segments(x0 = 1,
#          y0 = info1.mean,
#          x1 = 3,
#          y1 = info3.mean,
#          col = gray(0, 0.5))
# 
# segments(x0 = 3,
#          y0 = info3.mean,
#          x1 = 10,
#          y1 = info10.mean,
#          col = gray(0, 0.5))

## Calculate the Erlang prior

sum.se <- sum(plotting.data$se)

erlang.prior <- mean(taxi.transform$answer) * exp(-(mean(taxi.transform$answer)/sum.se)) / sum.se^2
