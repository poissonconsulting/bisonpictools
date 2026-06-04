# Prepare location distance matrix for analysis

Calculates the distances (in km) between every location in the
location_data table.

## Usage

``` r
bpt_location_matrix(location_data)
```

## Arguments

- location_data:

  Tibble of templated location data.

## Value

A matrix of distances between locations in kilometers.

## Examples

``` r
bpt_location_matrix(location_data)
#>          LOCID1    LOCID2    LOCID3   LOCID4
#> LOCID1 0.000000 2.9474171 3.6472058 4.812860
#> LOCID2 2.947417 0.0000000 0.7005636 1.904862
#> LOCID3 3.647206 0.7005636 0.0000000 1.257170
#> LOCID4 4.812860 1.9048621 1.2571699 0.000000
```
