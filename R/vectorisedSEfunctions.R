# Copyright 2018 Ralf Stubner and Victor Reijs
#
# This file is part of swephR.
#
# swephR is free software: you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# swephR is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with swephR.  If not, see <http://www.gnu.org/licenses/>.


#section2
##' @title Vectorised swephR functions 
##' @description This are the vectorised functions of the 
##' ones that are namend swe_xxx. Each input parameter can be a vector.
##' Make sure that the vector length of each input parameter matches 
##' the rules around data-frames: so the largest vector length must be an integer 
##' multiple of the other vector lengths.
##' @param ipl  Body/planet as integer vector (SE$SUN=0, SE$Moon=1,  ... SE$PLUTO=9)
##' @param iflag Computation flag as integer vector, many options possible (section 2.3)
##' @param jd_ut  UT Julian day number vector (day)
##' @param jd_et  ET Julian day number as double vector (day)
##' @param starname  Star name as string vector ("" for no star)
##' @param calc_flag Calculation flag as integer vector (refraction direction (SE$TRUE_TO_APP=0 or SE$APP_TO_TRUE=1))
##' @param coord_flag Coordinate flag as integer vector (reference system (SE$ECL2HOR=0 or SE$EQU2HOR=1)) 
##' @param atpress Atmospheric pressure as double vector (hPa)
##' @param attemp Atmospheric temperature as double vector (Celsius)
##' @param athum Atmospheric humidity as double vector (\%)
##' @param atvis Atmospheric visibiliy as double vector (km or -)
##' @param obsage Age of observer as double vector (year)
##' @param obssnellen Aquity of observer as double vector (-)
##' @param obsbin Mono-/bi-nocular observation as double vector (-)
##' @param obsmag Magnification as double vector (-)
##' @param obsaper Aperture of optics as double vector (mm)
##' @param obstrans Transmission as double vector (-)
##' @param ephe_flag Ephemeris flag as integer vector (SE$FLG_JPLEPH=1, SE$FLG_SWIEPH=2 or SE$FLG_MOSEPH=4)
##' @param horhgt Horizon apparent altitude as double vector (deg)
##' @param xin1  Position of body as numeric vector (either ecliptical or equatorial coordinates, depending on coord_flag)
##' @param xin2  Position of body as numeric vector (either ecliptical or equatorial coordinates, depending on coord_flag)
##' @param rsmi  Event flag as integer vector (e.g.: SE$CALC_RISE=1, SE$CALC_SET=2,SE$CALC_MTRANSIT=4,SE$CALC_ITRANSIT=8)
##' @param backward backwards search as boolean vector (TRUE)
##' @param ifltype eclipse type as integer vector (e.g.: SE$ECL_CENTRAL=1,SE$ECL_NONCENTRAL=2,SE$ECL_TOTAL=4,SE$ECL_ANNULAR=8,SE$ECL_PARTIAL=16,SE$ECL_ANNULAR_TOTAL=32)
##' @param InAlt  object's apparent/topocentric altitude as double vector (depending on calc_flag) (deg)
##' @param lapse_rate  lapse rate as double vector (K/m)
##' @param jd_utstart  UT Julian day number as double vector (day)
##' @param jd_start  Julian day number as double vector (day)
##' @param objectname  Name of fixed star or planet as string vector
##' @param event_type  Event type as integer vector
##' @param helflag Calculation flag (incl. ephe_flag values) as integer vector
##' @param mag   Object's visible magnitude (Vmag) as double vector (-)
##' @param AziO  Object's azimuth as double vector (deg)
##' @param AltO  Object's altitude as double vecor (deg)
##' @param AziS  Sun's azimuth as double (vector deg)
##' @param AziM  Moon's azimut as double vecor (deg)
##' @param AltM  Moon's altitude as double vector (deg)
##' @param year  Astronomical year as integer vector
##' @param month  Month as integer vector
##' @param day  Day as integer vector
##' @param hour  Hour as double vector
##' @param gregflag  Calendar type as integer vector (SE$JUL_CAL=0 or SE$GREG_CAL=1)
##' @param cal  Calendar type  as char vector ("g"[regorian] or "j"[ulian])
##' @param jd  Julian day number as double vector (day)
##' @param longitude  Geographic longitude as double vector (deg)
##' @param lat  Geographic latitude as double vector (deg)
##' @param height  Height as double vector (m)
##' @rdname Vectorised
##' @export
vec_calc_ut <-
  function(jd_ut,
           ipl,
           iflag = 4) {
    # default Moshier epheemris
    functionvector <-
      data.frame(jd_ut, ipl, iflag)
   #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_calc_ut(functionvector$jd_ut[i],
                                       functionvector$ipl[i],
                                       functionvector$iflag[i])
    }
    class(ResultVector)<-"swephR.object.ephe"
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
#    ##print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_calc(functionvector$jd_et[i],
                                    functionvector$ipl[i],
                                    functionvector$iflag[i])
    }
    class(ResultVector)<-"swephR.object.ephe"
    return(ResultVector)
    
  }

