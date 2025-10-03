---
editor_options: 
  markdown: 
    wrap: 72
---

# assignment_5

Michael Stein 2025-10-03

``` r
library(tidyverse)
```

```         
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.2     ✔ tibble    3.3.0
✔ lubridate 1.9.4     ✔ tidyr     1.3.1
✔ purrr     1.1.0     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

``` r
library(knitr)
library(gapminder)
library(dplyr)
```

## **Exercise 1. Trends in land value**

This excercise uses a dataset that describes the trends in land value
(`Land.Value`), among other variables, in different states in the US
1975-2013. The states are grouped into four different regions, under the
variable `region`. This dataset was obtained from the Data Science
Services of Harvard University.

``` r
housing <- read_csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/landdata_states.csv")
```

```         
Rows: 7803 Columns: 11
── Column specification ────────────────────────────────────────────────────────
Delimiter: ","
chr (2): State, region
dbl (9): Date, Home.Value, Structure.Cost, Land.Value, Land.Share..Pct., Hom...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

``` r
housing |> 
  head() |>  
  kable()
```

| State | region | Date | Home.Value | Structure.Cost | Land.Value | Land.Share..Pct. | Home.Price.Index | Land.Price.Index | Year | Qrtr |
|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| AK | West | 2010.25 | 224952 | 160599 | 64352 | 28.6 | 1.481 | 1.552 | 2010 | 1 |
| AK | West | 2010.50 | 225511 | 160252 | 65259 | 28.9 | 1.484 | 1.576 | 2010 | 2 |
| AK | West | 2009.75 | 225820 | 163791 | 62029 | 27.5 | 1.486 | 1.494 | 2009 | 3 |
| AK | West | 2010.00 | 224994 | 161787 | 63207 | 28.1 | 1.481 | 1.524 | 2009 | 4 |
| AK | West | 2008.00 | 234590 | 155400 | 79190 | 33.8 | 1.544 | 1.885 | 2007 | 4 |
| AK | West | 2008.25 | 233714 | 157458 | 76256 | 32.6 | 1.538 | 1.817 | 2008 | 1 |

## **1.1 Washington DC was not assigned to a region in this dataset. According to the United States Census Bureau, however, DC is part of the South region. Here:**

-   Change the region of DC to “South” (Hint: there are multiple ways to
    do this, but mutate() and ifelse() might be helpful)
-   Create a new tibble or regular dataframe consisting of this new
    updated region variable along with the original variables State,
    Date and Land.Value (and no others)
-   Pull out the records from DC in this new data frame. How many
    records are there from DC? Show the first 6 lines.

``` r
housing1 <- housing |> 
  mutate(region = ifelse(State == "DC", "South", region))

housing1 |> 
  filter(State == "DC") |> 
  head(6) |> 
  kable()
```

| State | region | Date | Home.Value | Structure.Cost | Land.Value | Land.Share..Pct. | Home.Price.Index | Land.Price.Index | Year | Qrtr |
|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| DC | South | 2003.00 | 384443 | 93922 | 290522 | 75.6 | 1.469 | 1.654 | 2002 | 4 |
| DC | South | 2003.25 | 399633 | 93961 | 305673 | 76.5 | 1.527 | 1.740 | 2003 | 1 |
| DC | South | 2003.50 | 417110 | 94032 | 323078 | 77.5 | 1.594 | 1.839 | 2003 | 2 |
| DC | South | 2003.75 | 436496 | 94486 | 342010 | 78.4 | 1.668 | 1.947 | 2003 | 3 |
| DC | South | 2004.00 | 457806 | 95807 | 361999 | 79.1 | 1.749 | 2.062 | 2003 | 4 |
| DC | South | 2004.25 | 481171 | 98379 | 382792 | 79.6 | 1.839 | 2.182 | 2004 | 1 |

Answer: 153

#### **1.2 Generate a tibble/dataframe that summarizes the mean land value of each region at each time point and show its first 6 lines.**

``` r
mean_home <- housing1 |> 
  group_by(region, Date) |> 
  summarize(mean_land_value = mean(Land.Value)) |> 
  select(region, Date, mean_land_value) |> 
  head(6) |> 
  kable()
```

```         
`summarise()` has grouped output by 'region'. You can override using the
`.groups` argument.
```

#### **1.3 Using the tibble/dataframe from 1.2, plot the trend in mean land value of each region through time.**

``` r
mean_home <- housing1 |> 
  group_by(region, Date) |> 
  summarize(mean_land_value = mean(Land.Value)) |> 
  select(region, Date, mean_land_value) |> 
  ggplot() +
  geom_line(aes(x = date, y = mean_land_value, color = region))
```

```         
`summarise()` has grouped output by 'region'. You can override using the
`.groups` argument.
```
