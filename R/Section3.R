get_planet_name <- function(ipl) {
  functionvector <- data.frame(ipl)
  print(functionvector)
  listsize<-nrow(functionvector)
  ResultVector <- vector("list",listsize)
  for (i in 1:listsize)
  {
    ResultVector[[i]] <- swe_get_planet_name(functionvector$ipl[i])
  }
  return(ResultVector)
}

sol_eclipse_when_loc <-
  function(jd_start,
           ephe_flag = 4, # default Moshier epheemris
           long,
           lat,
           height = 0,
           backward = FALSE) {
    functionvector <-
      data.frame(jd_start, ephe_flag, long, lat, height, backward)
    print(functionvector)
    listsize<-nrow(functionvector)
    ResultVector <- vector("list",listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      ResultVector[[i]] <- swe_sol_eclipse_when_loc(
        functionvector$jd_start[i],
        functionvector$ephe_flag[i],
        geopos,
        functionvector$backward[i]
      )
    }
    return(ResultVector)
    
  }
