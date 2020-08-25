library(tidyverse)
library(ez)
## Loading in data
## We will be loading in the raw data from the experiment, which will not need to be
## filtered besides by the inclusion criteria which will be described below

all.data <- read_csv('data/score-data-batch-1.csv')

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


## Now we apply the inclusion criteria and create an updated data frame

taxi.transform <- taxi.inclusion %>%
  mutate(answer.transform = answer/103)

taxi.transform$info <- factor(taxi.transform$info, levels = c(1.0, 3.0, 10.0))

## Now we need to code for the ANOVA test

taxi.results <- ezANOVA(data = taxi.transform,
                        dv = .(answer.transform),
                        wid = .(subject),
                        within = .(info),
                        detailed = TRUE)

print(taxi.results)

## plot the results graph

plotting.data <- taxi.transform %>%
  mutate(info = as.numeric(as.character(info))) %>%
  group_by(info) %>%
  summarize(mean = mean(answer.transform),
            se = sd(answer.transform) / sqrt(n()))

ggplot(plotting.data, aes(x = info, y = mean)) +
  geom_pointrange(aes(ymin = mean - se, ymax = mean + se)) +
  geom_line(aes(y = mean, color = "Participants")) +
  scale_color_manual(name = "", values = c("Participants" = "black")) +
  scale_x_continuous(breaks = c(1, 3, 10)) +
  theme_bw() +
  labs(y = "Predicted t/tpast", x = "Number of Examples Seen") +
  ylim(1, 5) +
  theme(panel.grid = element_blank()) +
  theme(legend.position = c(0.95, 0.95), 
        legend.justification = c("right", "top"))
