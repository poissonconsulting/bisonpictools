# Predict fecundity

Predicts the fecundity rate and proportion of reproductive cows.

## Usage

``` r
bpt_predict_fecundity(analysis)
```

## Arguments

- analysis:

  Analysis object from
  [`bpt_analyse()`](https://poissonconsulting.github.io/bisonpictools/reference/bpt_analyse.md).

## Value

A tibble of predicted fecundity rate and proportion of reproductive
cows, including the median posterior value (estimate) and lower and
upper 95% credible intervals.

## Examples

``` r
if (FALSE) { # \dontrun{
bpt_predict_fecundity(analysis)
} # }
```
