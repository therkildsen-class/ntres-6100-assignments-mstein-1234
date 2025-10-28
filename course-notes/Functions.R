library(tidyverse)

calc_shrub_vol <- function(length, width, height = 1) {
  area <- length * width
  volume <-  area * height
  return(volume)
}

calc_shrub_vol(0.8, 1.6, 2.0)

est_shrub_mass <- function(volume){
  mass <- 2.65 * volume^0.9
  return(mass)
}

shrub_volume <- calc_shrub_vol(0.8, 1.6, 2.0)
shrub_mass <- est_shrub_mass(calc_shrub_vol(0.8, 1.6, 2.0))

calc_shrub_vol(0.8, 1.6, 2.0) |> 
  est_shrub_mass()

est_shrub_mass_from_raw <- function(length, width, height){
  volume <-  calc_shrub_vol(length, width, height)
  mass <- est_shrub_mass(volume)
  return(mass)
  }


convert_pounds_to_grams <- function(pounds) {
  grams <- 453.6 * pounds
  return(grams)
}

convert_pounds_to_grams(3.75)



library(tidyverse)
library(gapminder)


gapminder <- gapminder |> 
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)


est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- gapminder |> 
  left_join(est)


cntry <- "Belgium"
country_list <- c("Albania", "Canada", "Spain")


dir.create("figures")
dir.create("figures/europe")

country_list <- unique(gapminder$country)

gap_europe <- gapminder_est |> 
  filter(continent == "Europe") |> 
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country)

length(country_list)

# cntry <- "Albania"

print_plot <- function(cntry, stat) {
  
  print(str_c("Plotting ", cntry))
  
  gap_to_plot <- gap_europe |> 
    filter(country == cntry)
  
  my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = get(stat))) +
    geom_point() +
    labs(title = str_c(cntry, "GDP", sep = " "), 
         subtitle = ifelse(any(gap_to_plot$estimated == "yes"), "Estimated data", "Reported data"), y = stat())
  
  ggsave(filename = str_c("figures/europe/", cntry, "_gdp_tot.png", sep = ""), plot = my_plot)
  
}

print_plot("Germany", "pop")

for (cntry in country_list) {
  print_plot(cntry)
}
