# Plot predictions

Generates a plot of the specified prediction from the analysis object.

## Usage

``` r
bpt_plot_predictions(analysis, prediction = "abundance-total")
```

## Arguments

- analysis:

  Analysis object from
  [`bpt_analyse()`](https://poissonconsulting.github.io/bisonpictools/reference/bpt_analyse.md).

- prediction:

  One of the following:

  - "abundance-class": plots abundances by class and study year.

  - "abundance-total": plots total herd abundance by study year.

  - "survival": plots survival rates by class and study year (bull rate
    includes M2, M3, MA).

  - "fecundity": plots fecundity rate and proportion of reproductive
    cows.

  - "ratios": plots ratios by study year.

## Value

A `ggplot2` object.

## Examples

``` r
if (FALSE) { # \dontrun{
bpt_plot_predictions(analysis = analysis, prediction = "abundance-class")
bpt_plot_predictions(analysis = analysis, prediction = "abundance-total")
bpt_plot_predictions(analysis = analysis, prediction = "survival")
bpt_plot_predictions(analysis = analysis, prediction = "fecundity")
bpt_plot_predictions(analysis = analysis, prediction = "ratios")
} # }
```
