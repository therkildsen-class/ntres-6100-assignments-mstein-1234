library(tidyverse)

view(table1)

table2

table3

view(table4a)

table4b


table1 |> 
  mutate(rate = cases/population * 10000)

table1 |> 
  group_by(year) |> 
  summarize(total = sum(cases))

table1 |> 
  ggplot(mapping = aes(x = year, y = cases)) +
  geom_line()

table4a |> 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

table4b |> 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")


table2 |> 
  pivot_wider(names_from = type, values_from = count)


table3 |> 
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

table5 <- table3 |> 
  separate(year, into = c("century", "year"), sep = 2)

table5 |> 
  unite(fullyear, century, year, sep = "")

view(coronvarius)





