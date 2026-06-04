# Predict ratios

Predicts the following ratios for each study year: M0:F0, M1:F1,
Calf:FA, Yearling:FA, M2:FA, M3:FA, and MA:FA.

## Usage

``` r
bpt_predict_ratios(analysis)
```

## Arguments

- analysis:

  Analysis object from
  [`bpt_analyse()`](https://poissonconsulting.github.io/bisonpictools/reference/bpt_analyse.md).

## Value

A tibble of predicted ratios for each study year, including the median
posterior value (estimate) and lower and upper 95% credible intervals.

## Examples

``` r
if (FALSE) { # \dontrun{
bpt_predict_ratios(analysis)
} # }
```
