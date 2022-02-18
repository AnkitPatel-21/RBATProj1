library(tidyverse)

pbp <- read_csv("data/trackman.csv")

pbp1 <- select(pbp, PAofInning, PitchofPA, PitcherThrows, BatterSide, 
               Balls, Strikes, PitchCall, TaggedPitchType, AutoPitchType, 
               PitchZone, KorBB, PlayResult)

pbp1$pa_id <- cumsum(c(0,as.numeric(diff(pbp1$PAofInning))!=0))

pbp1$PlayResult[pbp1$KorBB=="Walk"] = "Walk"
pbp1$PlayResult[pbp1$KorBB=="Strikeout"] = "Out"
pbp1$PlayResult[pbp1$PlayResult=="Error"] = "Out"
pbp1$PlayResult[pbp1$PlayResult=="FieldersChoice"] = "Out"
pbp1$PlayResult[pbp1$PlayResult=="Sacrifice"] = "Out"
pbp1 <- select(pbp1, -KorBB)

offspeed <- c("Slider","Curveball")
fastball <- c("Fastball","Cutter","Four-Seam","Sinker")
ignore <- c("Undefined","Splitter","Other")

pbp1$AutoPitchType[pbp1$AutoPitchType %in% offspeed] <- "offspeed"
pbp1$AutoPitchType[pbp1$AutoPitchType %in% fastball] <- "fastball"
pbp1$AutoPitchType[pbp1$AutoPitchType %in% ignore] <- NA
pbp1 <- pbp1 %>% filter(!is.na(AutoPitchType)) %>% 
  mutate(AutoPitchType = str_replace(AutoPitchType, "ChangeUp", "changeup")) %>%
  mutate(AutoPitchType = str_replace(AutoPitchType, "Changeup", "changeup"))

noswing <- c("BallCalled","StrikeCalled","HitByPitch",
             "BallinDirt","BallIntentional")
swing <- c("StrikeSwinging","InPlay","FoulBall")
ignore <- c("CatchersInterference","BattersInterference","Undefined")

pbp1$PitchCall[pbp1$PitchCall %in% swing] <- "swing"
pbp1$PitchCall[pbp1$PitchCall %in% noswing] <- "take"
pbp1$PitchCall[pbp1$PitchCall %in% ignore] <- NA
pbp1 <- filter(pbp1, !is.na(PitchCall))

write_csv(pbp1, "data/autopitchdata.csv")
