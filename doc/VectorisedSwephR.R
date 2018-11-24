## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(swephR)
data(SE)

## ---- eval = FALSE-------------------------------------------------------
#  swe_set_ephe_path("C:\\sweph\\ephe")

## ------------------------------------------------------------------------
year1 <- 2000
year2 <- 0
month <- 1
day <- 1
hour <- 12
jdut <- vec_julday(c(year1,year2), month, day, hour, SE$GREG_CAL)
jdut

## ------------------------------------------------------------------------
ipl <- SE$SUN
iflag <- SE$FLG_MOSEPH + SE$FLG_SPEED
result <- vec_calc_ut(c(jdut[[1]],jdut[[2]]), ipl, iflag)
result

## ------------------------------------------------------------------------
starname = "sirius"
result <- vec_fixstar2_ut(starname, c(jdut[[1]],jdut[[2]]), iflag)
result

## ------------------------------------------------------------------------
options(digits=15)
result <- vec_heliacal_ut(c(jdut[[1]],jdut[[2]]),0,50,10,1013.25,15,50,0.25,25,1,1,1,5,0.8,starname,
  SE$HELIACAL_RISING,SE$HELFLAG_HIGH_PRECISION+SE$FLG_MOSEPH)
result

## ------------------------------------------------------------------------
swe_close()

