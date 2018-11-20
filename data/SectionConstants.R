# ************************************************************
#   $Header: /home/dieter/sweph/RCS/swephexp.h,v 1.75 2009/04/08 07:19:08 dieter Exp $
#   SWISSEPH: exported definitions and constants
#
# This file represents the standard application interface (API)
# to the Swiss Ephemeris.
#
# A C programmer needs only to include this file, and link his code
# with the SwissEph library.
#
# The function calls are documented in the Programmer's documentation,
# which is online in HTML format.
#
# Structure of this file:
# Public API definitions
# Internal developer's definitions
# Public API functions.
#
# Authors: Dieter Koch and Alois Treindl, Astrodienst Zurich
#
# ************************************************************/
#   /* Copyright (C) 1997 - 2008 Astrodienst AG, Switzerland.  All rights reserved.
#
# License conditions
# ------------------
#
#   This file is part of Swiss Ephemeris.
#
# Swiss Ephemeris is distributed with NO WARRANTY OF ANY KIND.  No author
# or distributor accepts any responsibility for the consequences of using it,
# or for whether it serves any particular purpose or works at all, unless he
# or she says so in writing.
#
# Swiss Ephemeris is made available by its authors under a dual licensing
# system. The software developer, who uses any part of Swiss Ephemeris
# in his or her software, must choose between one of the two license models,
# which are
# a) GNU public license version 2 or later
# b) Swiss Ephemeris Professional License
#
# The choice must be made before the software developer distributes software
# containing parts of Swiss Ephemeris to others, and before any public
# service using the developed software is activated.
#
# If the developer choses the GNU GPL software license, he or she must fulfill
# the conditions of that license, which includes the obligation to place his
# or her whole software project under the GNU GPL or a compatible license.
# See http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
#
# If the developer choses the Swiss Ephemeris Professional license,
# he must follow the instructions as found in http://www.astro.com/swisseph/
#   and purchase the Swiss Ephemeris Professional Edition from Astrodienst
# and sign the corresponding license contract.
#
# The License grants you the right to use, copy, modify and redistribute
# Swiss Ephemeris, but only under certain conditions described in the License.
# Among other things, the License requires that the copyright notices and
# this notice be preserved on all copies.
#
# Authors of the Swiss Ephemeris: Dieter Koch and Alois Treindl
#
# The authors of Swiss Ephemeris have no control or influence over any of
# the derived works, i.e. over software or services created by other
# programmers which use Swiss Ephemeris functions.
#
# The names of the authors or of the copyright holder (Astrodienst) must not
# be used for promoting any software, product or service which uses or contains
# the Swiss Ephemeris. This copyright notice is the ONLY place where the
# names of the authors can legally appear, except in cases where they have
# given special permission in writing.
#
# The trademarks 'Swiss Ephemeris' and 'Swiss Ephemeris inside' may be used
# for promoting such software, products or services.
# */
#
#   /***********************************************************
#   * definitions for use also by non-C programmers
# ***********************************************************/

##' @title Initialising Constants: Initialising constants used for the SE function calls.
##' @description The constants defined in SE are in R defined as a list.
##' If the function return is stored in the variable SE than for instance SE_MOON becomes SE$MOON
##' and SEFLG_JPLEPH becomes SE$FLG_JPLEPH.
##' @seealso \url{http://www.astro.com/swisseph/swephprg.htm}
##' @details
##' \describe{
##'   \item{SEConstants()}{Initialise SE constants in R.}
##'  }
##' @return \code{SEConstants} returns a list with named entries: the constants in SE
##' @examples
##' SEConstants()
##' @rdname SectionConstants
##' @export


