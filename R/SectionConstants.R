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

SE_AUNIT_TO_KM        <- 149597870.691
SE_AUNIT_TO_LIGHTYEAR <- 1.0 / 63241.077088071
SE_AUNIT_TO_PARSEC    <- 1.0 / 206264.8062471

# /* values for gregflag in swe_julday() and swe_revjul() */
SE_JUL_CAL <-	0
SE_GREG_CAL	<- 1

#   /*
#   * planet numbers for the ipl parameter in swe_calc()
# */
SE_ECL_NUT     <- -1

SE_SUN       <-   0
SE_MOON       <-  1
SE_MERCURY  <-    2
SE_VENUS    <-    3
SE_MARS     <-    4
SE_JUPITER  <-    5
SE_SATURN   <-    6
SE_URANUS   <-    7
SE_NEPTUNE  <-    8
SE_PLUTO      <-  9
SE_MEAN_NODE  <-  10
SE_TRUE_NODE  <-  11
SE_MEAN_APOG  <-  12
SE_OSCU_APOG  <-  13
SE_EARTH      <-  14
SE_CHIRON     <-  15
SE_PHOLUS     <-  16
SE_CERES      <-  17
SE_PALLAS     <-  18
SE_JUNO       <-  19
SE_VESTA      <-  20
SE_INTP_APOG <-    21
SE_INTP_PERG  <-  22

SE_NPLANETS   <-  23

SE_AST_OFFSET <-  10000
SE_VARUNA   <- SE_AST_OFFSET + 20000

SE_FICT_OFFSET  <-	40
SE_FICT_OFFSET_1 <-  	39
SE_FICT_MAX  	  <-     999
SE_NFICT_ELEM     <-      15

SE_COMET_OFFSET <- 1000

SE_NALL_NAT_POINTS  <-    (SE_NPLANETS + SE_NFICT_ELEM)

# /* Hamburger or Uranian "planets" */
SE_CUPIDO      <- 	40
SE_HADES      <-  	41
SE_ZEUS        <- 	42
SE_KRONOS     <-  	43
SE_APOLLON    <-  	44
SE_ADMETOS    <-  	45
SE_VULKANUS   <-  	46
SE_POSEIDON   <-  	47
# /* other fictitious bodies */
SE_ISIS      <-   	48
SE_NIBIRU     <-  	49
SE_HARRINGTON   <-        50
SE_NEPTUNE_LEVERRIER <-    51
SE_NEPTUNE_ADAMS    <-    52
SE_PLUTO_LOWELL     <-    53
SE_PLUTO_PICKERING  <-    54
SE_VULCAN      	<-	55
SE_WHITE_MOON  	<-	56
SE_PROSERPINA  	<-	57
SE_WALDEMATH  	<-	58

SE_FIXSTAR  <-    -10

SE_ASC		<-	0
SE_MC	<-		1
SE_ARMC	<-		2
SE_VERTEX	<-	3
SE_EQUASC  	<-	4	#/* "equatorial ascendant" */
SE_COASC1	<-	5	#/* "co-ascendant" (W. Koch) */
SE_COASC2	<-	6	#/* "co-ascendant" (M. Munkasey) */
SE_POLASC	<-	7	#/* "polar ascendant" (M. Munkasey) */
SE_NASCMC	<-	8

# /*
#   * flag bits for parameter iflag in function swe_calc()
# * The flag bits are defined in such a way that iflag = 0 delivers what one
# * usually wants:
#   *    - the default ephemeris (SWISS EPHEMERIS) is used,
# *    - apparent geocentric positions referring to the true equinox of date
# *      are returned.
# * If not only coordinates, but also speed values are required, use
# * flag = SEFLG_SPEED.
# *
#   * The 'L' behind the number indicates that 32-bit integers (Long) are used.
# */
SEFLG_JPLEPH   <- 1       #/* use JPL ephemeris */
SEFLG_SWIEPH  <-  2       #/* use SWISSEPH ephemeris */
SEFLG_MOSEPH  <-  4       #/* use Moshier ephemeris */

