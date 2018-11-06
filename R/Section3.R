M_get_planet_name <- function(ipl) {
  
  functionvector <- data.frame(ipl)
  print(functionvector)
  ResultVector <- c(0)
  for (i in 1:nrow(functionvector))
  {
    ResultVector[i] = swe_get_planet_name(functionvector$ipl[i])
  }
  return(ResultVector)
}

M_sol_eclipse_when_loc <- function(jd_start,ephe_flag, long,lat,height, backward) {
  
  functionvector <- data.frame(jd_start,ephe_flag, long,lat,height, backward)
  print(functionvector)
  ResultVector <- c(0)
  for (i in 1:nrow(functionvector))
  {
    geopos<-c(functionvector$long[i],functionvector$lat[i],functionvector$height[i])
    ResultA <- swe_sol_eclipse_when_loc(functionvector$jd_start[i],
                                               functionvector$ephe_flag[i],
                                               geopos,
                                               functionvector$backward[i])
    print(ResultA)
   a<-0
                                               
                                              
  }
  return(ResultVector)
  
}