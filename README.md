
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![R build
status](https://github.com/rstub/swephR/workflows/R-CMD-check/badge.svg)](https://github.com/rstub/swephR/actions)
[![Coverage
status](https://codecov.io/gh/rstub/swephR/branch/master/graph/badge.svg)](https://codecov.io/github/rstub/swephR?branch=master)
[![CRAN
status](https://www.r-pkg.org/badges/version/swephR)](https://cran.r-project.org/package=swephR)
[![Downloads](https://cranlogs.r-pkg.org/badges/swephR?color=brightgreen)](https://www.r-pkg.org/pkg/swephR)
[![Dependencies](https://tinyverse.netlify.com/badge/swephR)](https://cran.r-project.org/package=swephR)

# swephR

The goal of swephR is to provide an R interface to the [Swiss
Ephemeris](https://www.astro.com/swisseph/). The Swiss Ephemeris is a
high precision ephemeris based upon the DE431 ephemeris from NASA’s JPL.
It covers the time range 13201 BCE to 17191 CE.

## Installation

You can install the released version of swephR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("swephR")
```

Intermediate releases can also be obtained via
[drat](https://cran.r-project.org/package=drat):

``` r
if (!requireNamespace("drat", quietly = TRUE)) install.packages("drat")
drat::addRepo("rstub")
install.packages("swephR")
```

This package uses the semi-analytic theory by Steve Moshier. For faster
and more accurate calculations, the compressed Swiss Ephemeris data is
available in the `swephRdata` package. To access this data package, run

``` r
install.packages("swephRdata", repos = "https://rstub.github.io/drat/", type = "source")
```

The size of the `swephRdata` package is approximately 115 MB. The user
can also use the original JPL DE431 data.

## Example

To compute the position of celestial body or star with SE (Swiss
Ephemeris), you do the following steps:

``` r
library(swephR)
swe_version()
#> [1] "2.10"
```

For a specific date, compute the Julian day number (in below example:
J2000.0, 1 January 2000 at 12:00 UT):

``` r
year <- 2000
month <- 1
day <- 1
hour <- 12
jdut <- swe_julday(year, month, day, hour, SE$GREG_CAL)
jdut
#> [1] 2451545
```

Compute (using Moshier ephemeris) the positions (longitude, latitude,
distance, longitude speed and latitude speed) of a planet or other
celestial bodies (in below example: the Sun):

``` r
ipl <- SE$SUN
iflag <- SE$FLG_MOSEPH + SE$FLG_SPEED
result <- swe_calc_ut(jdut, ipl, iflag)
result
#> $return
#> [1] 260
#> 
#> $xx
#> [1]  2.803689e+02  2.323265e-04  9.833276e-01  1.019432e+00 -8.922802e-07
#> [6] -7.339410e-06
#> 
#> $serr
#> [1] ""
```

or a fixed star (in below example: Sirius):

``` r
starname = "sirius"
result <- swe_fixstar2_ut(starname, jdut, iflag)
result
#> $return
#> [1] 260
#> 
#> $starname
#> [1] "Sirius,alCMa"
#> 
#> $xx
#> [1]  1.040853e+02 -3.960507e+01  5.439322e+05  4.643164e-05 -7.119376e-05
#> [6] -4.130539e-03
#> 
#> $serr
#> [1] ""
```

The current R interface is modeled after the C interface. It is
therefore often helpful to consult the [general
documentation](https://www.astro.com/swisseph/swisseph.htm) and
[programmer’s
documentation](https://www.astro.com/swisseph/swephprg.htm) for the
Swiss Ephemeris.

## Feedback

All feedback (bug reports, security issues, feature requests, …) should
be provided as [issues](https://github.com/rstub/swephR/issues).
