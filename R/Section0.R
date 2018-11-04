##' @title Section 0: The programming steps to get planet position
##' @description A miniature sample program to calcuate the planet's positions. Teh input is year, month, day.
##' @seealso \url{http://www.astro.com/swisseph/swephprg.htm#_Toc505244830}
##' @details 
##' \describe{
##'   \item{SEtest()}{Calculate the planets' positions.} 
##'  }
##' @examples
##' \dontrun{
##' SEtest()
##' }
##' @rdname Section0
##' @export

SEtest <- function() {
  swe_set_ephe_path(NULL)
  SE<-SEConstants()
  iflag = SE$FLG_SPEED
  while (TRUE)
  {
    #get year
    stopyear <- readline(prompt = "Year (yyyy) or '.' to end: ")
    #stop if a period . is entered */
    if (stopyear == ".") {
      # close SE off
      swe_close()
      return(-1)
    }
    jyear <- as.integer(stopyear)
    #get month
    jmon <- as.integer(readline(prompt = "Month (mm): "))
    #get day
    jday <- as.integer(readline(prompt = "Day (dd): "))
    #get time
    #    jhour <- as.integer(readline(prompt = "Hour (1 to 24): "))
    jhour <- 12
    #determine julian day number (at 12:00 GMT)
    tjd_ut <- swe_julday(jyear, jmon, jday, jhour, SE$GREG_CAL)
    cat("Julian day number (UT) :", tjd_ut, "(",jyear,",",jmon,",",jday,"; proleptic Gregorian cal.)\n")
    cat("planet :",
        c("longitude", "latitude", "distance", "long. speed", "lat. speed"),
        "\n")
    cat("===========================================================\n")
    # loop over all planets
    for (p in SE$SUN:SE$OSCU_APOG) {
      # get the name of the planet p
      objectname = swe_get_planet_name(p)
        # do the coordinate calculation for this planet p
        i = swe_calc_ut(tjd_ut, p, iflag)
        if (i$return < 0) {
          cat("Error :", i$err, "(", objectname, ")\n")
        }
        else
        {
          # print data
          cat (objectname, ":", i$xx[0:5], "\n")
        }
    
    }
  }
  return
}
