
<!-- README.md is generated from README.Rmd. Please edit that file -->
blendR
======

The goal of blendR is to provide statistically valid estimators of total (and standard errors) when blending a non-probability sample with a probability sample. The two samples are considered to follow capture-recapture methodology, with the capture sample being the non-probability sample and the recapture sample being the probability sample. This package is based upon research by Liu et al (2017) and the dissertation work of the package author. Additionaal estimators will be released in future versions.

Installation
------------

You can install blendR from github with:

``` r
# install.packages("devtools")
devtools::install_github("williamsbenjamin/blendR")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
## Data from capture-recapture sampling program in 2016 by Texas Parks and Wildlife
## Captains could voluntarily self-report (via a smartphone app) about their catch of Red Snapper fish (non-probability sample) and could be sampled in a dockside intercept sample (probability sample). The self-reports are the capture sample and the dockside intercept is the probability sample

library(tibble)
library(blendR)

## Dataset for boats sampled in the dockside intercept, if their captains also self-reported, that data included as well

red_snapper_sampled
#> # A tibble: 398 x 12
#>       id anglers_ps number_caught_ps stratum   prob sample_weight
#>    <int>      <int>            <int> <chr>    <dbl>         <dbl>
#>  1     1          8               11 weekday 0.184           5.44
#>  2     2          3               12 weekend 0.241           4.15
#>  3     3          3               12 weekend 0.241           4.15
#>  4     4          5               20 weekend 0.241           4.15
#>  5     5          6               24 weekend 0.241           4.15
#>  6     6          8               24 weekend 0.241           4.15
#>  7     7          3                1 weekday 0.0662         15.1 
#>  8     8          4               10 weekday 0.184           5.44
#>  9     9          8               24 weekday 0.184           5.44
#> 10    10          4               16 weekday 0.0662         15.1 
#> # ... with 388 more rows, and 6 more variables: number_caught_np <int>,
#> #   anglers_np <int>, captured_indicator <int>, delta_catch <int>,
#> #   delta_angler <int>, psu <chr>

## Dataset for the self-reported boats

self_reports 
#> # A tibble: 117 x 2
#>    anglers number_kept
#>      <int>       <int>
#>  1       2           8
#>  2       4          16
#>  3       4          16
#>  4       3           4
#>  5       4          16
#>  6       4          16
#>  7       2           7
#>  8       5          20
#>  9       3           6
#> 10       2           8
#> # ... with 107 more rows

s_design <- survey::svydesign(id = ~psu,
                              strat = ~stratum,
                              prob = ~prob,
                              nest = T,
                              data = red_snapper_sampled)

t_p(data = red_snapper_sampled,
    recapture_total = number_caught_ps,
    captured = captured_indicator,
    survey_design = s_design,
    capture_units = nrow(self_reports))
#> $total
#> [1] 41723.39
#> 
#> $se
#> [1] 13098.89
```
