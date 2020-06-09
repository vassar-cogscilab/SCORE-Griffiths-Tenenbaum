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