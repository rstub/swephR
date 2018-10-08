##' Compute information of star (ET)
##' @return \code{swe_fixstar2} returns a list with named entries \code{return} status flag as integer,
##'         \code{star} updated star name as string, \code{xx} star phenomena as numeric vector, and \code{serr} error message as string.
##' @rdname calculation
##' @export
swe_fixstar2 <- function(star, jd_et, iflag) {
  if (length(jd_et) == 1 && length(star) > 1)
    jd_et = rep_len(jd_et, length(star))
  
  if (length(jd_et) > 1 && length(star) == 1)
    star = rep_len(star, length(jd_et))
  
  fixstar2(star, jd_et, iflag)
}

##' Compute information of star (UT)
##' @return \code{swe_fixstar2_ut} returns a list with named entries \code{return} status flag as integer,
##'         \code{star} updated star name as string, \code{xx} star phenomena as numeric vector, and \code{serr} error message as string.
##' @rdname calculation
##' @export
swe_fixstar2_ut <- function(star, jd_ut, iflag) {
  if (length(jd_ut) == 1 && length(star) > 1)
    jd_ut = rep_len(jd_ut, length(star))
  
  if (length(jd_ut) > 1 && length(star) == 1)
    star = rep_len(star, length(jd_ut))
  
  fixstar2_ut(star, jd_ut, iflag)
}

