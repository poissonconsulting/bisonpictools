
# bisonpictools

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/poissonconsulting/bisonpictools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/bisonpictools/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/poissonconsulting/bisonpictools/graph/badge.svg?token=znqSXiltZo)](https://codecov.io/gh/poissonconsulting/bisonpictools)
<!-- badges: end -->

The goal of bisonpictools is to facilitate the visualization and
analysis of camera trap data from the Ronald Wood Bison herd.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/bisonpictools")
```

## Data Visualization

The ratio plotted by `bpt_plot_ratios` is
`numerator:(denominator:numerator)`.

For example, the adult cow:(bull + cow) ratio plotted over all years and
locations:

``` r
library(bisonpictools)
bpt_plot_ratios(
  bpt_event_data, 
  bpt_location_data, 
  numerator = "fa",
  denominator = "ma"
)
```

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

It is also possible to subset the data to include one or more camera
trap locations and/or study years:

``` r
bpt_plot_ratios(
  bpt_event_data, 
  bpt_location_data, 
  numerator = "fa",
  denominator = "ma",
  study_years = "2019-2020",
  locations = c("LOCID1", "LOCID2")
)
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Several age/sex classes can be combined to plot ratios of interest. For
example, this plots the calf:(yearling + calf) ratio.

``` r
bpt_plot_ratios(
  bpt_event_data, 
  bpt_location_data, 
  numerator = c("f0", "m0"),
  denominator = c("f1", "m1")
)
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Data Analysis
