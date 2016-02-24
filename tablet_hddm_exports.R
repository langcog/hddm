rm(list=ls())
library(dplyr)
library(readr)

d <- read_csv("~/Projects/Scalar Implicature/SI_tablet/paper/SI_tablet/tmp_si.csv") %>%
  rename(subj_idx = sub_id, 
         response = correct) %>%
  filter(age <= 6.5) %>%
  select(subj_idx, trial_num, trial_type, rt, response, age) %>%
  mutate(rt = rt/1000, 
         response = as.numeric(response == "Y")) %>%
  filter(rt > .200, 
         rt < 15) %>% 
  filter(log(rt) < mean(log(rt)) + 3 * sd(log(rt)), 
         log(rt) > mean(log(rt)) - 3 * sd(log(rt))) %>%
  select(subj_idx, age, trial_num, trial_type, rt, response) 

write_csv(d, "hddm_si_kids.csv")   
