# Manipulate ratios

Takes output from
[`bpt_manipulate_data_plot()`](https://poissonconsulting.github.io/bisonpictools/reference/bpt_manipulate_data_plot.md)
and calculates ratio of interest for plotting. Ratio of interest is
calculated as numerator:(denominator + numerator) to avoid plotting
infinite values.

## Usage

``` r
bpt_manipulate_ratios(
  data,
  numerator,
  denominator,
  study_years = unique(data$study_year),
  locations = unique(data$location_id)
)
```

## Arguments

- data:

  A tibble of manipulated event, and location data.

- numerator:

  A character vector of sex-age codes to go in the numerator of the
  ratio.

- denominator:

  A character vector of sex-age codes to go in the denominator of the
  ratio.

- study_years:

  A character vector of study years to include in the plot.

- locations:

  A character vector of location_ids to include in the plot.

## Value

The original tibble, with additional columns `numerator`, `denominator`,
and `ratio`.

## Examples

``` r
bpt_manipulate_ratios(
  data = bpt_manipulate_data_plot(
    event_data,
    location_data
  ),
  numerator = "fa",
  denominator = "ma",
  study_years = "2020-2021",
  locations = "LOCID1"
)
#> # A tibble: 1 × 22
#>   location_id groupsize    fa    f1    f0    fu    ma    m3    m2    m1    m0
#>   <fct>           <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
#> 1 LOCID1             14     3     1     2     1     1     0     1     2     1
#> # ℹ 11 more variables: mu <int>, ua <int>, u1 <int>, u0 <int>, uu <int>,
#> #   study_year <fct>, date_time <dttm>, year <fct>, numerator <dbl>,
#> #   denominator <dbl>, ratio <dbl>
```
