## http://www.astro.com/swisseph/swephprg.htm?lang=g#_Toc505244839
## planet numbers for the ipl parameter in swe_calc()

bodies <- vector(mode = "list")
bodies$ECL_NUT <- -1L
bodies$SUN <- 0L
bodies$MOON <- 1L
bodies$MERCURY <- 2L
bodies$VENUS <- 3L
bodies$MARS <- 4L
bodies$JUPITER <- 5L
bodies$SATURN <- 6L
bodies$URANUS <- 7L
bodies$NEPTUNE <- 8L
bodies$PLUTO <- 9L
bodies$MEAN_NODE <- 10L
bodies$TRUE_NODE <- 11L
bodies$MEAN_APOG <- 12L
bodies$OSCU_APOG <- 13L
bodies$EARTH <- 14L
bodies$CHIRON <- 15L
bodies$PHOLUS <- 16L
bodies$CERES <- 17L
bodies$PALLAS <- 18L
bodies$JUNO <- 19L
bodies$VESTA <- 20L
bodies$INTP_APOG <- 21L
bodies$INTP_PERG <- 22L

## Hamburger or Uranian "planets"

bodies$CUPIDO   <- 40L
bodies$HADES    <- 41L
bodies$ZEUS     <- 42L
bodies$KRONOS   <- 43L
bodies$APOLLON  <- 44L
bodies$ADMETOS  <- 45L
bodies$VULKANUS <- 46L
bodies$POSEIDON <- 47L

## other fictitious bodies */

bodies$ISIS              <- 48L
bodies$NIBIRU            <- 49L
bodies$HARRINGTON        <- 50L
bodies$NEPTUNE_LEVERRIER <- 51L
bodies$NEPTUNE_ADAMS     <- 52L
bodies$PLUTO_LOWELL      <- 53L
bodies$PLUTO_PICKERING   <- 54L

usethis::use_data(bodies, overwrite = TRUE)

## http://www.astro.com/swisseph/swephprg.htm?lang=g#_Toc505244840
## flags

flags <- vector(mode = "list")
flags$JPLEPH <- 1L                   # use JPL ephemeris
flags$SWIEPH <- 2L                   # use SWISSEPH ephemeris, default
flags$MOSEPH <- 4L                   # use Moshier ephemeris

flags$HELCTR  <- 8L                  # return heliocentric position
flags$TRUEPOS <- 16L                 # return true positions, not apparent
flags$J2000   <- 32L                 # no precession, i.e. give J2000 equinox
flags$NONUT   <- 64L                 # no nutation, i.e. mean equinox of date
flags$SPEED3  <- 128L                # speed from 3 positions (do not use it, flags$SPEED is
                                                                     # faster and preciser.)
flags$SPEED   <- 256L                # high precision speed (analyt. comp.)
flags$NOGDEFL <- 512L                # turn off gravitational deflection
flags$NOABERR <- 1024L               # turn off 'annual' aberration of light
flags$ASTROMETRIC <- flags$NOABERR + flags$NOGDEFL # astrometric positions

flags$EQUATORIAL <- 2048L             # equatorial positions are wanted
flags$XYZ        <- 4096L             # cartesian, not polar, coordinates
flags$RADIANS    <- 8192L             # coordinates in radians, not degrees
flags$BARYCTR    <- 16384L            # barycentric positions
flags$TOPOCTR    <- 32L * 1024L       # topocentric positions
flags$SIDEREAL   <- 64L * 1024L       # sidereal positions
flags$ICRS       <- 128L * 1024L      # ICRS (DE406 reference frame)
flags$DPSIDEPS_1980 <- 256L * 1024    # reproduce JPL Horizons 1962 - today to 0.002 arcsec. */
flags$JPLHOR        <- flags$DPSIDEPS_1980
flags$JPLHOR_APPROX <- 512L * 1024    # approximate JPL Horizons 1962 - today

usethis::use_data(flags, overwrite = TRUE)
