# Parameters for functions

Descriptions of the parameters for functions

## Arguments

- analysis:

  Analysis object from
  [`bpt_analyse()`](https://poissonconsulting.github.io/bisonpictools/reference/bpt_analyse.md).

- event_data:

  Tibble of templated event data.

- location_data:

  Tibble of templated location data.

- census_data:

  Tibble of census data.

- proportion_calf_data:

  Tibble of proportion calf data.

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

- analysis_mode:

  Character string of analysis mode, either "debug", "check", or
  "report".

- nthin:

  Thinning rate, takes default of 10.

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

- prediction:

  One of the following:

  - "abundance-class": plots abundances by class and study year.

  - "abundance-total": plots total herd abundance by study year.

  - "survival": plots survival rates by class and study year (bull rate
    includes M2, M3, MA).

  - "fecundity": plots fecundity rate and proportion of reproductive
    cows.

  - "ratios": plots ratios by study year.
