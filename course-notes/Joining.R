library(tidyverse)
library(nycflights13) # install.packages("nycflights13")

view(planes)

planes |> 
  count(tailnum) |> 
  view()

view(flights)

flights2 <- flights |>
  select(year:day, hour, origin, dest, tailnum, carrier)

view(flights2)
view(airlines)

flights2 |> 
  left_join(airlines) |> 
  view()

airports |> 
  semi_join(flights2, join_by(faa == origin))

flights2 |> 
  anti_join(airports, join_by(dest == faa)) |> 
  count(dest) 


flights2 |> 
  anti_join(airports, join_by(dest == faa)) |> 
  distinct(dest)

view(planes)

planes_gt100 <- flights2 |> 
  group_by(tailnum) |>
  summarize(count = n()) |> 
  filter(count > 100)

# above and below code -- these are the same 

planes_gt99 <- flights2 |> 
  count(tailnum) 
filter(count > 100)

flights |> 
  semi_join(planes_gt100) |> 
  view()




fship <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")

ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")

rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")


lotr <- bind_rows(fship, ttow, rking)

fship_no_female <-  fship |> 
  select(-Female)

lotr <- bind_rows(fship_no_female, ttow, rking)


view(flights)

view(airlines)
view(airports)

planes |> 
  count(tailnum) |> 
  filter(n > 1) |> 

planes |> 
  count(year) |> 
  mutate(
    
  )

view(weather)

weather |> 
  count(time_hour, origin) |> 
  filter(n > 1)

planes |> 
  filter(is.na(tailnum))

flights2 <- flights |> 
  select(year:day, hour, origin, dest, tailnum, carrier)

flights2 |>
  left_join(airlines)

flights2 |> 
  left_join(weather)

flights2 |> 
  left_join(planes, join_by(tailnum), suffix = c("_flights", "_planes")) |> 
  view()

flights2 |> 
  left_join(airports, join_by(origin == faa)) |> 
  view()


# below, bad code I tried
flights2 |> 
  left_join(airports, join_by(origin == faa, dest == faa), suffix = c("_origin_airport", "_dest_airport")) |> 
  view()

airports2 <-  airports |> 
  select(faa, name, lat, lon)
  

flights2 |> 
  left_join(airports2, join_by(origin == faa)) |> 
  left_join(airports2, join_by(dest == faa), suffix = c("_origin_airport", "_dest_airport")) |> 
  view()





  
  
  
