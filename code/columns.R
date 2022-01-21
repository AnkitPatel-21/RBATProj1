library(tidyverse)

pbp <- read_csv("~/Downloads/trackman.csv")

pbp1 <- select(pbp, PAofInning, PitchofPA, PitcherThrows, BatterSide, 
               Balls, Strikes, TaggedPitchType, AutoPitchType, PitchZone, 
               KorBB, ExitSpeed, Angle)

write_csv(pbp1, "pitchdata.csv")