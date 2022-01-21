library(tidyverse)

pitches <- read_csv("pitchdata.csv")

pitches$pa_id <- cumsum(c(0,as.numeric(diff(pitches$PAofInning))!=0))

fill_speed <- function(pa_id) {
  p = pitches[pitches$pa_id == pa_id,]
  if('InPlay' %in% p$PitchCall){
    p$ExitSpeed[1:(dim(p)[1]-1)] <- rep(p$ExitSpeed[p$PitchCall=="InPlay"], 
                                        times = length(p$ExitSpeed[1:(dim(p)[1]-1)]))
    p$Angle[1:(dim(p)[1]-1)] <- rep(p$Angle[p$PitchCall=="InPlay"], 
                                    times = length(p$Angle[1:(dim(p)[1]-1)]))
  } else{
    p$ExitSpeed[1:(dim(p)[1])] <- NA
    p$Angle[1:(dim(p)[1])] <- NA
  }
  p
}

pas = 0:50681

#updated = data.frame(pbp = c(), PAofInning= c(), PitchofPA= c(), PitcherThrows= c(), BatterSide= c(),
                 Balls= c(), Strikes= c(), TaggedPitchType= c(), AutoPitchType= c(), PitchZone= c(),
                 KorBB= c(), ExitSpeed= c(), Angle= c(), PitchCall= c())
for (i in pas){
  updated = rbind(updated, fill_speed(i))
  cat(i, "\n")
}

View(updated)
nrow(pitches) == nrow(updated)

bad <- updated %>% filter(PitchCall=="InPlay", is.na(ExitSpeed))  %>% select(pa_id)

updated = updated %>% filter(!(pa_id %in% bad))
updated$ballstrike = apply(updated[ ,c('Balls','Strikes')], 1, paste, collapse = "" )

#e=do.call("rbind", sapply(pas, fill_speed))

pt = read.csv('~/Downloads/pitcheswoba.csv')
pt$count = apply(pt[ ,c('Balls','Strikes')], 1, paste, collapse = "" )

View(pt)

updated = fill_speed(0)

fill_speed <- function(pa_id) {
  p = pitches[pitches$pa_id == pa_id,]
  if('InPlay' %in% p$PitchCall){
    p$ExitSpeed[1:(dim(p)[1]-1)] <- rep(p$ExitSpeed[p$PitchCall=="InPlay"], 
                                        times = length(p$ExitSpeed[1:(dim(p)[1]-1)]))
    p$Angle[1:(dim(p)[1]-1)] <- rep(p$Angle[p$PitchCall=="InPlay"], 
                                    times = length(p$Angle[1:(dim(p)[1]-1)]))
  } else{
    p$ExitSpeed[1:(dim(p)[1])] <- NA
    p$Angle[1:(dim(p)[1])] <- NA
  }
  p
}

