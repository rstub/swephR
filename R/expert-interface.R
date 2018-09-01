##' Compute information of planet
##' @return \code{swe_calc} returns a list with named entries \code{rc},
##'         \code{xx} updated star name, and \code{serr} error message.
##' @rdname expert-interface
##' @export
swe_calc <- function(tjd_et, ipl, iflag) {
    if (length(tjd_et) == 1 && length(ipl) > 1)
        tjd_et = rep_len(tjd_et, length(ipl))

    if (length(tjd_et) > 1 && length(ipl) == 1)
        ipl = rep_len(ipl, length(tjd_et))

    calc(tjd_et, ipl, iflag)
}
