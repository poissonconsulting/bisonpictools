# Generate seasons data

Generates a table of the dates of different seasons relevant to wood
bison movement patterns: calving, summer/fall, and winter. Start and end
dates of each season are based in the study year 1972-1973.

## Usage

``` r
bpt_seasons()
```

## Value

A tibble.

## Examples

``` r
bpt_seasons()
#> # A tibble: 3 × 3
#>   season      start_dayte         end_dayte          
#>   <chr>       <dttm>              <dttm>             
#> 1 Calving     1972-04-01 00:00:00 1972-06-30 23:59:59
#> 2 Summer/Fall 1972-07-01 00:00:00 1972-11-30 23:59:59
#> 3 Winter      1972-12-01 00:00:00 1973-03-31 23:59:59
```
