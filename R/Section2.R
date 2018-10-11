##' @title Section 2: Does planetary calculations 
##' @description Does planetary calculations using ephemeris
##' @param jd_ut  UT Julian day number (day)
##' @param jd_et  ET Julian day number as double (day)
##' @param ipl  body/planet as interger (SE_SUN=0, SE_Moon=1,  ... SE_PLUTO=9)
##' @param iflag flag as interger, many options possible (section 2.3)
##' @return \code{swe_calc} returns a list with named entries \code{return} status flag as integer,
##'         \code{xx} updated star name as string and \code{serr} error message as string.
##' @rdname Section2
##' @export
##' Compute information of planet (ET)
swe_calc <- function(jd_et, ipl, iflag) {
  if (length(jd_et) == 1 && length(ipl) > 1)
    jd_et = rep_len(jd_et, length(ipl))
  
  if (length(jd_et) > 1 && length(ipl) == 1)
    ipl = rep_len(ipl, length(jd_et))
  
  calc(jd_et, ipl, iflag)
}

##' Compute information of planet (UT)
##' @return \code{swe_calc_ut} returns a list with named entries \code{return} status flag as integer,
##'        \code{xx} updated planet name as string, and \code{serr} error message as string.
##' @rdname Section2
##' @export
swe_calc_ut <- function(jd_ut, ipl, iflag) {
  if (length(jd_ut) == 1 && length(ipl) > 1)
    jd_ut = rep_len(jd_ut, length(ipl))
  
  if (length(jd_ut) > 1 && length(ipl) == 1)
    ipl = rep_len(ipl, length(jd_ut))
  
  calc_ut(jd_ut, ipl, iflag)
}

