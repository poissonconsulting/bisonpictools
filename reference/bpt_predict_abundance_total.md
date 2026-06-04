# Predict total abundance

Predicts the total herd abundance for each study year, as the sum of the
predicted abundances for each class.

## Usage

``` r
bpt_predict_abundance_total(analysis)
```

## Arguments

- analysis:

  Analysis object from
  [`bpt_analyse()`](https://poissonconsulting.github.io/bisonpictools/reference/bpt_analyse.md).

## Value

A tibble of total abundances for each study year, including the median
posterior value (estimate) and lower and upper 95% credible intervals.

## Examples

``` r
if (FALSE) { # \dontrun{
bpt_predict_abundance_total(analysis)
} # }
```