SEConstants <- function() {
  SE <- c()
  # /* values for gregflag in swe_julday() and swe_revjul() */
  SE$JUL_CAL <-	0
  SE$GREG_CAL	<- 1
  
  #   /*
  #   * planet numbers for the ipl parameter in swe_calc()
  # */
  SE$ECL_NUT     <- -1
  SE$SUN       <-   0
  SE$MOON       <-  1
  SE$MERCURY  <-    2
  SE$VENUS    <-    3
  SE$MARS     <-    4
  SE$JUPITER  <-    5
  SE$SATURN   <-    6
  SE$URANUS   <-    7
  SE$NEPTUNE  <-    8
  SE$PLUTO      <-  9
  SE$MEAN_NODE  <-  10
  SE$TRUE_NODE  <-  11
  SE$MEAN_APOG  <-  12
  SE$OSCU_APOG  <-  13
  SE$EARTH      <-  14
  SE$CHIRON     <-  15
  SE$PHOLUS     <-  16
  SE$CERES      <-  17
  SE$PALLAS     <-  18
  SE$JUNO       <-  19
  SE$VESTA      <-  20
  SE$INTP_APOG <-    21
  SE$INTP_PERG  <-  22
  SE$NPLANETS   <-  23
  SE$AST_OFFSET <-  10000
  SE$VARUNA   <- SE$AST_OFFSET + 20000
  SE$FICT_OFFSET  <-	40
  SE$FICT_OFFSET_1 <-  	39
  SE$FICT_MAX  	  <-     999
  SE$NFICT_ELEM     <-      15
  SE$COMET_OFFSET <- 1000
  
  # /* Hamburger or Uranian "planets" */
  SE$CUPIDO      <- 	40
  SE$HADES      <-  	41
  SE$ZEUS        <- 	42
  SE$KRONOS     <-  	43
  SE$APOLLON    <-  	44
  SE$ADMETOS    <-  	45
  SE$VULKANUS   <-  	46
  SE$POSEIDON   <-  	47
  
  # /* other fictitious bodies */
  SE$ISIS      <-   	48
  SE$NIBIRU     <-  	49
  SE$HARRINGTON   <-        50
  SE$NEPTUNE_LEVERRIER <-    51
  SE$NEPTUNE_ADAMS    <-    52
  SE$PLUTO_LOWELL     <-    53
  SE$PLUTO_PICKERING  <-    54
  SE$VULCAN      	<-	55
  SE$WHITE_MOON  	<-	56
  SE$PROSERPINA  	<-	57
  SE$WALDEMATH  	<-	58
  
  # for swe_house
  SE$ASC		<-	0
  SE$MC	<-		1
  SE$ARMC	<-		2
  SE$VERTEX	<-	3
  SE$EQUASC  	<-	4	#/* "equatorial ascendant" */
  SE$COASC1	<-	5	#/* "co-ascendant" (W. Koch) */
  SE$COASC2	<-	6	#/* "co-ascendant" (M. Munkasey) */
  SE$POLASC	<-	7	#/* "polar ascendant" (M. Munkasey) */
  SE$NASCMC	<-	8
  
  # /*
  #   * flag bits for parameter iflag in function swe_calc()
  # * The flag bits are defined in such a way that iflag = 0 delivers what one
  # * usually wants:
  #   *    - the default ephemeris (SWISS EPHEMERIS) is used,
  # *    - apparent geocentric positions referring to the true equinox of date
  # *      are returned.
  # * If not only coordinates, but also speed values are required, use
  # * flag = SE$FLG_SPEED.
  # *
  #   * The 'L' behind the number indicates that 32-bit integers (Long) are used.
  # */
  SE$FLG_JPLEPH   <- 1       #/* use JPL ephemeris */
  SE$FLG_SWIEPH  <-  2       #/* use SWISSEPH ephemeris */
  SE$FLG_MOSEPH  <-  4       #/* use Moshier ephemeris */
  
  SE$FLG_HELCTR <-	8      #/* heliocentric position */
  SE$FLG_TRUEPOS <-
    16     #/* true/geometric position, not apparent position */
  SE$FLG_J2000	<- 32     #/* no precession, i.e. give J2000 equinox */
  SE$FLG_NONUT <-
    64     #/* no nutation, i.e. mean equinox of date */
  SE$FLG_SPEED	<- 256    #/* high precision speed  */
  SE$FLG_NOGDEFL <-	512   # /* turn off gravitational deflection */
  SE$FLG_NOABERR	<-
    1024   #/* turn off 'annual' aberration of light */
  SE$FLG_ASTROMETRIC <-
    (SE$FLG_NOABERR + SE$FLG_NOGDEFL) #/* astrometric position,
  #   * i.e. with light-time, but without aberration and
  # * light deflection */
  SE$FLG_EQUATORIAL <-
    (2 * 1024)    #/* equatorial positions are wanted */
  SE$FLG_XYZ <- (4 * 1024)     #/* cartesian, not polar, coordinates */
  SE$FLG_RADIANS <-
    (8 * 1024)  #   /* coordinates in radians, not degrees */
  SE$FLG_BARYCTR	<- (16 * 1024)  #  /* barycentric position */
  SE$FLG_TOPOCTR	<- (32 * 1024)   # /* topocentric position */
  SE$FLG_ORBEL_AA <-
    SE$FLG_TOPOCTR #/* used for Astronomical Almanac mode in
  # * calculation of Kepler elipses */
  SE$FLG_SIDEREAL <-	(64 * 1024)    #/* sidereal position */
  SE$FLG_ICRS <-	(128 * 1024)   #/* ICRS (DE406 reference frame) */
  SE$FLG_DPSIDEPS_1980	<- (256 * 1024) #/* reproduce JPL Horizons
  # * 1962 - today to 0.002 arcsec. */
  SE$FLG_JPLHOR <-	SE$FLG_DPSIDEPS_1980
  SE$FLG_JPLHOR_APPROX	<-
    (512 * 1024)   #/* approximate JPL Horizons 1962 - today */
  
  #  /* sidereal modes (ayanamsas) in swe_set_sid_mode() */
  SE$SIDM_FAGAN_BRADLEY  <-  0
  SE$SIDM_LAHIRI        <-   1
  SE$SIDM_DELUCE    <-       2
  SE$SIDM_RAMAN       <-     3
  SE$SIDM_USHASHASHI    <-   4
  SE$SIDM_KRISHNAMURTI  <-   5
  SE$SIDM_DJWHAL_KHUL <-     6
  SE$SIDM_YUKTESHWAR    <-   7
  SE$SIDM_JN_BHASIN   <-     8
  SE$SIDM_BABYL_KUGLER1 <-   9
  SE$SIDM_BABYL_KUGLER2 <-  10
  SE$SIDM_BABYL_KUGLER3 <-  11
  SE$SIDM_BABYL_HUBER    <-	12
  SE$SIDM_BABYL_ETPSC   <- 	13
  SE$SIDM_ALDEBARAN_15TAU <- 14
  SE$SIDM_HIPPARCHOS     <- 15
  SE$SIDM_SASSANIAN   <-    16
  SE$SIDM_GALCENT_0SAG  <-  17
  SE$SIDM_J2000     <-      18
  SE$SIDM_J1900       <-    19
  SE$SIDM_B1950     <-      20
  SE$SIDM_SURYASIDDHANTA <-  21
  SE$SIDM_SURYASIDDHANTA_MSUN <-  22
  SE$SIDM_ARYABHATA   <-    23
  SE$SIDM_ARYABHATA_MSUN <-  24
  SE$SIDM_SS_REVATI   <-    25
  SE$SIDM_SS_CITRA      <-  26
  SE$SIDM_TRUE_CITRA    <-  27
  SE$SIDM_TRUE_REVATI   <-  28
  SE$SIDM_TRUE_PUSHYA   <-  29
  SE$SIDM_GALCENT_RGILBRAND <- 30
  SE$SIDM_GALEQU_IAU1958  <- 31
  SE$SIDM_GALEQU_TRUE <-    32
  SE$SIDM_GALEQU_MULA <-    33
  SE$SIDM_GALALIGN_MARDYKS <- 34
  SE$SIDM_TRUE_MULA     <-  35
  SE$SIDM_GALCENT_MULA_WILHELM  <-     36
  SE$SIDM_ARYABHATA_522   <- 37
  SE$SIDM_BABYL_BRITTON   <- 38
  SE$SIDM_TRUE_SHEORAN  	<- 39
  SE$SIDM_USER  <- 255 #/* user-defined ayanamsha, t0 is TT */
  
  #  /* used for swe_nod_aps(): */
  SE$NODBIT_MEAN	<-	1   #/* mean nodes/apsides */
  SE$NODBIT_OSCU <-		2   #/* osculating nodes/apsides */
  SE$NODBIT_OSCU_BAR <-
    4  # /* same, but motion about solar system barycenter is considered */
  SE$NODBIT_FOPOINT	<-
    256   #/* focal point of orbit instead of aphelion */
  
  #  /* default ephemeris used when no ephemeris flagbit is set */
  SE$FLG_DEFAULTEPH <- SE$FLG_SWIEPH
  
  #   /* defines for eclipse computations */
  SE$ECL_CENTRAL	<-	1
  SE$ECL_NONCENTRAL <-	2
  SE$ECL_TOTAL	<-	4
  SE$ECL_ANNULAR	<-	8
  SE$ECL_PARTIAL	<-	16
  SE$ECL_ANNULAR_TOTAL <-	32
  SE$ECL_PENUMBRAL <-	64
  SE$ECL_ALLTYPES_SOLAR <-
    (
      SE$ECL_CENTRAL   +
        SE$ECL_NONCENTRAL   +
        SE$ECL_TOTAL   + SE$ECL_ANNULAR   + SE$ECL_PARTIAL   + SE$ECL_ANNULAR_TOTAL
    )
  SE$ECL_ALLTYPES_LUNAR <-
    (SE$ECL_TOTAL   + SE$ECL_PARTIAL   + SE$ECL_PENUMBRAL)
  SE$ECL_VISIBLE		<-	128
  SE$ECL_MAX_VISIBLE <-		256
  SE$ECL_1ST_VISIBLE	<-	512	#/* begin of partial eclipse */
  SE$ECL_PARTBEG_VISIBLE <-		512	#/* begin of partial eclipse */
  SE$ECL_2ND_VISIBLE	<-	1024	#/* begin of total eclipse */
  SE$ECL_TOTBEG_VISIBLE	<-	1024#	/* begin of total eclipse */
  SE$ECL_3RD_VISIBLE <-		2048   # /* end of total eclipse */
  SE$ECL_TOTEND_VISIBLE <-		2048  #  /* end of total eclipse */
  SE$ECL_4TH_VISIBLE <-		4096    #/* end of partial eclipse */
  SE$ECL_PARTEND_VISIBLE <-		4096 #   /* end of partial eclipse */
  SE$ECL_PENUMBBEG_VISIBLE <-
    8192  #  /* begin of penumbral eclipse */
  SE$ECL_PENUMBEND_VISIBLE <-	16384  # /* end of penumbral eclipse */
  SE$ECL_OCC_BEG_DAYLIGHT <-
    8192    #/* occultation begins during the day */
  SE$ECL_OCC_END_DAYLIGHT <-
    16384   #/* occultation ends during the day */
  SE$ECL_ONE_TRY    <-      (32 * 1024)
  # /* check if the next conjunction of the moon with
  # * a planet is an occultation; don't search further */
  
  # /* for swe_rise_transit() */
  SE$CALC_RISE <-		1
  SE$CALC_SET	<-	2
  SE$CALC_MTRANSIT <-	4
  SE$CALC_ITRANSIT <-	8
  SE$BIT_DISC_CENTER  <-    256 #/* to be or'ed to SE$CALC_RISE/SET,
  # * if rise or set of disc center is
  # * required */
  SE$BIT_DISC_BOTTOM   <-  8192 #/* to be or'ed to SE$CALC_RISE/SET,
  #   * if rise or set of lower limb of
  # * disc is requried */
  SE$BIT_GEOCTR_NO_ECL_LAT <-
    128 #/* use geocentric rather than topocentric
  #   position of object and
  # ignore its ecliptic latitude */
  SE$BIT_NO_REFRACTION  <- 512 #/* to be or'ed to SE$CALC_RISE/SET,
  #  * if refraction is to be ignored */
  SE$BIT_CIVIL_TWILIGHT  <-
    1024 #/* to be or'ed to SE$CALC_RISE/SET */
  SE$BIT_NAUTIC_TWILIGHT  <-
    2048 #/* to be or'ed to SE$CALC_RISE/SET */
  SE$BIT_ASTRO_TWILIGHT   <-
    4096 #/* to be or'ed to SE$CALC_RISE/SET */
  SE$BIT_FIXED_DISC_SIZE <-  16384 #/* or'ed to SE$CALC_RISE/SET:
  #   * neglect the effect of distance on
  # * disc size */
  SE$BIT_FORCE_SLOW_METHOD <-
    32768 #/* This is only a Astrodienst in-house
  #   * test flag. It forces the usage
  # * of the old, slow calculation of
  # * risings and settings. */
  SE$BIT_HINDU_RISING <-
    (SE$BIT_DISC_CENTER   + SE$BIT_NO_REFRACTION   +
       SE$BIT_GEOCTR_NO_ECL_LAT)
  
  # /* for swe_azalt() and swe_azalt_rev() */
  SE$ECL2HOR	<-	0
  SE$EQU2HOR	<-	1
  SE$HOR2ECL	<-	0
  SE$HOR2EQU	<-	1
  
  # /* for swe_refrac() */
  SE$TRUE_TO_APP <-	0
  SE$APP_TO_TRUE <-	1
  
  #   for swe_set_jpl_file()
  #   * only used for experimenting with various JPL ephemeris files
  # * which are available at Astrodienst's internal network
  # */
  SE$DE_NUMBER  <-  431
  SE$FNAME_DE200 <-  "de200.eph"
  SE$FNAME_DE403  <- "de403.eph"
  SE$FNAME_DE404  <- "de404.eph"
  SE$FNAME_DE405 <-  "de405.eph"
  SE$FNAME_DE406 <-  "de406.eph"
  SE$FNAME_DE431 <-  "de431.eph"
  SE$FNAME_DFT  <-  SE$FNAME_DE431
  SE$FNAME_DFT2   <- SE$FNAME_DE406
  SE$STARFILE   <-  "sefstars.txt"
  SE$ASTNAMFILE <-  "seasnam.txt"
  SE$FICTFILE     <- "seorbel.txt"
  
  #/* defines for function swe_split_deg() (in swephlib.c) */
  SE$SPLIT_DEG_ROUND_SEC  <-  1
  SE$SPLIT_DEG_ROUND_MIN   <- 2
  SE$SPLIT_DEG_ROUND_DEG   <- 4
  SE$SPLIT_DEG_ZODIACAL    <- 8
  SE$SPLIT_DEG_NAKSHATRA <- 1024
  SE$SPLIT_DEG_KEEP_SIGN <-  16	#/* don't round to next sign,
  # * e.g. 29.9999999 will be rounded
  # * to 29d59'59" (or 29d59' or 29d) */
  SE$SPLIT_DEG_KEEP_DEG  <-  32	#/* don't round to next degree
  #   * e.g. 13.9999999 will be rounded
  # * to 13d59'59" (or 13d59' or 13d) */
  
  #   /* for heliacal functions */
  SE$HELIACAL_RISING	<-	1
  SE$HELIACAL_SETTING	<-	2
  SE$MORNING_FIRST	<-	SE$HELIACAL_RISING
  SE$EVENING_LAST		<-	SE$HELIACAL_SETTING
  SE$EVENING_FIRST	<-	3
  SE$MORNING_LAST		<-	4
  SE$ACRONYCHAL_RISING <-		5  #/* still not implemented */
  SE$ACRONYCHAL_SETTING	<-	6  #/* still not implemented */
  SE$COSMICAL_SETTING	<-	SE$ACRONYCHAL_SETTING
  
  SE$HELFLAG_LONG_SEARCH 	<-	128
  SE$HELFLAG_HIGH_PRECISION <-	256
  SE$HELFLAG_OPTICAL_PARAMS	<- 512
  SE$HELFLAG_NO_DETAILS		<- 1024
  SE$HELFLAG_SEARCH_1_PERIOD	<- 2048
  SE$HELFLAG_VISLIM_DARK		<-  4096
  SE$HELFLAG_VISLIM_NOMOON <-	  8192
  #/* the following undocumented defines are for test reasons only */
  SE$HELFLAG_VISLIM_PHOTOPIC	<- 16384
  SE$HELFLAG_VISLIM_SCOTOPIC	<- 32768
  SE$HELFLAG_AV	 		<- 65536
  SE$HELFLAG_AVKIND_VR 		<- 65536
  SE$HELFLAG_AVKIND_PTO 	<-	65536 * 2
  SE$HELFLAG_AVKIND_MIN7 	<-	65536 * 4
  SE$HELFLAG_AVKIND_MIN9 		<- 65536 * 8
  SE$HELFLAG_AVKIND <-
    (
      SE$HELFLAG_AVKIND_VR   +
        SE$HELFLAG_AVKIND_PTO   + SE$HELFLAG_AVKIND_MIN7   +
        SE$HELFLAG_AVKIND_MIN9
    )
  return(SE)
}