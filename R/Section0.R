SEtest <- function() {
  swe_set_ephe_path(NULL)
  iflag = SEFLG_SPEED
  while (TRUE)
  {
    #get year
    stopyear <- readline(prompt = "Year (yyyy): ")
    #stop if a period . is entered */
    if (stopyear == ".") {
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
    tjd_ut <- swe_julday(jyear, jmon, jday, jhour, SE_GREG_CAL)
    cat("Julian day number (UT) :", tjd_ut, "(",jyear,",",jmon,",",jday,"; proleptic Gregorian cal.)\n")
    cat("planet :",
        c("longitude", "latitude", "distance", "speed long"),
        "\n")
    cat("===================================================\n")
    # loop over all planets
    for (p in SE_SUN:(SE_CHIRON-1)) {
      # get the name of the planet p
      objectname = swe_get_planet_name(p)
      # calculate for non Earthly objects
      if (objectname != "Earth") {
        # do the coordinate calculation for this planet p
        i = swe_calc_ut(tjd_ut, p, iflag)
        if (i$return < 0) {
          cat("Error :", i$err, "(", objectname, ")\n")
        }
        else
        {
          # print data
          cat (objectname, ":", i$xx[0:4], "\n")
        }
      }
    }
  }
  return
}