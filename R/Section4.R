##' @title Section 4: Fixed stars functions
##' @name Section4
##' @description The following functions are used to calculate positions of fixed stars.
##' @seealso Section 4 in \url{http://www.astro.com/swisseph/swephprg.htm}. Remember that array indices start in R at 1, while in C they start at 0!
##' @details
##' \describe{
##'   \item{swe_fixstar2_mag()}{Calculate visible magnitude (Vmag) of star.}
##'   \item{swe_fixstar2()}{Compute information of star using ET.}
##'   \item{swe_fixstar2_ut()}{Compute information of star using UT}
##' }
##' @param jd_ut  UT Julian day number (day)
##' @param jd_et  ET Julian day number as double (day)
##' @param starname  Star name as string ("" for no star)
##' @param iflag Calculation flag as integer, many options possible (section 2.3)
##' @return \code{swe_fixstar2} returns a list with named entries: \code{return} status flag as integer,
##'         \code{starname} updated star name as string, \code{xx} star phenomena as numeric vector, and \code{serr} error message as string.
##' @examples
##' data(SE)
##' swe_fixstar2_mag("sirius")
##' swe_set_topo(0,50,10)
##' swe_fixstar2("sirius",1234567,SE$FLG_TOPOCTR+SE$FLG_MOSEPH+SE$FLG_EQUATORIAL)
##' swe_fixstar2_ut("sirius",1234567,SE$FLG_TOPOCTR+SE$FLG_MOSEPH+SE$FLG_EQUATORIAL)
##' @rdname Section4
##' @export
swe_fixstar2 <- function(starname, jd_et, iflag) {
  if (length(jd_et) == 1 && length(starname) > 1)
    jd_et = rep_len(jd_et, length(starname))

  if (length(jd_et) > 1 && length(starname) == 1)
    starname = rep_len(starname, length(jd_et))

  fixstar2(starname, jd_et, iflag)
}

##' @return \code{swe_fixstar2_ut} returns a list with named entries: \code{return} status flag as integer,
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