SEFLG_HELCTR <-	8      #/* heliocentric position */
SEFLG_TRUEPOS <-
  16     #/* true/geometric position, not apparent position */
SEFLG_J2000	<-
  32     #/* no precession, i.e. give J2000 equinox */
SEFLG_NONUT <-
  64     #/* no nutation, i.e. mean equinox of date */
SEFLG_SPEED3 <-	128   # /* speed from 3 positions (do not use it,
# * SEFLG_SPEED is faster and more precise.) */
SEFLG_SPEED	<- 256    #/* high precision speed  */
SEFLG_NOGDEFL <-	512   # /* turn off gravitational deflection */
SEFLG_NOABERR	<-
  1024   #/* turn off 'annual' aberration of light */
SEFLG_ASTROMETRIC <-
  (SEFLG_NOABERR + SEFLG_NOGDEFL) #/* astrometric position,
#   * i.e. with light-time, but without aberration and
# * light deflection */
SEFLG_EQUATORIAL <-
  (2 * 1024)    #/* equatorial positions are wanted */
SEFLG_XYZ <-
  (4 * 1024)     #/* cartesian, not polar, coordinates */
SEFLG_RADIANS <-
  (8 * 1024)  #   /* coordinates in radians, not degrees */
SEFLG_BARYCTR	<- (16 * 1024)  #  /* barycentric position */
SEFLG_TOPOCTR	<- (32 * 1024)   # /* topocentric position */
SEFLG_ORBEL_AA <-
  SEFLG_TOPOCTR #/* used for Astronomical Almanac mode in
# * calculation of Kepler elipses */
SEFLG_SIDEREAL <-	(64 * 1024)    #/* sidereal position */
SEFLG_ICRS <-	(128 * 1024)   #/* ICRS (DE406 reference frame) */
SEFLG_DPSIDEPS_1980	<- (256 * 1024) #/* reproduce JPL Horizons
# * 1962 - today to 0.002 arcsec. */
SEFLG_JPLHOR <-	SEFLG_DPSIDEPS_1980
SEFLG_JPLHOR_APPROX	<-
  (512 * 1024)   #/* approximate JPL Horizons 1962 - today */

SE_SIDBITS	<-	256
#  /* for projection onto ecliptic of t0 */
SE_SIDBIT_ECL_T0    <-    256
#  /* for projection onto solar system plane */
SE_SIDBIT_SSY_PLANE  <-   512
#  /* with user-defined ayanamsha, t0 is UT */
SE_SIDBIT_USER_UT   <-    1024

#  /* sidereal modes (ayanamsas) */
SE_SIDM_FAGAN_BRADLEY  <-  0
SE_SIDM_LAHIRI        <-   1
SE_SIDM_DELUCE    <-       2
SE_SIDM_RAMAN       <-     3
SE_SIDM_USHASHASHI    <-   4
SE_SIDM_KRISHNAMURTI  <-   5
SE_SIDM_DJWHAL_KHUL <-     6
SE_SIDM_YUKTESHWAR    <-   7
SE_SIDM_JN_BHASIN   <-     8
SE_SIDM_BABYL_KUGLER1 <-   9
SE_SIDM_BABYL_KUGLER2 <-  10
SE_SIDM_BABYL_KUGLER3 <-  11
SE_SIDM_BABYL_HUBER    <-	12
SE_SIDM_BABYL_ETPSC   <- 	13
SE_SIDM_ALDEBARAN_15TAU <- 14
SE_SIDM_HIPPARCHOS     <- 15
SE_SIDM_SASSANIAN   <-    16
SE_SIDM_GALCENT_0SAG  <-  17
SE_SIDM_J2000     <-      18
SE_SIDM_J1900       <-    19
SE_SIDM_B1950     <-      20
SE_SIDM_SURYASIDDHANTA <-  21
SE_SIDM_SURYASIDDHANTA_MSUN <-  22
SE_SIDM_ARYABHATA   <-    23
SE_SIDM_ARYABHATA_MSUN <-  24
SE_SIDM_SS_REVATI   <-    25
SE_SIDM_SS_CITRA      <-  26
SE_SIDM_TRUE_CITRA    <-  27
SE_SIDM_TRUE_REVATI   <-  28
SE_SIDM_TRUE_PUSHYA   <-  29
SE_SIDM_GALCENT_RGILBRAND <- 30
SE_SIDM_GALEQU_IAU1958  <- 31
SE_SIDM_GALEQU_TRUE <-    32
SE_SIDM_GALEQU_MULA <-    33
SE_SIDM_GALALIGN_MARDYKS <- 34
SE_SIDM_TRUE_MULA     <-  35
SE_SIDM_GALCENT_MULA_WILHELM  <-     36
SE_SIDM_ARYABHATA_522   <- 37
SE_SIDM_BABYL_BRITTON   <- 38
SE_SIDM_TRUE_SHEORAN  	<- 39
#//  SE_SIDM_GALCENT_COCHRANE  <- 	40
#  //  SE_SIDM_MANJULA       <-  41
SE_SIDM_USER          <-
  255 #/* user-defined ayanamsha, t0 is TT */

