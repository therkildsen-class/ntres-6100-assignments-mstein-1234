library(tidyverse)
library(skimr)

coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')

skim(coronavirus)

view(coronavirus)

filter(coronavirus, cases > 0)
coronavirus_us <- filter(coronavirus, country == "US")
filter(coronavirus, country != "US")

coronavirus_US+Canada <- filter(coronavirus, country == "US" | country == "Canada")

coronavirus_US_Death <- filter(coronavirus, country == "US" & type == "death")

view(coronavirus_US_Death)

coronavirus_EU_deaths <- filter(coronavirus, country %in% c("France", "Spain", "Germany"), type == "death")
view(coronavirus_EU_deaths)


select(coronavirus, date, country, type, cases)
select(coronavirus, -province)
view(select(coronavirus, country, lat, long))
select(coronavirus, date:cases)



US_data <- filter(coronavirus, country == "US")
US_data2 <- select(US_data, -lat, -long, -province)
view(US_data2)

coronavirus |>
  filter(country == "US") |>
  select(-lat, -long, -province)

coronavirus |>
  filter(type == "death", country %in% c("US", "Canada", "Mexico"))|>
  select(country, date, cases) |>
  ggplot() + 
  geom_line(mapping = aes(x = date, y = cases, color = country))

coronavirus |>
  filter(type == "death", country %in% c("US", "Canada", "Mexico"))|>
  select(country, date, cases) |>
  ggplot() + 
  geom_bar(mapping = aes(x = country))


coronavirus |>
  count(country)

# Vaccine Data ------------------------------------------------------------
vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")
view(vacc)

max(vacc$date)

vacc |>
  filter(date == max(date)) |>
  select(country_region, continent_name, people_at_least_one_dose, population) |>
  mutate(vaxxrate = people_at_least_one_dose / population)

vacc |>
  filter(date == max(date)) |>
  select(country_region, continent_name, people_at_least_one_dose, population) |>
  mutate(vaxxrate = round(people_at_least_one_dose / population, 2))

vacc |>
  filter(date == max(date), doses_admin > 200 * 10^6) |>
  select(country_region, continent_name, people_at_least_one_dose, doses_admin, population) |>
  mutate(doses_per_vaxxed = doses_admin / people_at_least_one_dose)


vacc |>
  filter(date == max(date)) |>
  select(country_region, continent_name, people_at_least_one_dose, doses_admin, population) |>
  mutate(doses_per_vaxxed = doses_admin / people_at_least_one_dose) |>
  filter(doses_per_vaxxed > 3) |>
  arrange(-doses_per_vaxxed)

vacc |>
  filter(date == max(date)) |>
  select(country_region, continent_name, people_at_least_one_dose, doses_admin, population) |>
  mutate(percent_vaxxed = people_at_least_one_dose / population) |>
  arrange(-percent_vaxxed) |>
  filter(percent_vaxxed > .9) |>
  view()


# 9/23 class ----------------------------------------------------

coronavirus |>
  filter(type == "confirmed") |>
  group_by(country) |>
  summarize(total = sum(cases),
            n = n()) |>
  arrange(-total) |> 
  view()



coronavirus |> 
  group_by(date) |>
  filter(type == "death") |>
  summarize(total = sum(cases)) |> 
  arrange(-total)

gg_base <- coronavirus |> 
  filter (type == "confirmed") |> 
  group_by(date) |> 
  summarize(cases = sum(cases)) |>
  view() |> 
  ggplot(mapping = aes(x = date, y = cases))
    
  
gg_base +
  geom_point(mapping = aes(size = cases, color = cases),
    alpha = .4
  ) +
  theme_get() +
  theme(legend.background = element_rect(
    fill = "lemonchiffon",
    color = "grey50",
    linewidth = 1
  ))

gg_base +
  geom_point(mapping = aes(size = cases, color = cases),
             alpha = .4
  ) +
  theme_minimal() +
  theme(legend.position = "none")



gg_base +
  geom_point(mapping = aes(size = cases, color = cases),
             alpha = .4
  ) +
  theme_minimal() +
  labs(
    x = "Date",
    y = "Total Confirmed Cases",
    title = str_c("Very Good Plot", max(coronavirus$date), sep = " "), 
    subtitle = "So Good")

coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(date, country) |> 
  summarize(total = sum(cases)) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = total, color = country))

top5 <- coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(country) |> 
  summarize(total = sum(cases)) |> 
  arrange(-total) |> 
  head(5) |> 
  pull(country)

coronavirus |> 
  filter(type == "confirmed", country %in% top5, cases >= 0) |> 
  group_by(date, country) |> 
  summarize(total = sum(cases)) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = total, color = country)) +
  facet_wrap(~country, ncol = 1)








  
  
  