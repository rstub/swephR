M_get_planet_name <- function(ipl) {
  functionvector <- data.frame(ipl)
  print(functionvector)
  ResultVector <- c(0)
  for (i in 1:nrow(functionvector))
  {
    ResultVector[[i]] <- swe_get_planet_name(functionvector$ipl[i])
  }
  return(ResultVector)
}

M_sol_eclipse_when_loc <-
  function(jd_start,
           ephe_flag,
           long,
           lat,
           height,
           backward) {
    functionvector <-
      data.frame(jd_start, ephe_flag, long, lat, height, backward)
    print(functionvector)
    ResultVector <- vector("list",nrow(functionvector))
    for (i in 1:nrow(functionvector))
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

#trialing how to get the function behaving with variables that are itself alreday vectors
P_sol_eclipse_when_loc <-
  function(jd_start,
           ephe_flag,
           geopos,
           backward) {
    functionvector <-
      data.frame(jd_start, ephe_flag, geopos, backward)
    print(functionvector)
    ResultVector <- NULL
    for (i in 1:nrow(functionvector))
    {
      ResultVector[[i]] <- swe_sol_eclipse_when_loc(
        functionvector$jd_start[i],
        functionvector$ephe_flag[i],
        functionvector$geopos[i],
        functionvector$backward[i]
      )
    }
    return(ResultVector)
    
  }