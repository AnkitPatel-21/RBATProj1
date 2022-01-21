library(tidyverse)

pitches <- read_csv("pitchdata.csv")

pitches$pa_id <- cumsum(c(0,as.numeric(diff(pitches$PAofInning))!=0))
