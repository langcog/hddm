library(readr)
library(dplyr)

rm(list=ls())

# remove anyone who played fewer than 300 trials (means they did not complete at least half of the third game) or over 408 trials (means they completed the task twice, because 408 is max number of trials -- this only happened for one participant and I'm not sure how they were able to do this, so I'm rejecting them)
# create resp and rt vars
# remove outlier RTs
# filter the mysterious neg rt...
# clean up

d.turk <- read.csv("~/Projects/Negation/neginhib/long_data/long_data_mturk.csv")  %>%
  mutate(subj_idx = factor(subid)) %>%
  group_by(subid) %>%
  mutate(ntrials = n()) %>%
  filter(ntrials > 300 & ntrials < 408) %>%
  ungroup() %>%
  mutate(rt = rt/1000, 
         response = as.numeric(response == "Y")) %>%
  filter(rt > .200, 
         rt < 15) %>% 
  filter(log(rt) < mean(log(rt)) + 3 * sd(log(rt)), 
         log(rt) > mean(log(rt)) - 3 * sd(log(rt))) %>%
  select(subj_idx, game, trial.num, trial.type, rt, response) 

readr::write_csv(d.turk, "hddm_neginhib_adults.csv")   