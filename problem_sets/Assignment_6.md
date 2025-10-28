# Assignment_4


## **Exercise 1. Tibble and Data Import**

Import the data frames listed below into R and
[parse](https://r4ds.had.co.nz/data-import.html#parsing-a-vector) the
columns appropriately when needed. Watch out for the formatting oddities
of each dataset. Print the results directly, **without** using
`kable()`.

**You only need to finish any three out of the five questions in this
exercise in order to get credit.**

#### **1.1 Create the following tibble manually, first using `tribble()` and then using `tibble()`. Print both results. \[We didn’t have time to cover this in class, but look up how these functions work [here](https://r4ds.had.co.nz/tibbles.html#creating-tibbles)\]**

``` r
library(tidyverse)
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

``` r
library(knitr)


tribble(
  ~a, ~b, ~c,
  #--#--#---
  1, 2.1, "apple",
  2, 3.2, "orange"
) |> 
  print()
```

    # A tibble: 2 × 3
          a     b c     
      <dbl> <dbl> <chr> 
    1     1   2.1 apple 
    2     2   3.2 orange

``` r
## # A tibble: 2 × 3
##       a     b c     
##   <dbl> <dbl> <chr> 
## 1     1   2.1 apple 
## 2     2   3.2 orange


tibble(
  a = 1, 2,
  b = 2.1, 3.2,
  c = "apple", "orange"
) |> 
  print()
```

    # A tibble: 1 × 6
          a   `2`     b `3.2` c     `"orange"`
      <dbl> <dbl> <dbl> <dbl> <chr> <chr>     
    1     1     2   2.1   3.2 apple orange    

``` r
## # A tibble: 2 × 3
##       a     b c     
##   <int> <dbl> <chr> 
## 1     1   2.1 apple 
## 2     2   3.2 orange
```

#### **1.2 Import `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt` into R. Change the column names into “Name”, “Weight”, “Price”.**

    Rows: 3 Columns: 3
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (1): X1
    dbl (2): X2, X3

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    # A tibble: 3 × 3
      Name   Weight Price
      <chr>   <dbl> <dbl>
    1 apple       1   2.9
    2 orange      2   4.9
    3 durian     10  19.9

#### **1.3 Import `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset3.txt` into R. Watch out for the first few lines, missing values, separators, quotation marks, and deliminaters.**

    Rows: 3 Columns: 3
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ";"
    chr (1): /Name/
    dbl (2): /Weight/, /Price/

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    # A tibble: 3 × 3
      `/Name/` `/Weight/` `/Price/`
      <chr>         <dbl>     <dbl>
    1 /apple/           1       2.9
    2 /orange/          2      NA  
    3 /durian/         NA      19.9

#### **1.4 Import `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset4.txt` into R. Watch out for comments, units, and decimal marks (which are `,` in this case).**

``` r
clean_data <- read_delim(
  "https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset4.txt",
  locale = locale(decimal_mark = ","),
  comment = "/"
  ) 
```

    Warning: One or more parsing issues, call `problems()` on your data frame for details,
    e.g.:
      dat <- vroom(...)
      problems(dat)

    Rows: 3 Columns: 3
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: " "
    chr (3): Name, Weight, Price

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
cleaner_data <- clean_data |> 
  mutate(
    Weight = str_remove_all(Weight, "kg"),
    Price = str_remove_all(Price, "€")
  ) 

cleaner_data
```

    # A tibble: 3 × 3
      Name   Weight Price 
      <chr>  <chr>  <chr> 
    1 apple  1      "2,9 "
    2 orange 2      "4,9" 
    3 durian 10     "19,9"

## **Exercise 2. Weather station**

his dataset contains the weather and air quality data collected by a
weather station in Taiwan. It was obtained from the Environmental
Protection Administration, Executive Yuan, R.O.C. (Taiwan).

#### **2.1 Variable descriptions**

- The text file
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station_notes.txt`
  contains descriptions of different variables collected by the station.

- Import it into R and print it in a table as shown below with
  `kable()`.

``` r
read_delim(
  "https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station_notes.txt",
  delim = "-") |> 
  kable()
```

    Rows: 15 Columns: 3
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: "-"
    chr (3): Item, Unit, Description

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

| Item | Unit | Description |
|:---|:---|:---|
| AMB_TEMP | Celsius | Ambient air temperature |
| CO | ppm | Carbon monoxide |
| NO | ppb | Nitric oxide |
| NO2 | ppb | Nitrogen dioxide |
| NOx | ppb | Nitrogen oxides |
| O3 | ppb | Ozone |
| PM10 | μg/m3 | Particulate matter with a diameter between 2.5 and 10 μm |
| PM2.5 | μg/m3 | Particulate matter with a diameter of 2.5 μm or less |
| RAINFALL | mm | Rainfall |
| RH | % | Relative humidity |
| SO2 | ppb | Sulfur dioxide |
| WD_HR | degress | Wind direction (The average of hour) |
| WIND_DIREC | degress | Wind direction (The average of last ten minutes per hour) |
| WIND_SPEED | m/sec | Wind speed (The average of last ten minutes per hour) |
| WS_HR | m/sec | Wind speed (The average of hour) |

#### **2.2 Data tidying**

- Import
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station.csv`
  into R. As you can see, this dataset is a classic example of untidy
  data: values of a variable (i.e. hour of the day) are stored as column
  names; variable names are stored in the `item` column.

- Clean this dataset up and restructure it into a tidy format.

- Parse the `date` variable into date format and parse `hour` into time.

- Turn all invalid values into `NA` and turn `NR` in rainfall into `0`.

- Parse all values into numbers.

- Show the first 6 rows and 10 columns of this cleaned dataset, as shown
  below, *without* using `kable()`.

*Hints: you don’t have to perform these tasks in the given order; also,
warning messages are not necessarily signs of trouble.*

``` r
weather <- read_delim(
  "https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station.csv",
  col_names = c("date", "station", "item", "AMB_TEMP", "CO", "NO", "NO2", "NOx", "O3", "PM10", "PM2", "RAINFALL", "RH", "SO2", "WD_HR", "WIND_DIREC", "WIND_SPEED", "WS_HR")
) 
```

    Warning: One or more parsing issues, call `problems()` on your data frame for details,
    e.g.:
      dat <- vroom(...)
      problems(dat)

    Rows: 5461 Columns: 27
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (23): date, station, item, AMB_TEMP, CO, NO, NO2, NOx, O3, PM10, PM2, RA...
    dbl  (4): X22, X23, X25, X26

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
weather_column <- weather |> 
  select(-item) |> 
  slice(-1)
  

print(weather_column)
```

    # A tibble: 5,460 × 26
       date      station AMB_TEMP CO    NO    NO2   NOx   O3    PM10  PM2   RAINFALL
       <chr>     <chr>   <chr>    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>   
     1 2015/01/… Cailiao 16       16    15    15    15    14    14    14    14      
     2 2015/01/… Cailiao 0.74     0.7   0.66  0.61  0.51  0.51  0.51  0.6   0.62    
     3 2015/01/… Cailiao 1        0.8   1.1   1.7   2     1.7   1.9   2.4   3.4     
     4 2015/01/… Cailiao 15       13    13    12    11    13    13    16    16      
     5 2015/01/… Cailiao 16       14    14    13    13    15    15    18    19      
     6 2015/01/… Cailiao 35       36    35    34    34    32    30    26    26      
     7 2015/01/… Cailiao 171      174   160   142   123   110   104   104   109     
     8 2015/01/… Cailiao 76       78    69    60    52    44    40    41    44      
     9 2015/01/… Cailiao NR       NR    NR    NR    NR    NR    NR    NR    NR      
    10 2015/01/… Cailiao 57       57    58    59    59    57    57    56    53      
    # ℹ 5,450 more rows
    # ℹ 15 more variables: RH <chr>, SO2 <chr>, WD_HR <chr>, WIND_DIREC <chr>,
    #   WIND_SPEED <chr>, WS_HR <chr>, X19 <chr>, X20 <chr>, X21 <chr>, X22 <dbl>,
    #   X23 <dbl>, X24 <chr>, X25 <dbl>, X26 <dbl>, X27 <chr>
