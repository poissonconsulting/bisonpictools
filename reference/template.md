# Raw template for wood bison data

A list containing four data frames. Each data frame describes the
required format for each data set. This is the raw non human readable
version of the template used by the package developers.

## Usage

``` r
template
```

## Format

### 

A list of the following four data frames:

### 1. `location`

A data frame with columns:

- location_id:

  Location name for the camera

- latitude:

  Latitude of camera location

- longitude:

  Longitude of camera location

### 2. `event`

A data frame with columns:

- location_id:

  Location name for the camera

- start_year, start_month, start_day, start_hour, start_minute:

  Date and time when the event started

- fa, f1, f0, fu:

  Count of female adults, yearlings, calves, and unknown ages

- ma, m3, m2, m1, m0, mu:

  Count of male adults, 3-year-olds, 2-year-olds, yearlings, calves, and
  unknown ages

- ua, u1, u0, uu:

  Count of unknown sex adults, yearlings, calves, and unknown ages

### 3. `census`

A data frame with columns:

- census_year, census_month, census_day:

  Date of the census

- census:

  Estimated census count

- census_cv:

  Coefficient of variation (standard deviation / estimate) of census
  estimate

### 4. `proportion_calf`

A data frame with columns:

- calf_proportion_year, calf_proportion_month, calf_proportion_day:

  Date of the calf proportion survey

- calf_proportion:

  Estimated calf proportion

- calf_proportion_cv:

  Coefficient of variation (standard deviation / estimate) of calf
  proportion estimate

## Details

Raw data should be entered according to the template requirements. To
use the template you will need to delete the `name` column and all rows
except row 1 which contains the column names. Once only the column names
are remaining your raw data can be entered into each excel sheet.

The name row provides the names of each column. The example row provides
an example of the column. The description row provides a written
description of the column. The chk row provides details on the
constraints placed on the values of the column, which may include only
allowing certain words, a range of values or certain types. The pkey row
indicates which columns make up the primary key by putting TRUE in the
column. The join row indicates if the table is a child table joined by
the column.

For more details see the package vignette.

## Examples

``` r
template
#> $location
#> # A tibble: 5 × 4
#>   name        location_id                     latitude                 longitude
#>   <chr>       <chr>                           <chr>                    <chr>    
#> 1 example     "RLBH006"                       57.895690000000002       -111.677…
#> 2 description "Location name for  the camera" Latitude of camera loca… Longitud…
#> 3 chk         "c(\"\")"                       c(50, 120)               c(-120, …
#> 4 pkey        "TRUE"                          NA                       NA       
#> 5 join         NA                             NA                       NA       
#> 
#> $event
#> # A tibble: 5 × 21
#>   name      location_id start_year start_month start_day start_hour start_minute
#>   <chr>     <chr>       <chr>      <chr>       <chr>     <chr>      <chr>       
#> 1 example   "RLBH006"   2019       11          23        14         35          
#> 2 descript… "Location … The year … The month … The day … The hour … The minute …
#> 3 chk       "c(\"\")"   c(2019L, … c(1L, 12L)  c(1L, 31… c(0L, 23L) c(0L, 59L)  
#> 4 pkey      "TRUE"      TRUE       TRUE        TRUE      TRUE       TRUE        
#> 5 join      "location"  NA         NA          NA        NA         NA          
#> # ℹ 14 more variables: fa <chr>, f1 <chr>, f0 <chr>, fu <chr>, ma <chr>,
#> #   m3 <chr>, m2 <chr>, m1 <chr>, m0 <chr>, mu <chr>, ua <chr>, u1 <chr>,
#> #   u0 <chr>, uu <chr>
#> 
#> $census
#> # A tibble: 5 × 6
#>   name        census_year             census_month   census_day census census_cv
#>   <chr>       <chr>                   <chr>          <chr>      <chr>  <chr>    
#> 1 example     2021                    3              31         250    0.05     
#> 2 description Year of census estimate Month of cens… Day of ce… Estim… Coeffici…
#> 3 chk         c(2019L, 2050L)         c(1L, 12L)     c(1L, 31L) c(1L,… c(0, 0.5)
#> 4 pkey        TRUE                    TRUE           TRUE       NA     NA       
#> 5 join        NA                      NA             NA         NA     NA       
#> 
#> $proportion_calf
#> # A tibble: 5 × 6
#>   name        proportion_calf_year     proportion_calf_month proportion_calf_day
#>   <chr>       <chr>                    <chr>                 <chr>              
#> 1 example     2021                     3                     31                 
#> 2 description Year of calf proportion… Month of calf propor… Day of calf propor…
#> 3 chk         c(2019L, 2050L)          c(1L, 12L)            c(1L, 31L)         
#> 4 pkey        TRUE                     TRUE                  TRUE               
#> 5 join        NA                       NA                    NA                 
#> # ℹ 2 more variables: proportion_calf <chr>, proportion_calf_cv <chr>
#> 
```
