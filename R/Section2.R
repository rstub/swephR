##' Compute information of planet (ET)
##' @rdname Section2
##' @export
swe_calc <- function(jd_et, ipl, iflag) {
  if (length(jd_et) == 1 && length(ipl) > 1)
    jd_et = rep_len(jd_et, length(ipl))
  
  if (length(jd_et) > 1 && length(ipl) == 1)
    ipl = rep_len(ipl, length(jd_et))
  
  calc(jd_et, ipl, iflag)
}

##' Compute information of planet (UT)
##' @rdname Section2
##' @export
swe_calc_ut <- function(jd_ut, ipl, iflag) {
  if (length(jd_ut) == 1 && length(ipl) > 1)
    jd_ut = rep_len(jd_ut, length(ipl))
  
  if (length(jd_ut) > 1 && length(ipl) == 1)
    ipl = rep_len(ipl, length(jd_ut))
  
  calc_ut(jd_ut, ipl, iflag)
}