SE_NSIDM_PREDEF	  <-      40

#  /* used for swe_nod_aps(): */
SE_NODBIT_MEAN	<-	1   #/* mean nodes/apsides */
SE_NODBIT_OSCU <-		2   #/* osculating nodes/apsides */
SE_NODBIT_OSCU_BAR <-
  4  # /* same, but motion about solar system barycenter is considered */
SE_NODBIT_FOPOINT	<-
  256   #/* focal point of orbit instead of aphelion */

#  /* default ephemeris used when no ephemeris flagbit is set */
SEFLG_DEFAULTEPH <- SEFLG_SWIEPH

SE_MAX_STNAME	<-	256	#/* maximum size of fixstar name;
#   * the parameter star in swe_fixstar
# * must allow twice this space for
# * the returned star name.
# */
#
#   /* defines for eclipse computations */
#
SE_ECL_CENTRAL	<-	1
SE_ECL_NONCENTRAL <-	2
SE_ECL_TOTAL	<-	4
SE_ECL_ANNULAR	<-	8
SE_ECL_PARTIAL	<-	16
SE_ECL_ANNULAR_TOTAL <-	32
SE_ECL_PENUMBRAL <-	64
SE_ECL_ALLTYPES_SOLAR <-
  (
    SE_ECL_CENTRAL   +
      SE_ECL_NONCENTRAL   +
      SE_ECL_TOTAL   + SE_ECL_ANNULAR   + SE_ECL_PARTIAL   + SE_ECL_ANNULAR_TOTAL
  )
SE_ECL_ALLTYPES_LUNAR <-
  (SE_ECL_TOTAL   + SE_ECL_PARTIAL   + SE_ECL_PENUMBRAL)
SE_ECL_VISIBLE		<-	128
SE_ECL_MAX_VISIBLE <-		256
SE_ECL_1ST_VISIBLE	<-	512	#/* begin of partial eclipse */
SE_ECL_PARTBEG_VISIBLE <-		512	#/* begin of partial eclipse */
SE_ECL_2ND_VISIBLE	<-	1024	#/* begin of total eclipse */
SE_ECL_TOTBEG_VISIBLE	<-	1024#	/* begin of total eclipse */
SE_ECL_3RD_VISIBLE <-		2048   # /* end of total eclipse */
SE_ECL_TOTEND_VISIBLE <-		2048  #  /* end of total eclipse */
SE_ECL_4TH_VISIBLE <-		4096    #/* end of partial eclipse */
SE_ECL_PARTEND_VISIBLE <-		4096 #   /* end of partial eclipse */
SE_ECL_PENUMBBEG_VISIBLE <-
  8192  #  /* begin of penumbral eclipse */
SE_ECL_PENUMBEND_VISIBLE <-	16384  # /* end of penumbral eclipse */
SE_ECL_OCC_BEG_DAYLIGHT <-
  8192    #/* occultation begins during the day */
SE_ECL_OCC_END_DAYLIGHT <-
  16384   #/* occultation ends during the day */
