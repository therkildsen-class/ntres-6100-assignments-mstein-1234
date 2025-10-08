library(tidyverse)
library("readxl") # install.packages("readxl")
library(googlesheets4) # install.packages("googlesheets4")
library(janitor)  # install.packages("janitor")

lotr <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
view(lotr)

write_csv(lotr, file = "data/lotr_gender.csv")

lotr <- read_csv("data/lotr_gender.csv")

lotr_excel <- read_xlsx("data/data_lesson11.xlsx")

view(lotr_excel)

lotr_google <- read_sheet("https://docs.google.com/spreadsheets/d/1X98JobRtA3JGBFacs_JSjiX-4DPQ0vZYtNl_ozqF6IE/edit?gid=0#gid=0", sheet = "deaths", range = "A5:F15")
gs4_deauth()

view(lotr_google)


msa <- read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/main/datasets/janitor_mymsa_subset.txt")
view(msa)

colnames(msa)
msa_clean <-  clean_names(msa)
msa_clean

parse_number("It is 100%")

parse_double("1,23", locale = locale(decimal_mark = ","))

parse_number("123.456.789", locale = locale(grouping_mark = "."))

mess = read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/refs/heads/main/datasets/messy_data.tsv", locale = locale(decimal_mark = ","), na = c("Missing", "N/A"))

view(mess)

mess |> 
  mutate(price = parse_number(price)) |> 











