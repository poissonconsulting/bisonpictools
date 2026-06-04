# Prepare data for analysis

Checks that data is in the correct format and manipulates it for
analysis.

## Usage

``` r
bpt_manipulate_data_analysis(
  event_data,
  location_data,
  census_data,
  proportion_calf_data
)
```

## Arguments

- event_data:

  Tibble of templated event data.

- location_data:

  Tibble of templated location data.

- census_data:

  Tibble of census data.

- proportion_calf_data:

  Tibble of proportion calf data.

## Value

A list of manipulated data ready for analysis.

## Examples

``` r
bpt_manipulate_data_analysis(
  event_data = event_data,
  location_data = location_data,
  census_data = census_data,
  proportion_calf_data = proportion_calf_data
)
#> $data
#> # A tibble: 11 × 25
#>       f0    f1    m2    m3    ma    fa    m0    m1    u0    u1    ua  calf
#>    <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
#>  1     0     1     1     2     1     2     2     0     1     0     0     3
#>  2     2     1     1     0     1     3     1     2     0     0     1     3
#>  3     0     0     0     0     0     1     1     0     0     0     0     1
#>  4     1     3     2     0     1     2     3     3     1     1     0     5
#>  5     4     1     2     2     0    10     0     4     0     1     0     4
#>  6     0     1     0     1     1     2     2     0     0     1     0     2
#>  7     2     0     2     0     2     3     5     2     1     0     0     8
#>  8     1     0     0     0     0     1     0     0     0     1     0     1
#>  9     2     2     0     0     1     8     0     1     1     1     1     3
#> 10     4     2     2     0     2    10     1     2     0     0     0     5
#> 11     2     1     1     1     0     5     2     3     1     1     1     5
#> # ℹ 13 more variables: yearling <int>, adult <int>, groupsize_total <int>,
#> #   annual <fct>, week <int>, weekfac <fct>, season <fct>, doy <int>,
#> #   doy_fac <fct>, location <fct>, location_weekfac <fct>, season_annual <fct>,
#> #   id <fct>
#> 
#> $census_data
#> # A tibble: 2 × 4
#>   census census_cv census_study_year census_doy
#>    <int>     <dbl> <chr>                  <int>
#> 1    250      0.05 2020-2021                365
#> 2    275      0.06 2021-2022                365
#> 
#> $prop_calf_data
#> # A tibble: 2 × 4
#>   prop_calf prop_calf_cv prop_calf_study_year prop_calf_doy
#>       <dbl>        <dbl> <chr>                        <int>
#> 1      0.2          0.05 2020-2021                      365
#> 2      0.15         0.09 2021-2022                      365
#> 
```