SE_ECL_ONE_TRY    <-      (32 * 1024)
# /* check if the next conjunction of the moon with
# * a planet is an occultation; don't search further */
#
# /* for swe_rise_transit() */
SE_CALC_RISE <-		1
SE_CALC_SET	<-	2
SE_CALC_MTRANSIT <-	4
SE_CALC_ITRANSIT <-	8
SE_BIT_DISC_CENTER  <-    256 #/* to be or'ed to SE_CALC_RISE/SET,
# * if rise or set of disc center is
# * required */
SE_BIT_DISC_BOTTOM   <-
  8192 #/* to be or'ed to SE_CALC_RISE/SET,
#   * if rise or set of lower limb of
# * disc is requried */
SE_BIT_GEOCTR_NO_ECL_LAT <-
  128 #/* use geocentric rather than topocentric
#   position of object and
# ignore its ecliptic latitude */
SE_BIT_NO_REFRACTION  <-
  512 #/* to be or'ed to SE_CALC_RISE/SET,
#  * if refraction is to be ignored */
SE_BIT_CIVIL_TWILIGHT  <-
  1024 #/* to be or'ed to SE_CALC_RISE/SET */
SE_BIT_NAUTIC_TWILIGHT  <-
  2048 #/* to be or'ed to SE_CALC_RISE/SET */
SE_BIT_ASTRO_TWILIGHT   <-
  4096 #/* to be or'ed to SE_CALC_RISE/SET */
SE_BIT_FIXED_DISC_SIZE <-  16384 #/* or'ed to SE_CALC_RISE/SET:
#   * neglect the effect of distance on
# * disc size */
SE_BIT_FORCE_SLOW_METHOD <-
  32768 #/* This is only a Astrodienst in-house
#   * test flag. It forces the usage
# * of the old, slow calculation of
# * risings and settings. */
SE_BIT_HINDU_RISING <-
  (SE_BIT_DISC_CENTER   + SE_BIT_NO_REFRACTION   +
     SE_BIT_GEOCTR_NO_ECL_LAT)

# /* for swe_azalt() and swe_azalt_rev() */
SE_ECL2HOR	<-	0
SE_EQU2HOR	<-	1
SE_HOR2ECL	<-	0
SE_HOR2EQU	<-	1

# /* for swe_refrac() */
SE_TRUE_TO_APP <-	0
SE_APP_TO_TRUE <-	1

#   /*
#   * only used for experimenting with various JPL ephemeris files
# * which are available at Astrodienst's internal network
# */
SE_DE_NUMBER  <-  431
SE_FNAME_DE200 <-  "de200.eph"
SE_FNAME_DE403  <- "de403.eph"
SE_FNAME_DE404  <- "de404.eph"
SE_FNAME_DE405 <-  "de405.eph"
SE_FNAME_DE406 <-  "de406.eph"
SE_FNAME_DE431 <-  "de431.eph"
SE_FNAME_DFT  <-  SE_FNAME_DE431
SE_FNAME_DFT2   <- SE_FNAME_DE406
SE_STARFILE_OLD <- "fixstars.cat"
SE_STARFILE   <-  "sefstars.txt"
SE_ASTNAMFILE <-  "seasnam.txt"
SE_FICTFILE     <- "seorbel.txt"

# /*
# * ephemeris path
# * this defines where ephemeris files are expected if the function
# * swe_set_ephe_path() is not called by the application.
# * Normally, every application should make this call to define its
# * own place for the ephemeris files.
# */

