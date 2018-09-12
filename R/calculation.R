##' Compute information of planet (ET)
##' @return \code{swe_calc} returns a list with named entries \code{rc},
##'         \code{xx} updated planet name, and \code{serr} error message.
##' @rdname calculation
##' @export
swe_calc <- function(tjd_et, ipl, iflag) {
  if (length(tjd_et) == 1 && length(ipl) > 1)
    tjd_et = rep_len(tjd_et, length(ipl))
  
  if (length(tjd_et) > 1 && length(ipl) == 1)
    ipl = rep_len(ipl, length(tjd_et))
  
  calc(tjd_et, ipl, iflag)
}

##' Compute information of planet (UT)
##' @return \code{swe_calc_ut} returns a list with named entries \code{rc},
##'         \code{xx} updated star name, and \code{serr} error message.
##' @rdname calculation
##' @export
swe_calc_ut <- function(tjd_ut, ipl, iflag) {
  if (length(tjd_ut) == 1 && length(ipl) > 1)
    tjd_ut = rep_len(tjd_ut, length(ipl))
  
  if (length(tjd_ut) > 1 && length(ipl) == 1)
    ipl = rep_len(ipl, length(tjd_ut))
  
  calc_ut(tjd_ut, ipl, iflag)
}

##' Compute information of star
##' @return \code{swe_fixstar2} returns a list with named entries \code{return},
##'         \code{star} updated star name, \code{xx}, and \code{serr} error message.
##' @rdname calculation
##' @export
swe_fixstar2 <- function(star, tjd_et, iflag) {
  if (length(tjd_et) == 1 && length(star) > 1)
    tjd_et = rep_len(tjd_et, length(star))
  
  if (length(tjd_et) > 1 && length(star) == 1)
    star = rep_len(star, length(tjd_et))
  
  fixstar2(star, tjd_et, iflag)
}

##' Compute information of star
##' @return \code{swe_fixstar2_ut} returns a list with named entries \code{return},
##'         \code{star} updated star name, \code{xx}, and \code{serr} error message.
##' @rdname calculation
##' @export
swe_fixstar2_ut <- function(star, tjd_ut, iflag) {
  if (length(tjd_ut) == 1 && length(star) > 1)
    tjd_ut = rep_len(tjd_ut, length(star))
  
  if (length(tjd_ut) > 1 && length(star) == 1)
    star = rep_len(star, length(tjd_ut))
  
  fixstar2_ut(star, tjd_ut, iflag)
}

