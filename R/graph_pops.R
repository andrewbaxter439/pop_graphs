source("R/import.R")

pop_tidy |> 
  ggplot(aes(date, pop)) +
  geom_line()

#Hello!

# new line

ggsave("graphs/pop_by_month.png")