#/* defines for function swe_split_deg() (in swephlib.c) */
SE_SPLIT_DEG_ROUND_SEC  <-  1
SE_SPLIT_DEG_ROUND_MIN   <- 2
SE_SPLIT_DEG_ROUND_DEG   <- 4
SE_SPLIT_DEG_ZODIACAL    <- 8
SE_SPLIT_DEG_NAKSHATRA <- 1024
SE_SPLIT_DEG_KEEP_SIGN <-  16	#/* don't round to next sign,
# * e.g. 29.9999999 will be rounded
# * to 29d59'59" (or 29d59' or 29d) */
SE_SPLIT_DEG_KEEP_DEG  <-  32	#/* don't round to next degree
#   * e.g. 13.9999999 will be rounded
# * to 13d59'59" (or 13d59' or 13d) */
#
#   /* for heliacal functions */
SE_HELIACAL_RISING	<-	1
SE_HELIACAL_SETTING	<-	2
SE_MORNING_FIRST	<-	SE_HELIACAL_RISING
SE_EVENING_LAST		<-	SE_HELIACAL_SETTING
SE_EVENING_FIRST	<-	3
SE_MORNING_LAST		<-	4
SE_ACRONYCHAL_RISING <-		5  #/* still not implemented */
SE_ACRONYCHAL_SETTING	<-	6  #/* still not implemented */
SE_COSMICAL_SETTING	<-	SE_ACRONYCHAL_SETTING

SE_HELFLAG_LONG_SEARCH 	<-	128
SE_HELFLAG_HIGH_PRECISION <-	256
SE_HELFLAG_OPTICAL_PARAMS	<- 512
SE_HELFLAG_NO_DETAILS		<- 1024
SE_HELFLAG_SEARCH_1_PERIOD	<- 2048
SE_HELFLAG_VISLIM_DARK		<-  4096
SE_HELFLAG_VISLIM_NOMOON <-	  8192
#/* the following undocumented defines are for test reasons only */
SE_HELFLAG_VISLIM_PHOTOPIC	<- 16384
SE_HELFLAG_VISLIM_SCOTOPIC	<- 32768
SE_HELFLAG_AV	 		<- 65536
SE_HELFLAG_AVKIND_VR 		<- 65536
SE_HELFLAG_AVKIND_PTO 	<-	65536 * 2
SE_HELFLAG_AVKIND_MIN7 	<-	65536 * 4
SE_HELFLAG_AVKIND_MIN9 		<- 65536 * 8
SE_HELFLAG_AVKIND <-
  (
    SE_HELFLAG_AVKIND_VR   +
      SE_HELFLAG_AVKIND_PTO   + SE_HELFLAG_AVKIND_MIN7   +
      SE_HELFLAG_AVKIND_MIN9
  )
TJD_INVALID		<- 	99999999.0
SIMULATE_VICTORVB        <-       1

##if 0  // unused and redundant
SE_HELIACAL_LONG_SEARCH <-	128
SE_HELIACAL_HIGH_PRECISION <-	256
SE_HELIACAL_OPTICAL_PARAMS <-	512
SE_HELIACAL_NO_DETAILS	<-	1024
SE_HELIACAL_SEARCH_1_PERIOD	<- 2048
SE_HELIACAL_VISLIM_DARK		<-  4096
SE_HELIACAL_VISLIM_NOMOON	<-  8192
SE_HELIACAL_VISLIM_PHOTOPIC	<- 16384
SE_HELIACAL_AVKIND_VR 		<- 32768
SE_HELIACAL_AVKIND_PTO 	<-	65536
SE_HELIACAL_AVKIND_MIN7 	<-	65536 * 2
SE_HELIACAL_AVKIND_MIN9 	<-	65536 * 4
SE_HELIACAL_AVKIND <-
  (
    SE_HELFLAG_AVKIND_VR   +
      SE_HELFLAG_AVKIND_PTO   + SE_HELFLAG_AVKIND_MIN7   +
      SE_HELFLAG_AVKIND_MIN9
  )

SE_PHOTOPIC_FLAG <-		0
SE_SCOTOPIC_FLAG	<-	1
SE_MIXEDOPIC_FLAG		<- 2

# /* for swe_set_tid_acc() and ephemeris-dependent delta t:
#   * intrinsic tidal acceleration in the mean motion of the moon,
# * not given in the parameters list of the ephemeris files but computed
# * by Chapront/Chapront-Touzé/Francou A&A 387 (2002), p. 705.
# */
SE_TIDAL_DE200       <-   (-23.8946)
SE_TIDAL_DE403        <-
  (-25.580)  #/* was (-25.8) until V. 1.76.2 */
SE_TIDAL_DE404      <-
  (-25.580)  #/* was (-25.8) until V. 1.76.2 */
