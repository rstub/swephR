  [![Travis build status](https://travis-ci.org/rstub/swephR.svg?branch=master)](https://travis-ci.org/rstub/swephR)
  [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/rstub/swephR?branch=master&svg=true)](https://ci.appveyor.com/project/rstub/swephR)
  [![Coverage status](https://codecov.io/gh/rstub/swephR/branch/master/graph/badge.svg)](https://codecov.io/github/rstub/swephR?branch=master)

# swephR
High Precision Swiss Ephemeris

# Installation

At the moment `swephR` is not on CRAN, but you can install the current version via [drat](https://cran.r-project.org/package=drat):

``` r
if (!requireNamespace("drat", quietly = TRUE)) install.packages("drat")
drat::addRepo("rstub")
install.packages("swephR")
```
