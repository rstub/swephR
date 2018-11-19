get_planet_name <- function(ipl) {
  functionvector <- data.frame(ipl)
  print(functionvector)
  listsize <- nrow(functionvector)
  ResultVector <- vector("list", listsize)
  for (i in 1:listsize)
  {
    ResultVector[[i]] <- swe_get_planet_name(functionvector$ipl[i])
  }
  return(ResultVector)
}

sol_eclipse_when_loc <-
  function(jd_start,
           ephe_flag = 4,
           # default Moshier epheemris
           long,
           lat,
           height = 0,
           backward = FALSE) {
    functionvector <-
      data.frame(jd_start, ephe_flag, long, lat, height, backward)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
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

lun_eclipse_when_loc <-
  function(jd_start,
           ephe_flag = 4,
           # default Moshier epheemris
           long,
           lat,
           height = 0,
           backward = FALSE) {
    functionvector <-
      data.frame(jd_start, ephe_flag, long, lat, height, backward)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      ResultVector[[i]] <- swe_lun_eclipse_when_loc(
        functionvector$jd_start[i],
        functionvector$ephe_flag[i],
        geopos,
        functionvector$backward[i]
      )
    }
    return(ResultVector)
    
  }

lun_eclipse_how <-
  function(jd_start,
           ephe_flag = 4,
           # default Moshier epheemris
           long,
           lat,
           height = 0) {
    functionvector <-
      data.frame(jd_start, ephe_flag, long, lat, height)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      ResultVector[[i]] <- swe_lun_eclipse_how(functionvector$jd_start[i],
                                               functionvector$ephe_flag[i],
                                               geopos)
    }
    return(ResultVector)
    
  }

lun_eclipse_when <-
  function(jd_start,
           ephe_flag = 4,
           # default Moshier epheemris
           ifltype,
           backward = FALSE) {
    functionvector <-
      data.frame(jd_start, ephe_flag, ifltype, backward)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_lun_eclipse_when(
        functionvector$jd_start[i],
        functionvector$ephe_flag[i],
        functionvector$ifltype[i],
        functionvector$backward[i]
      )
    }
    return(ResultVector)
    
  }

calc_ut <-
  function(jd_ut,
           ipl,
           iflag = 4 # default Moshier epheemris
           ) {
           functionvector <-
             data.frame(jd_ut, ipl, iflag)
           print(functionvector)
           listsize <- nrow(functionvector)
           ResultVector <- vector("list", listsize)
           for (i in 1:listsize)
           {
             ResultVector[[i]] <- swe_calc_ut(functionvector$jd_ut[i],
                                              functionvector$ipl[i],
                                              functionvector$iflag[i])
           }
           return(ResultVector)
           
           }

calc <-
  function(jd_et,
           ipl,
           iflag = 4 # default Moshier epheemris
           ) {
           functionvector <-
             data.frame(jd_et, ipl, iflag)
           print(functionvector)
           listsize <- nrow(functionvector)
           ResultVector <- vector("list", listsize)
           for (i in 1:listsize)
           {
             ResultVector[[i]] <- swe_calc(functionvector$jd_et[i],
                                           functionvector$ipl[i],
                                           functionvector$iflag[i])
           }
           return(ResultVector)
           
           }

fixstar2_ut <-
  function(starname,
           jd_ut,
           iflag = 4) {
    functionvector <-
      data.frame(starname, jd_ut, iflag, stringsAsFactors = FALSE)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_fixstar2_ut(functionvector$starname[i],
                                           functionvector$jd_ut[i],
                                           functionvector$iflag[i])
    }
    return(ResultVector)
    
  }


fixstar2 <-
  function(starname,
           jd_et,
           iflag = 4) {
    functionvector <-
      data.frame(starname, jd_et, iflag, stringsAsFactors = FALSE)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_fixstar2(functionvector$starname[i],
                                        functionvector$jd_et[i],
                                        functionvector$iflag[i])
    }
    return(ResultVector)
    
  }

fixstar2_mag <-
  function(starname) {
    functionvector <-
      data.frame(starname, stringsAsFactors = FALSE)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_fixstar2_mag(functionvector$starname[i])
    }
    return(ResultVector)
    
  }