SE_TIDAL_DE405    <-
  (-25.826)  #/* was (-25.7376) until V. 1.76.2 */
SE_TIDAL_DE406      <-
  (-25.826)  #/* was (-25.7376) until V. 1.76.2 */
SE_TIDAL_DE421      <-
  (-25.85)   #/* JPL Interoffice Memorandum 14-mar-2008 on DE421 Lunar Orbit */
SE_TIDAL_DE422      <-
  (-25.85)   #/* JPL Interoffice Memorandum 14-mar-2008 on DE421 (sic!) Lunar Orbit */
SE_TIDAL_DE430      <-
  (-25.82)   #/* JPL Interoffice Memorandum 9-jul-2013 on DE430 Lunar Orbit */
SE_TIDAL_DE431      <-
  (-25.80)   #/* IPN Progress Report 42-196 • February 15, 2014, p. 15; was (-25.82) in V. 2.00.00 */
SE_TIDAL_26         <-    (-26.0)
SE_TIDAL_STEPHENSON_2016      <-       (-25.85)
SE_TIDAL_DEFAULT    <-    SE_TIDAL_DE431
SE_TIDAL_AUTOMATIC    <-         999999
SE_TIDAL_MOSEPH       <-         SE_TIDAL_DE404
SE_TIDAL_SWIEPH       <-         SE_TIDAL_DEFAULT
SE_TIDAL_JPLEPH       <-         SE_TIDAL_DEFAULT

# /* for function swe_set_delta_t_userdef() */
SE_DELTAT_AUTOMATIC          <-   (-1E-10)

SE_MODEL_DELTAT     <-    0
SE_MODEL_PREC_LONGTERM <-  1
SE_MODEL_PREC_SHORTTERM <- 2
SE_MODEL_NUT        <-    3
SE_MODEL_BIAS       <-    4
SE_MODEL_JPLHOR_MODE  <-  5
SE_MODEL_JPLHORA_MODE <-  6
SE_MODEL_SIDT     <-      7
NSE_MODELS        <-      8

#/* precession models */
SEMOD_NPREC		<- 10
SEMOD_PREC_IAU_1976 <-      1
SEMOD_PREC_LASKAR_1986 <-   2
SEMOD_PREC_WILL_EPS_LASK <- 3
SEMOD_PREC_WILLIAMS_1994 <- 4
SEMOD_PREC_SIMON_1994    <- 5
SEMOD_PREC_IAU_2000      <- 6
SEMOD_PREC_BRETAGNON_2003  <-    7
SEMOD_PREC_IAU_2006      <- 8
SEMOD_PREC_VONDRAK_2011  <- 9
SEMOD_PREC_OWEN_1990    <- 10
SEMOD_PREC_DEFAULT    <-   SEMOD_PREC_VONDRAK_2011
# /* SE versions before 1.70 used IAU 1976 precession for
# * a limited time range of 2 centuries in combination with
# * the long-term precession Simon 1994.
# */
SEMOD_PREC_DEFAULT_SHORT <- SEMOD_PREC_VONDRAK_2011

# /* nutation models */
SEMOD_NNUT	<-	4
SEMOD_NUT_IAU_1980 <-          1
SEMOD_NUT_IAU_CORR_1987 <-
  2 #/* Herring's (1987) corrections to IAU 1980
# * nutation series. AA (1996) neglects them.*/
SEMOD_NUT_IAU_2000A       <-  3 #/* very time consuming ! */
SEMOD_NUT_IAU_2000B       <-
  4 #/* fast, but precision of milli-arcsec */
SEMOD_NUT_DEFAULT         <-
  SEMOD_NUT_IAU_2000B  #/* fast, but precision of milli-arcsec */

#  /* methods for sidereal time */
SEMOD_NSIDT	<-	4
SEMOD_SIDT_IAU_1976     <-    1
SEMOD_SIDT_IAU_2006     <-    2
SEMOD_SIDT_IERS_CONV_2010 <-  3
SEMOD_SIDT_LONGTERM       <-  4
SEMOD_SIDT_DEFAULT        <-  SEMOD_SIDT_LONGTERM
#  //  SEMOD_SIDT_DEFAULT      <-    SEMOD_SIDT_IERS_CONV_2010

