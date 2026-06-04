# Predict abundance by class

Predicts abundances of each sex-age class for each study year.

## Usage

``` r
bpt_predict_abundance_class(analysis)
```

## Arguments

- analysis:

  Analysis object from
  [`bpt_analyse()`](https://poissonconsulting.github.io/bisonpictools/reference/bpt_analyse.md).

## Value

A tibble of predicted abundances for each class and year, including the
median posterior value (estimate) and lower and upper 95% credible
intervals.

## Examples

``` r
if (FALSE) { # \dontrun{
bpt_predict_abundance_class(analysis)
} # }
```
