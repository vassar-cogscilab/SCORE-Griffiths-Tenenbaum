library(jsonlite)
library(tidyverse)

json_data <- fromJSON("data/score-data-batch-1.json")

converted_data = subset(json_data, select = -c(row, rt, stimulus, button_pressed,
                                               trial_type, trial_index, time_elapsed))

minusRow <- converted_data[-c(1),]%>%
  unnest(cols = c(responses))%>%
  mutate(answer=str_extract(str_extract(responses,":.*"),"[0-9]+"),
         responses=NULL)


Nth.delete<-function(dataframe, n)dataframe[-(seq(n,to=nrow(dataframe),by=n)),]


write.csv(Nth.delete(minusRow, 4), "data/score-data-batch-1.csv", row.names = F)