#  /* frame bias methods */
SEMOD_NBIAS	<-	3
SEMOD_BIAS_NONE   <-          1  #/* ignore frame bias */
SEMOD_BIAS_IAU2000  <-
  2  #/* use frame bias matrix IAU 2000 */
SEMOD_BIAS_IAU2006    <-
  3  #/* use frame bias matrix IAU 2006 */
SEMOD_BIAS_DEFAULT      <-    SEMOD_BIAS_IAU2006

#   /* methods of JPL Horizons (iflag & SEFLG_JPLHOR),
# * using daily dpsi, deps;  see explanations below */
SEMOD_NJPLHOR	<-	2
SEMOD_JPLHOR_LONG_AGREEMENT <-
  1  #/* daily dpsi and deps from file are
#   * limited to 1962 - today. JPL uses the
# * first and last value for all  dates
# * beyond this time range. */
SEMOD_JPLHOR_DEFAULT    <-    SEMOD_JPLHOR_LONG_AGREEMENT
#   /* Note, currently this is the only option for SEMOD_JPLHOR..*/
#   /* SEMOD_JPLHOR_LONG_AGREEMENT, if combined with SEFLG_JPLHOR provides good
# * agreement with JPL Horizons for 9998 BC (-9997) until 9999 CE.
# * - After 20-jan-1962 until today, Horizons uses correct dpsi and deps.
# * - For dates before that, it uses dpsi and deps of 20-jan-1962, which
# *   provides a continuous ephemeris, but does not make sense otherwise.
# * - Before 1.1.1799 and after 1.1.2202, the precession model Owen 1990
# *   is used, as in Horizons.
# * An agreement with Horizons to a couple of milli arc seconds is achieved
# * for the whole time range of Horizons. (BC 9998-Mar-20 to AD 9999-Dec-31 TT.)
# */
#
#   /* methods of approximation of JPL Horizons (iflag & SEFLG_JPLHORA),
# * without dpsi, deps; see explanations below */
SEMOD_NJPLHORA <-		3
SEMOD_JPLHORA_1 <-    1
SEMOD_JPLHORA_2   <- 2
SEMOD_JPLHORA_3   <- 3
SEMOD_JPLHORA_DEFAULT     <- SEMOD_JPLHORA_3

#   /* With SEMOD_JPLHORA_1, planetary positions are always calculated
# * using a recent precession/nutation model. Frame bias matrix is applied
# * with some correction to RA and another correction added to epsilon.
# * This provides a very good approximation of JPL Horizons positions.
# *
#   * With SEMOD_JPLHORA_2, frame bias as recommended by IERS Conventions 2003
# * and 2010 is *not* applied. Instead, dpsi_bias and deps_bias are added to
# * nutation. This procedure is found in some older astronomical software.
# * Equatorial apparent positions will be close to JPL Horizons
# * (within a few mas) between 1962 and current years. Ecl. longitude
# * will be good, latitude bad.
# *
#   * With SEMOD_JPLHORA_3 works like SEMOD_JPLHORA_3 after 1962, but like
# * SEFLG_JPLHOR before that. This allows EXTREMELY good agreement with JPL
# * Horizons over its whole time range.
# */

SEMOD_NDELTAT	<-	5
SEMOD_DELTAT_STEPHENSON_MORRISON_1984  <- 1
SEMOD_DELTAT_STEPHENSON_1997 <-  2
SEMOD_DELTAT_STEPHENSON_MORRISON_2004 <-  3
SEMOD_DELTAT_ESPENAK_MEEUS_2006 <-  4
SEMOD_DELTAT_STEPHENSON_ETC_2016 <-  5
# //  SEMOD_DELTAT_DEFAULT   SEMOD_DELTAT_ESPENAK_MEEUS_2006
SEMOD_DELTAT_DEFAULT  <- SEMOD_DELTAT_STEPHENSON_ETC_2016
