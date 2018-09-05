library(testthat)
library(swephR)

## inhibit overloading of ephemeris provided by
## swephR and swephRdata
Sys.setenv(SE_EPHE_PATH = "")
test_check("swephR")
