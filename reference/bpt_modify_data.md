# Modify data for analysis

Modifies data list prepared by
[`embr::analyse()`](https://rdrr.io/pkg/embr/man/analyse.html) directly
before passing to model.

## Usage

``` r
bpt_modify_data(
  data,
  levels_annual,
  census,
  census_cv,
  census_study_year,
  census_day_of_year,
  proportion_calf,
  proportion_calf_cv,
  proportion_calf_study_year,
  proportion_calf_day_of_year
)
```

## Arguments

- data:

  Data in list form as passed through embr::analyse().

- levels_annual:

  Levels of the annual factor in data.

- census:

  Integer vector of census values.

- census_cv:

  Numeric vector of census coefficients of variation.

- census_study_year:

  Character vector of census study years.

- census_day_of_year:

  Integer vector of census days of year.

- proportion_calf:

  Numeric vector of proportion of calf values.

- proportion_calf_cv:

  Numeric vector of proportion of calf coefficients of variation.

- proportion_calf_study_year:

  Character vector of proportion of calf study years.

- proportion_calf_day_of_year:

  Integer vector of proportion of calf days of year.

## Value

Data in list form with the new data added.

## Examples

``` r
if (FALSE) { # \dontrun{
bpt_modify_data(
  data = list(
    annual = factor(c("2021-2022", "2022-2023"))
  ),
  levels_annual = c("2021-2022", "2022-2023"),
  census = 272L,
  census_cv = 20 / 272L,
  census_study_year = "2021-2022",
  census_day_of_year = 365L,
  proportion_calf = c(0.195, 0.151),
  proportion_calf_cv = c(0.5, 0.5),
  proportion_calf_study_year = c("2021-2022", "2022-2023"),
  proportion_calf_day_of_year = c(365L, 365L)
)
} # }
```
