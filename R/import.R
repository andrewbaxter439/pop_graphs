library(tidyverse)

population <- read_csv("data/lfs_pop.csv", skip = 8,
                       col_names = c("Year", "Population.England.Wales"))


ggplot(population, aes(Year, Population.England.Wales)) +
  geom_col()


pop_tidy <- population |>
  mutate(pop = Population.England.Wales * 1000) |> 
  separate(Year, c("year", "month"), sep = " ", convert = TRUE) |> 
  filter(str_detect(month, "\\w{3}"),
         year > 2012) |> 
  mutate(date = ym(paste(year, month)))