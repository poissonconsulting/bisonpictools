# Predict survival

Predicts the survival rates for each class for each study year. Bull
survival corresponds to the M2, M3, and MA classes.

## Usage

``` r
bpt_predict_survival(analysis)
```

## Arguments

- analysis:

  Analysis object from
  [`bpt_analyse()`](https://poissonconsulting.github.io/bisonpictools/reference/bpt_analyse.md).

## Value

A tibble of predicted survival rates for each study year, including the
median posterior value (estimate) and lower and upper 95% credible
intervals.

## Examples

``` r
if (FALSE) { # \dontrun{
bpt_predict_survival(analysis)
} # }
```
