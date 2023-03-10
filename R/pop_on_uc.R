library(statxplorer)
library(tidyverse)
library(lubridate)
library(SPHSUgraphs)

theme_set(theme_sphsu_light())


# loading data from StatXplore api ----------------------------------------

load_api_key("api_key.txt")

n_uc <- fetch_table(filename = "data/uc_pp_n.json")

n_uc_pp <- n_uc$dfs$`People on Universal Credit`

n_uc_pp <- n_uc_pp |> 
  mutate(date = my(Month))


# combining with population -----------------------------------------------

source("R/import.R")

pop_uc <- pop_tidy |> 
  inner_join(n_uc_pp, by = "date") |> 
  select(Month, date, n_uc = `People on Universal Credit`, pop)


# output graph ------------------------------------------------------------


pop_uc |> 
  mutate(prop_uc = n_uc / pop) |> 
  ggplot(aes(date, prop_uc)) +
  geom_col()