##' @title Section 2: Computing positions
##' @name Section2
##' @description Computing positions of planets, asteroids, lunar nodes and apogees using Swiss Ephemeris.
##' @seealso Section 2 in \url{http://www.astro.com/swisseph/swephprg.htm}. Remember that array indices start in R at 1, while in C they start at 0!
##' @details
##' \describe{
##'   \item{swe_calc_ut()}{It compute positions using UT.}
##'   \item{swe_calc()}{It compute positions using ET.}
##' }
##' @param jd_ut  UT Julian day number as double (day)
##' @param jd_et  ET Julian day number as double (day)
##' @param ipl  Body/planet as integer (SE$SUN=0, SE$Moon=1,  ... SE$PLUTO=9)
##' @param iflag Computation flag as integer, many options possible (section 2.3.1)
##' @return \code{swe_calc_ut} returns a list with named entries: \code{return} status flag as integer,
##'        \code{xx} information on planet position, and \code{serr} error message as string.
##' @examples
##' data(SE)
##' swe_calc_ut(2458346.82639, SE$MOON, SE$FLG_MOSEPH)
##' swe_calc(2458346.82639, SE$MOON, SE$FLG_MOSEPH)
##' @rdname Section2
##' @export
swe_calc_ut <- function(jd_ut, ipl, iflag) {
  if (length(jd_ut) == 1 && length(ipl) > 1)
    jd_ut = rep_len(jd_ut, length(ipl))

  if (length(jd_ut) > 1 && length(ipl) == 1)
    ipl = rep_len(ipl, length(jd_ut))

  calc_ut(jd_ut, ipl, iflag)
}

##' @return \code{swe_calc} returns a list with named entries: \code{return} status flag as integer,
##'         \code{xx} updated star name as string and \code{serr} error message as string.
##' @rdname Section2
##' @export
swe_calc <- function(jd_et, ipl, iflag) {
  if (length(jd_et) == 1 && length(ipl) > 1)
    jd_et = rep_len(jd_et, length(ipl))

  if (length(jd_et) > 1 && length(ipl) == 1)
    ipl = rep_len(ipl, length(jd_et))

  calc(jd_et, ipl, iflag)
}
