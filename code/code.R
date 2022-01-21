library(tidyverse)

pitches <- read_csv("pitchdata.csv")

pitches$pa_id <- cumsum(c(0,as.numeric(diff(pitches$PAofInning))!=0))

View(pitches)

fill_speed <- function(pa_id){
  p = pitches[pitches$pa_id == pa_id,]
  if('InPlay' %in% p$PitchCall){
    p$ExitSpeed[1:(dim(p)[1]-1)] <- p$ExitSpeed[p$PitchCall=="InPlay"]
    p$Angle[1:(dim(p)[1]-1)] <- p$Angle[p$PitchCall=="InPlay"]
  } else{
    p$ExitSpeed[1:(dim(p)[1])] <- NA
    p$Angle[1:(dim(p)[1])] <- NA
  }
  p
}

pas = 0:50681

updated = data.frame()
for(i in pas){
  updated = rbind(updated, fill_speed(i))
  cat(i, "\n")
}
View(updated)
