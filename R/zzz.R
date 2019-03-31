.onLoad <- function(libname, pkgname) {
    if(requireNamespace("swephRdata", quietly = TRUE)) {
        swe_set_ephe_path(system.file("ephemeris", package = "swephRdata", mustWork = TRUE))
    } else {
        swe_set_ephe_path(system.file("ephemeris", package = "swephR", mustWork = TRUE))
    }
}

.onUnload <- function (libpath) {
    swe_close()
    library.dynam.unload("swephR", libpath)
}
