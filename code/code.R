library(tidyverse)
library(baseballr)

pitches <- read_csv("data/autopitchdata.csv")

guts <- fg_guts() %>% filter(season==2021) %>% 
  select(wBB, w1B, w2B, w3B, wHR)
names(guts) <- c("Walk","Single","Double","Triple","HomeRun")
woba <- data.frame("PlayResult" = names(guts), "woba"=t(guts[1,]))
rm(guts)

pitches <- merge(pitches, woba, by="PlayResult", all.x=TRUE) %>% 
  arrange(pa_id, PitchofPA)
pitches$woba[pitches$PlayResult=="Out"] <- 0
results <- filter(pitches, !is.na(woba)) %>% select(pa_id, woba)

pitches1 <- merge(select(pitches, -woba), results, by="pa_id") %>% 
  arrange(pa_id, PitchofPA)

pitches_final <- mutate(pitches1, ballstrike = paste0(Balls, Strikes)) %>%
  select(PitcherThrows, BatterSide, TaggedPitchType, AutoPitchType, PitchZone,
         woba, ballstrike)

lr <- filter(pitches_final, BatterSide=="Left", PitcherThrows=="Right")
rr <- filter(pitches_final, BatterSide=="Right", PitcherThrows=="Right")
rl <- filter(pitches_final, BatterSide=="Right", PitcherThrows=="Left")
ll <- filter(pitches_final, BatterSide=="Left", PitcherThrows=="Left")

lr_woba <- lr %>% group_by(ballstrike, AutoPitchType, PitchZone) %>%
  summarise(xwoba = mean(woba))

rr_woba <- rr %>% group_by(ballstrike, AutoPitchType, PitchZone) %>%
  summarise(xwoba = mean(woba))

rl_woba <- rl %>% group_by(ballstrike, AutoPitchType, PitchZone) %>%
  summarise(xwoba = mean(woba))

ll_woba <- ll %>% group_by(ballstrike, AutoPitchType, PitchZone) %>%
  summarise(xwoba = mean(woba))
