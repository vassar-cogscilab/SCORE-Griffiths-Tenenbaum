library(tidyverse)
## Loading in data
## We will be loading in the raw data from the experiment, which will not need to be
## filtered besides by the inclusion criteria which will be described below

all.data <- read_csv(fake_data.csv)

## Inclusion Criteria
## Inclusion requires that:
## Responses must be greater than tpast
## Responses must be between 3 standard deviations from the mean

