library(tidyverse)

mpg
?mpg

?cars
cars

View(mpg)

head(cars)
tail(cars)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy), color = "blue")


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1) +
  geom_smooth() +
  facet_wrap(~ year)

ggplot(data = mpg)
