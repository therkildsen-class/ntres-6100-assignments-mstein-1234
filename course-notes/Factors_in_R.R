library(tidyverse)
library(gapminder) # install.packages("gapminder")
library(gridExtra) # install.packages("gridExtra")



# Intro factors -----------------

x1 <- c("Dec", "Apr", "Jan", "Mar")

sort(x1)

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

y1 <- factor(x1, levels = month_levels)

# Factors in plotting ---------------------------

gapminder

str(gapminder$continent)
levels(gapminder$continent)

gapminder |> 
  count(continent)

nlevels(gapminder$country)

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")

h_gap <- gapminder |> 
  filter(country %in% h_countries)
  
h_gap |> 
  count(country)

h_gap_dropped <- h_gap |> 
  droplevels()

nlevels(h_gap_dropped$country)

h_gap$country |> 
  fct_drop()

view(h_gap)


h_gap_pop <- gapminder |> 
  filter(pop < 250000)
  


h_gap_pop |> 
  count(country)

nlevels(h_gap_pop)

view(h_gap_dropped)

p1 <- gapminder |> 
  ggplot(aes(x = continent)) + 
  geom_bar()+
  coord_flip()

p2 <-  gapminder |> 
  ggplot(aes(x = fct_infreq(continent))) +
  geom_bar() +
  coord_flip()
  
gap_asia_2007 <- gapminder |> 
  filter(year == 2007, continent == "Asia")

gap_asia_2007 |> 
  ggplot(aes(x = lifeExp, y = country)) +
  geom_point()


gap_asia_2007 |> 
  ggplot(aes(x = lifeExp, y = fct_reorder(country, lifeExp))) +
  geom_point()



           

