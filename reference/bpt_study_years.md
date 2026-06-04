# Calculate study years

Calculate the unique set of study years beginning on Apr. 1 of each year
of a templated `event_data`, `census_data`, or `proportion_calf_data`
tibble.

## Usage

``` r
bpt_study_years(data)
```

## Arguments

- data:

  A tibble of templated data.

## Value

a character vector of unique study years

## Examples

``` r
bpt_study_years(event_data)
#> [1] "2019-2020" "2020-2021" "2021-2022" "2018-2019"
```
