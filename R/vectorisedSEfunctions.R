#section2
##' @title Vectorised swephR functions 
##' @description This are the vectorised functions of the 
##' ones that are namend swe_xxx. Each input parameter can be a vector.
##' Make sure that the vector length of each input parameter matches 
##' the rules around data-frames: so any vector length must be an integer 
##' amount of the largest vector length.
##' @rdname Vectorised
##' @export
vec_calc_ut <-
  function(jd_ut,
           ipl,
           iflag = 4) {
    # default Moshier epheemris
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

##' @rdname Vectorised
##' @export
vec_calc <-
  function(jd_et,
           ipl,
           iflag = 4) {
    #default Moshier epheemris
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

#section3
##' @rdname Vectorised
##' @export
vec_get_planet_name <- function(ipl) {
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

#section4
##' @rdname Vectorised
##' @export
vec_sol_eclipse_when_loc <-
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

#section4
##' @rdname Vectorised
##' @export
vec_fixstar2_ut <-
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

##' @rdname Vectorised
##' @export
vec_fixstar2 <-
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

##' @rdname Vectorised
##' @export
vec_fixstar2_mag <-
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

#section6
##' @rdname Vectorised
##' @export
vec_lun_eclipse_when_loc <-
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

##' @rdname Vectorised
##' @export
vec_lun_eclipse_how <-
  function(jd_ut,
           ephe_flag = 4,
           # default Moshier epheemris
           long,
           lat,
           height = 0) {
    functionvector <-
      data.frame(jd_ut, ephe_flag, long, lat, height)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      ResultVector[[i]] <-
        swe_lun_eclipse_how(functionvector$jd_ut[i],
                            functionvector$ephe_flag[i],
                            geopos)
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_lun_eclipse_when <-
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

##' @rdname Vectorised
##' @export
vec_rise_trans_true_hor <-
  function(jd_ut,
           ipl,
           starname = "",
           ephe_flag = 4,
           # default Moshier epheemris
           rsmi,
           long,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           horhgt = 0) {
    functionvector <-
      data.frame(
        jd_ut,
        ipl,
        starname,
        ephe_flag,
        rsmi,
        long,
        lat,
        height,
        atpress,
        attemp,
        horhgt,
        stringsAsFactors = FALSE
      )
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      ResultVector[[i]] <- swe_rise_trans_true_hor(
        functionvector$jd_ut[i],
        functionvector$ipl[i],
        functionvector$starname[i],
        functionvector$ephe_flag[i],
        functionvector$rsmi[i],
        geopos,
        functionvector$atpress[i],
        functionvector$attemp[i],
        functionvector$horhgt[i]
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_pheno_ut <-
  function(jd_ut,
           ipl,
           iflag = 4) {
    #default Moshier epheemris
    functionvector <-
      data.frame(jd_ut, ipl, iflag)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_pheno_ut(functionvector$jd_ut[i],
                                        functionvector$ipl[i],
                                        functionvector$iflag[i])
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_pheno <-
  function(jd_et,
           ipl,
           iflag = 4) {
    #default Moshier epheemris
    functionvector <-
      data.frame(jd_et, ipl, iflag)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_pheno(functionvector$jd_et[i],
                                     functionvector$ipl[i],
                                     functionvector$iflag[i])
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_azalt <-
  function(jd_ut,
           coord_flag,
           long,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           xin1,
           xin2) {
    functionvector <-
      data.frame(jd_ut,
                 coord_flag,
                 long,
                 lat,
                 height,
                 atpress,
                 attemp,
                 xin1,
                 xin2)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      xin <-
        c(functionvector$xin1[i],
          functionvector$xin2[i])
      ResultVector[[i]] <- swe_azalt(
        functionvector$jd_ut[i],
        functionvector$coord_flag[i],
        geopos,
        functionvector$atpress[i],
        functionvector$attemp[i],
        xin
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_azalt_rev <-
  function(jd_ut,
           coord_flag,
           long,
           lat,
           height = 0,
           xin1,
           xin2) {
    functionvector <-
      data.frame(jd_ut,
                 coord_flag,
                 long,
                 lat,
                 height,
                 xin1,
                 xin2)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      xin <-
        c(functionvector$xin1[i],
          functionvector$xin2[i])
      ResultVector[[i]] <- swe_azalt_rev(functionvector$jd_ut[i],
                                         functionvector$coord_flag[i],
                                         geopos,
                                         xin)
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_refrac_extended <-
  function(InAlt,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           lapse_rate = 0.0065,
           calc_flag) {
    functionvector <-
      data.frame(InAlt,
                 height,
                 atpress,
                 attemp,
                 lapse_rate,
                 calc_flag)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_refrac_extended(
        functionvector$InAlt[i],
        functionvector$height[i],
        functionvector$atpress[i],
        functionvector$attemp[i],
        functionvector$lapse_rate[i],
        functionvector$calc_flag[i]
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_heliacal_ut <-
  function(jd_utstart,
           long,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           objectname,
           event_type,
           helflag = 768) {
    functionvector <-
      data.frame(
        jd_utstart,
        long,
        lat,
        height,
        atpress ,
        attemp ,
        athum,
        atvis,
        obsage,
        obssnellen,
        obsbin,
        obsmag,
        obsaper,
        obstrans,
        objectname,
        event_type,
        helflag,
        stringsAsFactors = FALSE
      )
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      datm <-
        c(
          functionvector$atpress[i],
          functionvector$attemp[i],
          functionvector$athum[i],
          functionvector$atvis[i]
        )
      dobs <-
        c(
          functionvector$obsage[i],
          functionvector$obssnellen[i],
          functionvector$obsbin[i],
          functionvector$obsmag[i],
          functionvector$obsaper[i],
          functionvector$obstrans[i]
        )
      ResultVector[[i]] <- swe_heliacal_ut(
        functionvector$jd_utstart[i],
        geopos,
        datm,
        dobs,
        functionvector$objectname[i],
        functionvector$event_type[i],
        functionvector$helflag[i]
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_vis_limit_mag <-
  function(jd_ut,
           long,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           objectname,
           helflag = 768) {
    functionvector <-
      data.frame(
        jd_ut,
        long,
        lat,
        height,
        atpress ,
        attemp ,
        athum,
        atvis,
        obsage,
        obssnellen,
        obsbin,
        obsmag,
        obsaper,
        obstrans,
        objectname,
        helflag,
        stringsAsFactors = FALSE
      )
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      datm <-
        c(
          functionvector$atpress[i],
          functionvector$attemp[i],
          functionvector$athum[i],
          functionvector$atvis[i]
        )
      dobs <-
        c(
          functionvector$obsage[i],
          functionvector$obssnellen[i],
          functionvector$obsbin[i],
          functionvector$obsmag[i],
          functionvector$obsaper[i],
          functionvector$obstrans[i]
        )
      ResultVector[[i]] <- swe_vis_limit_mag(
        functionvector$jd_ut[i],
        geopos,
        datm,
        dobs,
        functionvector$objectname[i],
        functionvector$helflag[i]
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_heliacal_pheno_ut <-
  function(jd_ut,
           long,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           objectname,
           event_type,
           helflag = 768) {
    functionvector <-
      data.frame(
        jd_ut,
        long,
        lat,
        height,
        atpress ,
        attemp ,
        athum,
        atvis,
        obsage,
        obssnellen,
        obsbin,
        obsmag,
        obsaper,
        obstrans,
        objectname,
        event_type,
        helflag,
        stringsAsFactors = FALSE
      )
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      datm <-
        c(
          functionvector$atpress[i],
          functionvector$attemp[i],
          functionvector$athum[i],
          functionvector$atvis[i]
        )
      dobs <-
        c(
          functionvector$obsage[i],
          functionvector$obssnellen[i],
          functionvector$obsbin[i],
          functionvector$obsmag[i],
          functionvector$obsaper[i],
          functionvector$obstrans[i]
        )
      ResultVector[[i]] <- swe_heliacal_pheno_ut(
        functionvector$jd_ut[i],
        geopos,
        datm,
        dobs,
        functionvector$objectname[i],
        functionvector$event_type[i],
        functionvector$helflag[i]
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_topo_arcus_visionis <-
  function(jd_ut,
           long,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           helflag = 768,
           mag,
           AziO,
           AltO,
           AziS,
           AziM,
           AltM) {
    functionvector <-
      data.frame(
        jd_ut,
        long,
        lat,
        height,
        atpress ,
        attemp ,
        athum,
        atvis,
        obsage,
        obssnellen,
        obsbin,
        obsmag,
        obsaper,
        obstrans,
        helflag,
        mag,
        AziO,
        AltO,
        AziS,
        AziM,
        AltM
      )
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      datm <-
        c(
          functionvector$atpress[i],
          functionvector$attemp[i],
          functionvector$athum[i],
          functionvector$atvis[i]
        )
      dobs <-
        c(
          functionvector$obsage[i],
          functionvector$obssnellen[i],
          functionvector$obsbin[i],
          functionvector$obsmag[i],
          functionvector$obsaper[i],
          functionvector$obstrans[i]
        )
      ResultVector[[i]] <- swe_topo_arcus_visionis(
        functionvector$jd_ut[i],
        geopos,
        datm,
        dobs,
        functionvector$helflag[i],
        functionvector$mag[i],
        functionvector$AziO[i],
        functionvector$AltO[i],
        functionvector$AziS[i],
        functionvector$AziM[i],
        functionvector$AltM[i]
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_heliacal_angle <-
  function(jd_ut,
           long,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           helflag = 768,
           mag,
           AziO,
           AziS,
           AziM,
           AltM) {
    functionvector <-
      data.frame(
        jd_ut,
        long,
        lat,
        height,
        atpress ,
        attemp ,
        athum,
        atvis,
        obsage,
        obssnellen,
        obsbin,
        obsmag,
        obsaper,
        obstrans,
        helflag,
        mag,
        AziO,
        AziS,
        AziM,
        AltM
      )
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$long[i],
          functionvector$lat[i],
          functionvector$height[i])
      datm <-
        c(
          functionvector$atpress[i],
          functionvector$attemp[i],
          functionvector$athum[i],
          functionvector$atvis[i]
        )
      dobs <-
        c(
          functionvector$obsage[i],
          functionvector$obssnellen[i],
          functionvector$obsbin[i],
          functionvector$obsmag[i],
          functionvector$obsaper[i],
          functionvector$obstrans[i]
        )
      ResultVector[[i]] <- swe_heliacal_angle(
        functionvector$jd_ut[i],
        geopos,
        datm,
        dobs,
        functionvector$helflag[i],
        functionvector$mag[i],
        functionvector$AziO[i],
        functionvector$AziS[i],
        functionvector$AziM[i],
        functionvector$AltM[i]
      )
    }
    return(ResultVector)
  }

#section 7
##' @rdname Vectorised
##' @export
vec_julday <-
  function(year,
           month,
           day,
           hour = 12,
           #default is midday
           gregflag = 1) {
    #default (proleptic) Gregorian calendar
    functionvector <-
      data.frame(year, month, day, hour, gregflag)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_julday(
        functionvector$year[i],
        functionvector$month[i],
        functionvector$day[i],
        functionvector$hour[i],
        functionvector$gregflag[i]
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_date_conversion <-
  function(year,
           month,
           day,
           hour = 12,
           #default is midday
           cal = "g") {
    #default (proleptic) Gregorian calendar
    functionvector <-
      data.frame(year, month, day, hour, cal,
                 stringsAsFactors = FALSE)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_date_conversion(
        functionvector$year[i],
        functionvector$month[i],
        functionvector$day[i],
        functionvector$hour[i],
        functionvector$cal[i]
      )
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_revjul <-
  function(jd,
           gregflag = 1) {
    #default (proleptic) Gregorian calendar
    functionvector <-
      data.frame(jd, gregflag)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_revjul(functionvector$jd[i],
                                      functionvector$gregflag[i])
    }
    return(ResultVector)
  }

#section8
##' @rdname Vectorised
##' @export
vec_deltat_ex <-
  function(jd_ut,
           ephe_flag = 4) {
    functionvector <-
      data.frame(jd_ut, ephe_flag)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_deltat_ex(functionvector$jd_ut[i],
                                         functionvector$ephe_flag[i])
    }
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_deltat <-
  function(jd_ut) {
    functionvector <-
      data.frame(jd_ut)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_deltat(functionvector$jd_ut[i])
    }
    return(ResultVector)
  }

#section16
##' @rdname Vectorised
##' @export
vec_day_of_week <-
  function(jd) {
    functionvector <-
      data.frame(jd)
    print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_day_of_week(functionvector$jd[i])
    }
    return(ResultVector)
  }
