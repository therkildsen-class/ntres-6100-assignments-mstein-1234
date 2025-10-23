library(palmerpenguins)
library(tidyverse)
library(ggplot2)
library(gapminder)
library(janitor)
library(knitr)


# explore penguins data set
glimpse(penguins)
# visualize bill length by species
ggplot(penguins, aes(x = species, y = bill_length_mm, fill = species)) +
  geom_boxplot() +
  labs(title = "Bill Length by Penguin Species",
       x = "Species",
       y = "Bill Length (mm)") +
  theme_minimal()

# what is the relationship between body mass and flipper length in penguins 
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Body Mass vs Flipper Length in Penguins",
       x = "Flipper Length (mm)",
       y = "Body Mass (g)") +
  theme_minimal()

# what is the relationship between body mass and flipper length in penguins by sex
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = sex)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Body Mass vs Flipper Length in Penguins by Sex",
       x = "Flipper Length (mm)",
       y = "Body Mass (g)") +
  theme_minimal()


# what is the relationship between body mass and flipper length in penguins by sex without NAs
penguins_clean <- penguins %>%
  filter(!is.na(sex)) 

head(gapminder) |> 
  kable()

gapminder_clean <- gapminder |> 
  clean_names()


#create a plot of GDP_percap vs year for each country, use for loops and ggsave
unique_countries <- unique(gapminder_clean$country)

for (country in unique_countries) {
  country_data <- gapminder_clean |> 
    filter(country == !!country)
  
  p <- ggplot(country_data, aes(x = year, y = gdp_percap)) +
    geom_line(color = "blue") +
    geom_point(color = "red") +
    labs(title = paste("GDP per Capita Over Time in", country),
         x = "Year",
         y = "GDP per Capita") +
    theme_minimal()
  
  ggsave(filename = paste0("gdp_per_cap_", gsub(" ", "_", country), ".png"), plot = p)
}


