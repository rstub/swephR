.onLoad <- function(libname, pkgname) {
    swe_set_ephe_path(file.path(libname, pkgname, "ephemeris"))
}
