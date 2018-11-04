.onLoad <- function(libname, pkgname) {
    if(requireNamespace("swephRdata", quietly = TRUE)) {
        swe_set_ephe_path(system.file("ephemeris", package = "swephRdata"))
    } else {
        swe_set_ephe_path(system.file("ephemeris", package = "swephR"))
    }
  packageStartupMessage("Welcome to swephR")
}