#section3
##' @rdname Vectorised
##' @export
vec_get_planet_name <- function(ipl) {
  functionvector <- data.frame(ipl)
  #print(functionvector)
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
           longitude,
           lat,
           height = 0,
           backward = FALSE) {
    #default is forward search
    functionvector <-
      data.frame(jd_start, ephe_flag, longitude, lat, height, backward)
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
          functionvector$lat[i],
          functionvector$height[i])
      ResultVector[[i]] <- swe_sol_eclipse_when_loc(
        functionvector$jd_start[i],
        functionvector$ephe_flag[i],
        geopos,
        functionvector$backward[i]
      )
    }
    class(ResultVector)<-"swephR.eclipse.loc"
    return(ResultVector)
  }

#section4
##' @rdname Vectorised
##' @export
vec_fixstar2_ut <-
  function(starname,
           jd_ut,
           iflag = 4) {
    # Default Moshier ephemeris
    functionvector <-
      data.frame(starname, jd_ut, iflag, stringsAsFactors = FALSE)
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_fixstar2_ut(functionvector$starname[i],
                                           functionvector$jd_ut[i],
                                           functionvector$iflag[i])
    }
    class(ResultVector)<-"swephR.star.ephe"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_fixstar2 <-
  function(starname,
           jd_et,
           iflag = 4) {
    # Default Moshier ephemeris
    functionvector <-
      data.frame(starname, jd_et, iflag, stringsAsFactors = FALSE)
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_fixstar2(functionvector$starname[i],
                                        functionvector$jd_et[i],
                                        functionvector$iflag[i])
    }
    class(ResultVector)<-"swephR.star.ephe"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_fixstar2_mag <-
  function(starname) {
    functionvector <-
      data.frame(starname, stringsAsFactors = FALSE)
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_fixstar2_mag(functionvector$starname[i])
    }
    class(ResultVector)<-"swephR.star.mag"
    return(ResultVector)
  }

