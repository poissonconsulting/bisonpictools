# Manipulate data for plot

Checks that data is in the correct format and manipulates it for
plotting.

## Usage

``` r
bpt_manipulate_data_plot(event_data, location_data)
```

## Arguments

- event_data:

  Tibble of templated event data.

- location_data:

  Tibble of templated location data.

## Value

A tibble of data prepared for plotting.

## Examples

``` r
bpt_manipulate_data_plot(
  event_data,
  location_data
)
#> # A tibble: 12 × 19
#>    location_id groupsize    fa    f1    f0    fu    ma    m3    m2    m1    m0
#>    <fct>           <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
#>  1 LOCID1             11     2     1     0     1     1     2     1     0     2
#>  2 LOCID1             14     3     1     2     1     1     0     1     2     1
#>  3 LOCID1              2     1     0     0     0     0     0     0     0     1
#>  4 LOCID2             18     2     3     1     1     1     0     2     3     3
#>  5 LOCID2             27    10     1     4     1     0     2     2     4     0
#>  6 LOCID2             13     1     2     3     0     0     0     1     2     2
#>  7 LOCID3              9     2     1     0     1     1     1     0     0     2
#>  8 LOCID3             18     3     0     2     0     2     0     2     2     5
#>  9 LOCID3              4     1     0     1     0     0     0     0     0     0
#> 10 LOCID4             18     8     2     2     0     1     0     0     1     0
#> 11 LOCID4             25    10     2     4     1     2     0     2     2     1
#> 12 LOCID4             19     5     1     2     0     0     1     1     3     2
#> # ℹ 8 more variables: mu <int>, ua <int>, u1 <int>, u0 <int>, uu <int>,
#> #   study_year <fct>, date_time <dttm>, year <fct>
```
