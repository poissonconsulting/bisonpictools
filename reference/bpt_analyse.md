# Fit integrated population model

Fits the integrated population model to data. Run first in "debug" mode
to ensure that the model samples. Next, run in "report" mode to sample
the full number of iterations.

## Usage

``` r
bpt_analyse(
  event_data,
  location_data,
  census_data,
  proportion_calf_data,
  nthin = 10L,
  analysis_mode = "report"
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

- nthin:

  Thinning rate, takes default of 10.

- analysis_mode:

  Character string of analysis mode, either "debug", "check", or
  "report".

## Value

An `smb.analysis` object.

## Examples

``` r
if (FALSE) { # \dontrun{
bpt_analyse(
  event_data = event_data,
  location_data = location_data,
  census_data = census_data,
  proportion_calf_data = proportion_calf_data,
  nthin = 1L,
  analysis_mode = "quick"
)
} # }
```