#section6
##' @rdname Vectorised
##' @export
vec_lun_eclipse_when_loc <-
  function(jd_start,
           ephe_flag = 4,
           # default Moshier epheemris
           longitude,
           lat,
           height = 0,
           backward = FALSE) {
    #default is forward search
    functionvector <-
      data.frame(jd_start, ephe_flag, longitude, lat, height, backward)
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
          functionvector$lat[i],
          functionvector$height[i])
      ResultVector[[i]] <- swe_lun_eclipse_when_loc(
        functionvector$jd_start[i],
        functionvector$ephe_flag[i],
        geopos,
        functionvector$backward[i]
      )
    }
    class(ResultVector)<-"swephR.eclipse.loc"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_lun_eclipse_how <-
  function(jd_ut,
           ephe_flag = 4,
           # default Moshier epheemris
           longitude,
           lat,
           height = 0) {
    functionvector <-
      data.frame(jd_ut, ephe_flag, longitude, lat, height)
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
          functionvector$lat[i],
          functionvector$height[i])
      ResultVector[[i]] <-
        swe_lun_eclipse_how(functionvector$jd_ut[i],
                            functionvector$ephe_flag[i],
                            geopos)
    }
    class(ResultVector)<-"swephR.eclipse.how"
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
    #default is forward search
    functionvector <-
      data.frame(jd_start, ephe_flag, ifltype, backward)
    #print(functionvector)
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
    class(ResultVector)<-"swephR.eclipse.when"
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
           longitude,
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
        longitude,
        lat,
        height,
        atpress,
        attemp,
        horhgt,
        stringsAsFactors = FALSE
      )
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
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
    class(ResultVector)<-"swephR.object.event"
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_pheno_ut(functionvector$jd_ut[i],
                                        functionvector$ipl[i],
                                        functionvector$iflag[i])
    }
    class(ResultVector)<-"swephR.object.pheno"
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_pheno(functionvector$jd_et[i],
                                     functionvector$ipl[i],
                                     functionvector$iflag[i])
    }
    class(ResultVector)<-"swephR.object.pheno"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_azalt <-
  function(jd_ut,
           coord_flag,
           longitude,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           xin1,
           xin2) {
    functionvector <-
      data.frame(jd_ut,
                 coord_flag,
                 longitude,
                 lat,
                 height,
                 atpress,
                 attemp,
                 xin1,
                 xin2)
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
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
    class(ResultVector)<-"swephR.coord"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_azalt_rev <-
  function(jd_ut,
           coord_flag,
           longitude,
           lat,
           height = 0,
           xin1,
           xin2) {
    functionvector <-
      data.frame(jd_ut,
                 coord_flag,
                 longitude,
                 lat,
                 height,
                 xin1,
                 xin2)
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
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
    class(ResultVector)<-"swephR.coord"
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
    #print(functionvector)
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
    class(ResultVector)<-"swephR.refract"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_heliacal_ut <-
  function(jd_utstart,
           longitude,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           # Default: average acuity
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           objectname,
           event_type,
           helflag = 260) {
    # Default high precision and Moshier ephemeris
    functionvector <-
      data.frame(
        jd_utstart,
        longitude,
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
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
    class(ResultVector)<-"swephR.heliacal.event"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_vis_limit_mag <-
  function(jd_ut,
           longitude,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           # Default: average acuity
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           objectname,
           helflag = 260) {
    # Default high precision and Moshier ephemeris
    functionvector <-
      data.frame(
        jd_ut,
        longitude,
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
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
    class(ResultVector)<-"swephR.heliacal.mag"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_heliacal_pheno_ut <-
  function(jd_ut,
           longitude,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           # Default: average acuity
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           objectname,
           event_type,
           helflag = 260) {
    # Default high precision and Moshier ephemeris
    functionvector <-
      data.frame(
        jd_ut,
        longitude,
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
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
    class(ResultVector)<-"swephR.heliacal.pheno"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_topo_arcus_visionis <-
  function(jd_ut,
           longitude,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           # Default: average acuity
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           helflag = 260,
           # Default high precision and Moshier ephemeris
           mag,
           AziO,
           AltO,
           AziS,
           AziM,
           AltM) {
    functionvector <-
      data.frame(
        jd_ut,
        longitude,
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
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
    class(ResultVector)<-"swephR.heliacal.av"
    return(ResultVector)
  }

##' @rdname Vectorised
##' @export
vec_heliacal_angle <-
  function(jd_ut,
           longitude,
           lat,
           height = 0,
           atpress = 1013.25,
           attemp = 15,
           athum = 0,
           atvis = 0.2,
           obsage = 36,
           obssnellen = 1.4,
           # Default: average acuity
           obsbin = 1,
           obsmag = 1,
           obsaper = 7,
           obstrans = 0.8,
           helflag = 260,
           # Default high precision and Moshier ephemeris
           mag,
           AziO,
           AziS,
           AziM,
           AltM) {
    functionvector <-
      data.frame(
        jd_ut,
        longitude,
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      geopos <-
        c(functionvector$longitude[i],
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
    class(ResultVector)<-"swephR.heliacal.angle"
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
    #print(functionvector)
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
    #print(functionvector)
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
    class(ResultVector)<-"swephR.jdn"
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_revjul(functionvector$jd[i],
                                      functionvector$gregflag[i])
    }
    class(ResultVector)<-"swephR.calendar"
    return(ResultVector)
  }

#section8
##' @rdname Vectorised
##' @export
vec_deltat_ex <-
  function(jd_ut,
           ephe_flag = 4) {
    # Default Moshier ephemeris
    functionvector <-
      data.frame(jd_ut, ephe_flag)
    #print(functionvector)
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
    #print(functionvector)
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
    #print(functionvector)
    listsize <- nrow(functionvector)
    ResultVector <- vector("list", listsize)
    for (i in 1:listsize)
    {
      ResultVector[[i]] <- swe_day_of_week(functionvector$jd[i])
    }
    return(ResultVector)
  }
