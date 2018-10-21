##' @title Section 4: Fixed stars functions
##' @description The following functions are used to calculate positions of fixed stars. 
##' @details swe_fixstar2()
##' 
##' Compute information of star (ET)
##' @param jd_ut  UT Julian day number (day)
##' @param jd_et  ET Julian day number as double (day)
##' @param starname  star name as string ("" for no star)
##' @param iflag flag as interger, many options possible (section 2.3)
##' @return \code{swe_fixstar2} returns a list with named entries \code{return} status flag as integer,
##'         \code{star} updated star name as string, \code{xx} star phenomena as numeric vector, and \code{serr} error message as string.
##' @rdname Section4
##' @export
swe_fixstar2 <- function(starname, jd_et, iflag) {
  if (length(jd_et) == 1 && length(starname) > 1)
    jd_et = rep_len(jd_et, length(starname))
  
  if (length(jd_et) > 1 && length(starname) == 1)
    starname = rep_len(starname, length(jd_et))
  
  fixstar2(starname, jd_et, iflag)
}

##' @details swe_fixstar2_ut()
##' 
##' Compute information of star (UT)
##' @return \code{swe_fixstar2} returns a list with named entries \code{return} status flag as interger,
##'         \code{starname} updated star name as string, \code{xx} star information as numeric vector, and \code{serr} for error message as string.
##' @rdname Section4
##' @export
swe_fixstar2_ut <- function(starname, jd_ut, iflag) {
  if (length(jd_ut) == 1 && length(starname) > 1)
    jd_ut = rep_len(jd_ut, length(starname))
  
  if (length(jd_ut) > 1 && length(starname) == 1)
    starname = rep_len(starname, length(jd_ut))
  
  fixstar2_ut(starname, jd_ut, iflag)
}

