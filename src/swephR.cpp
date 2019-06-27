// Copyright 2018, 2019 Ralf Stubner and Victor Reijs
//
// This file is part of swephR.
//
// swephR is free software: you can redistribute it and/or modify it
// under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// swephR is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with swephR.  If not, see <http://www.gnu.org/licenses/>.

#include <Rcpp.h>
#include <array>
#include <swephexp.h>

//////////////////////////////////////////////////////////////////////////
//' @title Section 1: The Ephemeris file related functions
//' @name Section1
//' @description Several initialization functions
//' @seealso Section 1 in \url{http://www.astro.com/swisseph/swephprg.htm}
//' @details
//' \describe{
//'   \item{swe_set_ephe_path()}{This is the first function that should be called
//'        before any other function of the Swiss Ephemeris. Even if you don't
//'        want to set an ephemeris path and use the Moshier ephemeris, it is
//'        nevertheless recommended to call swe_set_ephe_path(NULL), because this
//'        function makes important initializations. If you don't do that, the
//'        Swiss Ephemeris may work, but the results may be not 100\% consistent.}
//'   \item{swe_close()}{At the end of your computations this function releases most
//'        resources (open files and allocated memory) used by Swiss Ephemeris.}
//'   \item{swe_set_jpl_file()}{Set name of JPL ephemeris file.}
//'   \item{swe_version()}{The function provides the version number of the Swiss Ephemeris software.}
//' }
//' @param path Directory for the sefstars.txt, swe_deltat.txt and jpl files
//' @examples
//' \dontrun{swe_set_ephe_path("c:\\sweph\\ephe")}
//' swe_close()
//' swe_set_jpl_file("de431.eph")
//' swe_version()
//' @rdname Section1
//' @export
// [[Rcpp::export(swe_set_ephe_path)]]
void set_ephe_path(Rcpp::Nullable<Rcpp::CharacterVector> path) {
  if (path.isNotNull()) {
    swe_set_ephe_path(path.as().at(0));
  } else {
    swe_set_ephe_path(NULL);
  }
}

//' @rdname Section1
//' @export
// [[Rcpp::export(swe_close)]]
void close() {
  swe_close();
}


//' @param fname JPL ephemeris name as string (JPL ephemeris file, e.g. de431.eph)
//' @rdname Section1
//' @export
// [[Rcpp::export(swe_set_jpl_file)]]
void set_jpl_file(Rcpp::Nullable<Rcpp::CharacterVector> fname) {
    swe_set_jpl_file(fname.as().at(0));
 }

//' @return \code{swe_version} returns Swiss Ephemeris software version as string
//' @rdname Section1
//' @export
// [[Rcpp::export(swe_version)]]
std::string version() {
  std::array<char, 256> version{{'\0'}};
  swe_version(&version[0]);
  return std::string(&version[0]);
}


//////////////////////////////////////////////////////////////////////////
// Section 2: Computing positions
// Compute information of planet (UT)
// internal function that is called in Section2.R
// [[Rcpp::export]]
Rcpp::List calc_ut(Rcpp::NumericVector jd_ut, Rcpp::IntegerVector ipl, int iflag) {
  if (jd_ut.length() != ipl.length())
    Rcpp::stop("The number of bodies in 'ipl' and the number of dates in 'jd_ut' must be identical!");

  Rcpp::IntegerVector rc_(ipl.length());
  Rcpp::CharacterVector serr_(ipl.length());
  Rcpp::NumericMatrix xx_(ipl.length(), 6);

  for (int i = 0; i < ipl.length(); ++i) {
    std::array<double, 6> xx{{0.0}};
    std::array<char, 256> serr{{'\0'}};
    rc_(i) = swe_calc_ut(jd_ut[i], ipl(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
  }

  // remove dim attribute to return a vector
  if (ipl.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
			    Rcpp::Named("xx") = xx_,
			    Rcpp::Named("serr") = serr_);
}

// Compute information of planet (ET)
// internal function that is called in Section2.R
// [[Rcpp::export]]
Rcpp::List calc(Rcpp::NumericVector jd_et, Rcpp::IntegerVector ipl, int iflag) {
  if (jd_et.length() != ipl.length())
    Rcpp::stop("The number of bodies in 'ipl' and the number of dates in 'jd_et' must be identical!");

  Rcpp::IntegerVector rc_(ipl.length());
  Rcpp::CharacterVector serr_(ipl.length());
  Rcpp::NumericMatrix xx_(ipl.length(), 6);

  for (int i = 0; i < ipl.length(); ++i) {
    std::array<double, 6> xx{{0.0}};
    std::array<char, 256> serr{{'\0'}};
    rc_(i) = swe_calc(jd_et[i], ipl(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
  }
  // remove dim attribute to return a vector
  if (ipl.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("xx") = xx_,
                            Rcpp::Named("serr") = serr_);
}


//////////////////////////////////////////////////////////////////////////
//' @title Section 3: Find a planetary or asteroid name
//' @name Section3
//' @description Find a planetary or asteroid name.
//' @seealso Section 3 in \url{http://www.astro.com/swisseph/swephprg.htm}
//' @details
//' \describe{
//'   \item{swe_get_planet_name()}{Convert object number into object name.}
//' }
//' @examples
//' data(SE)
//' swe_get_planet_name(SE$MOON)
//' @param ipl  Body/planet as integer (SE$SUN=0, SE$Moon=1,  ... SE$PLUTO=9)
//' @return \code{swe_get_planet_name} returns the object's name as string
//' @rdname Section3
//' @export
// [[Rcpp::export(swe_get_planet_name)]]
std::string get_planet_name(int ipl) {
  std::array<char, 41> objectname{'\0'};
  swe_get_planet_name(ipl,&objectname[0]);
  return std::string(&objectname[0]);
}


//////////////////////////////////////////////////////////////////////////
// Section 4: Fixed stars functions
// Compute information of star (UT)
// internal function that is called in Section4.R
// [[Rcpp::export]]
Rcpp::List fixstar2_ut(Rcpp::CharacterVector starname, Rcpp::NumericVector jd_ut, int iflag) {
  if (jd_ut.length() != starname.length())
    Rcpp::stop("The number of stars in 'starname' and the number of dates in 'jd_ut' must be identical!");

  Rcpp::IntegerVector rc_(starname.length());
  Rcpp::CharacterVector serr_(starname.length());
  Rcpp::NumericMatrix xx_(starname.length(), 6);

  for (int i = 0; i < starname.length(); ++i) {
    std::array<double, 6> xx{0.0};
    std::array<char, 256> serr{'\0'};
    std::string starname_(starname(i));
    starname_.resize(41);
    rc_(i) = swe_fixstar2_ut(&starname_[0], jd_ut(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
    starname(i) = starname_;
  }

  // remove dim attribute to return a vector
  if (starname.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("starname") = starname,
                            Rcpp::Named("xx") = xx_,
                            Rcpp::Named("serr") = serr_);
}


// Compute information of star (ET)
// internal function that is called in Section4.R
// [[Rcpp::export]]
Rcpp::List fixstar2(Rcpp::CharacterVector starname, Rcpp::NumericVector jd_et, int iflag) {
  if (jd_et.length() != starname.length())
    Rcpp::stop("The number of stars in 'starname' and the number of dates in 'jd_et' must be identical!");

  Rcpp::IntegerVector rc_(starname.length());
  Rcpp::CharacterVector serr_(starname.length());
  Rcpp::NumericMatrix xx_(starname.length(), 6);

  for (int i = 0; i < starname.length(); ++i) {
    std::array<double, 6> xx{0.0};
    std::array<char, 256> serr{'\0'};
    std::string starname_(starname(i));
    starname_.resize(41);
    rc_(i) = swe_fixstar2(&starname_[0], jd_et(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
    starname(i) = starname_;
  }

  // remove dim attribute to return a vector
  if (starname.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("starname") = starname,
                            Rcpp::Named("xx") = xx_,
                            Rcpp::Named("serr") = serr_);
}

//' @return \code{swe_fixstar2_mag} returns a list with named entries: \code{return} status flag as integer,
//'         \code{starname} updated star name as string, \code{mag} magnitude of star as double, and \code{serr} for error message as string.
//' @name Section4
//' @rdname Section4
//' @export
// [[Rcpp::export(swe_fixstar2_mag)]]
Rcpp::List fixstar2_mag(Rcpp::CharacterVector starname) {
  Rcpp::IntegerVector rc_(starname.length());
  Rcpp::CharacterVector serr_(starname.length());
  Rcpp::NumericVector mag_(starname.length());

  for (int i = 0; i < starname.length(); ++i) {
    double mag;
    std::array<char, 256> serr{'\0'};
    std::string starname_(starname(i));
    starname_.resize(41);
    rc_(i) = swe_fixstar2_mag(&starname_[0], &mag, serr.begin());
    mag_(i) = mag;
    serr_(i) = std::string(serr.begin());
    starname(i) = starname_;
  }

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("starname") = starname,
                            Rcpp::Named("mag") = mag_,
                            Rcpp::Named("serr") = serr_);
}

//////////////////////////////////////////////////////////////////////////
//' @title Section 6: Eclipses, Risings, Settings, Meridian Transits, Planetary Phenomena
//' @name Section6
//' @description Functions for: determining eclipse and occultation calculations, computing the times of rising, setting and
//' meridian transits for all planets, asteroids, the moon and the fixed stars; computing phase, phase angle, elongation,
//' apparent diameter, apparent magnitude for the Sun, the Moon, all planets and asteroids; and determining
//' heliacal phenomenon after a given start date
//' @seealso Section 6 in \url{http://www.astro.com/swisseph/swephprg.htm}
//' @param jd_et  ET Julian day number as double (day)
//' @param ipl  Body/planet as integer (\code{SE$SUN=0}, \code{SE$MOON=1}, ... \code{SE$PLUTO=9})
//' @param starname  Star name as string (\code{""} for no star)
//' @param jd_ut  UT Julian day number as double (day)
//' @param calc_flag Calculation flag as integer (refraction direction (\code{SE$TRUE_TO_APP=0} or \code{SE$APP_TO_TRUE=1}))
//' @param coord_flag Coordinate flag as integer (reference system (\code{SE$ECL2HOR=0} or \code{SE$EQU2HOR=1}))
//' @param atpress Atmospheric pressure as double (hPa)
//' @param attemp Atmospheric temperature as double (Celsius)
//' @param ephe_flag Ephemeris flag as integer (\code{SE$FLG_JPLEPH=1}, \code{SE$FLG_SWIEPH=2} or \code{SE$FLG_MOSEPH=4})
//' @param horhgt Horizon apparent altitude as double (deg)
//' @param xin  Position of body as numeric vector (either ecliptical or equatorial coordinates, depending on coord_flag)
//' @param rsmi  Event flag as integer (e.g.: \code{SE$CALC_RISE=1}, \code{SE$CALC_SET=2}, \code{SE$CALC_MTRANSIT=4}, \code{SE$CALC_ITRANSIT=8})
//' @details
//' \describe{
//'   \item{swe_sol_eclipse_when_loc()}{Find the next solar eclipse for a given geographic position.}
//'   }
//' @examples
//' data(SE)
//' swe_sol_eclipse_when_loc(1234567,SE$FLG_MOSEPH,c(0,50,10),FALSE)
//' swe_lun_eclipse_when_loc(1234567,SE$FLG_MOSEPH,c(0,50,10),FALSE)
//' swe_lun_eclipse_how(1234580.19960447,SE$FLG_MOSEPH,c(0,50,10))
//' swe_lun_eclipse_when(1234567,SE$FLG_MOSEPH,SE$ECL_CENTRAL,FALSE)
//' swe_rise_trans_true_hor(1234567.5,SE$SUN,"",SE$FLG_MOSEPH,0,c(0,50,10),1013.25,15,0)
//' swe_pheno_ut(1234567,1,SE$FLG_MOSEPH)
//' swe_pheno(1234567,1,SE$FLG_MOSEPH)
//' swe_azalt(1234567,SE$EQU2HOR,c(0,50,10),15,1013.25,c(186,22))
//' swe_azalt_rev(1234567,SE$ECL2HOR,c(0, 50,10),c(123,2))
//' swe_refrac_extended(2,0,1013.25,15,-0.065,SE$TRUE_TO_APP)
//' swe_heliacal_ut(1234567,c(0,50,10),c(1013.25,15,50,0.25),c(25,1,1,1,5,0.8),"sirius",
//'   SE$HELIACAL_RISING,SE$HELFLAG_HIGH_PRECISION+SE$FLG_MOSEPH)
//' swe_vis_limit_mag(1234567.5,c(0,50,10),c(1013.25,15,20,0.25),c(25,1,1,1,5,0.8),'sirius',
//'   SE$HELFLAG_HIGH_PRECISION+SE$FLG_MOSEPH)
//' swe_heliacal_pheno_ut(1234567.5,c(0,50,10),c(1013.25,15,20,0.25),c(25,1,1,1,5,0.8),'sirius',
//'   SE$HELIACAL_RISING,SE$HELFLAG_HIGH_PRECISION+SE$FLG_MOSEPH)
//' swe_topo_arcus_visionis(1234567.5,c(0,50,10),c(1013.25,15,20,0.25),c(25,1,1,1,5,0.8),
//'   SE$HELFLAG_HIGH_PRECISION+SE$HELFLAG_OPTICAL_PARAMS,-1,124,2,120,0,-45)
//' swe_heliacal_angle(1234567.5,c(0,50,10),c(1013.25,15,20,0.25),c(25,1,1,1,5,0.8),
//'   SE$HELFLAG_HIGH_PRECISION+SE$HELFLAG_OPTICAL_PARAMS,-1,124,120,0,-45)
//' @return \code{swe_sol_eclipse_when_loc} returns a list with named entries:
//'      \code{return} status flag as integer, \code{tret} for eclipse timing moments as numeric vector,
//'      \code{attr} phenomena during eclipse as numeric vector and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_sol_eclipse_when_loc)]]
Rcpp::List sol_eclipse_when_loc(double jd_start, int ephe_flag, Rcpp::NumericVector geopos, bool backward) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have a length of 3");
  std::array<double, 10> tret{0.0};
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_sol_eclipse_when_loc(jd_start, ephe_flag, geopos.begin(), tret.begin(), attr.begin(), backward, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("tret") = tret,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
    );
}

//' @details
//' \describe{
//' \item{swe_lun_eclipse_when_loc()}{Find the next lunar eclipse for a given geographic position.}
//' }
//' @param geopos position as numeric vector (longitude, latitude, height)
//' @param backward backwards search as boolean (TRUE)
//' @return \code{swe_lun_eclipse_when_loc} returns a list with named entries:
//'      \code{return} status flag as integer, \code{tret} for eclipse timing moments,
//'      \code{attr} phenomena during eclipse and \code{serr} error warning as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_lun_eclipse_when_loc)]]
Rcpp::List lun_eclipse_when_loc(double jd_start, int ephe_flag, Rcpp::NumericVector geopos, bool backward) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have a length of 3");
  std::array<double, 10> tret{0.0};
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_when_loc(jd_start, ephe_flag, geopos.begin(), tret.begin(), attr.begin(), backward, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("tret") = tret,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}

//' @details
//' \describe{
//' \item{swe_lun_eclipse_how()}{Compute the attributes of a lunar eclipse for a given time.}
//' }
//' @param jd_start  Julian day number as double (UT)
//' @return \code{swe_lun_eclipse_how} returns a list with named entries:
//'      \code{return} status flag as integer,
//'      \code{attr} phenomena during eclipse as numeric vector and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_lun_eclipse_how)]]
Rcpp::List lun_eclipse_how(double jd_ut, int ephe_flag, Rcpp::NumericVector geopos) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have a length of 3");
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_how(jd_ut, ephe_flag, geopos.begin(), attr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}


//' @details
//' \describe{
//' \item{swe_lun_eclipse_when()}{Find the next lunar eclipse on earth.}
//' }
//' @param ifltype eclipse type as integer (\code{SE$ECL_CENTRAL=1}, \code{SE$ECL_NONCENTRAL=2},
//'  \code{SE$ECL_TOTAL=4}, \code{SE$ECL_ANNULAR=8}, \code{SE$ECL_PARTIAL=16} or \code{SE$ECL_ANNULAR_TOTAL=32})
//' @return \code{swe_lun_eclipse_when} returns a list with named entries:
//'      \code{return} status flag as integer, \code{tret} for eclipse timing moments as numeric vector
//'      and \code{serr} error warning as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_lun_eclipse_when)]]
Rcpp::List lun_eclipse_when(double jd_start, int ephe_flag, int ifltype, bool backward) {
  std::array<double, 20> tret{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_when(jd_start, ephe_flag, ifltype, tret.begin(), backward, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("tret") = tret,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}

//' @details
//' \describe{
//' \item{swe_rise_trans_true_hor()}{Compute the times of rising, setting and meridian transits for planets, asteroids, the moon, and the fixed stars for a local horizon that has an altitude. }
//' }
//' @return \code{swe_rise_trans_true_hor} returns a list with named entries: \code{return} status flag as integer,
//'      \code{tret} for azimuth/altitude info as numeric vector and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_rise_trans_true_hor)]]
Rcpp::List rise_trans_true_hor(double jd_ut, int ipl, std::string starname, int ephe_flag, int rsmi,Rcpp::NumericVector geopos, double atpress, double attemp, double horhgt) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have a length of 3");
  std::array<char, 256> serr{'\0'};
  double tret;
  starname.resize(41);
  int i = swe_rise_trans_true_hor(jd_ut, ipl, &starname[0], ephe_flag, rsmi, geopos.begin(), atpress, attemp, horhgt, &tret, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("tret") = tret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}


//' @details
//' \describe{
//' \item{swe_pheno_ut()}{Compute phase, phase angle, elongation, apparent diameter, apparent magnitude for the Sun, the Moon, all planets and asteroids (UT)}
//' }
//' @return \code{swe_pheno_ut} returns a list with named entries:
//'      \code{return} status fag as integer, \code{attr} for phenomenon information as numeric vector
//'      and \code{serr} error warning as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_pheno_ut)]]
Rcpp::List pheno_ut(double jd_ut, int ipl, int ephe_flag) {
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_pheno_ut(jd_ut, ipl, ephe_flag, attr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}


//' @details
//' \describe{
//' \item{swe_pheno()}{Compute phase, phase angle, elongation, apparent diameter, apparent magnitude for the Sun, the Moon, all planets and asteroids (ET).}
//' }
//' @return \code{swe_pheno} returns a list with named entries:
//'      \code{return} status fag as integer, \code{attr} for phenomenon information as numeric vector
//'      and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_pheno)]]
Rcpp::List pheno(double jd_et, int ipl, int ephe_flag) {
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_pheno(jd_et, ipl, ephe_flag, attr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}

//' @details
//' \describe{
//' \item{swe_azalt()}{Compute the horizontal coordinates (azimuth and altitude) of a planet or a star from either ecliptical or equatorial coordinates.}
//' }
//' @return \code{swe_azalt} returns a list with named entries:
//'      \code{xaz} for azi/alt info as numeric vector.
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_azalt)]]
Rcpp::List azalt(double jd_ut, int coord_flag, Rcpp::NumericVector geopos, double atpress, double attemp, Rcpp::NumericVector xin) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have a length of 3");
  std::array<double, 3> xaz{0.0};
  swe_azalt(jd_ut, coord_flag, geopos.begin(), atpress, attemp, xin.begin(), xaz.begin());
  return Rcpp::List::create(Rcpp::Named("xaz") = xaz);
}


//' @details
//' \describe{
//' \item{swe_azalt_rev()}{compute either ecliptical or equatorial coordinates from azimuth and true altitude.
//' If only an apparent altitude is given, the true altitude has to be computed first with
//' e.g. the function swe_refrac_extended().}
//' }
//' @return \code{swe_azalt_rev} returns a list with named entries:
//'      \code{xaz} for celestial info as numeric vector.
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_azalt_rev)]]
Rcpp::List azalt_rev(double jd_ut, int coord_flag, Rcpp::NumericVector geopos, Rcpp::NumericVector xin) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have a length of 3");
  std::array<double, 3> xout{0.0};
  swe_azalt_rev(jd_ut, coord_flag, geopos.begin(), xin.begin(), xout.begin());
  return Rcpp::List::create(Rcpp::Named("xout") = xout);
}

//' @details
//' \describe{
//' \item{swe_refrac_extended()}{Calculate either the topocentric altitude from the apparent altitude
//' or the apparent altitude from the topocentric altitude.
//' It allows correct calculation of refraction for heights above sea > 0,
//' where the ideal horizon and planets that are visible may have a negative altitude. }
//' }
//' @param InAlt  object's apparent/topocentric altitude as double (depending on calc_flag) (deg)
//' @param height  observer's height as double (m)
//' @param lapse_rate  lapse rate as double (K/m)
//' @return \code{swe_refrac_extended} returns a list with named entries: \code{return} status flag as integer,
//'      \code{dret} refraction results as numeric vector (TopoAlt, AppAlt, refraction)
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_refrac_extended)]]
Rcpp::List refrac_extended(double InAlt, double height, double atpress, double attemp, double lapse_rate, int calc_flag) {
  std::array<double, 10> dret{0.0};
  double i = swe_refrac_extended(InAlt,height,atpress,attemp,lapse_rate,calc_flag, dret.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret);
}

//' @details
//' \describe{
//' \item{swe_heliacal_ut()}{Compute the Julian day of the next heliacal phenomenon after a given UT start date.
//' It works between geographic latitudes 60 South and 60 North.}
//' }
//' @param jd_utstart  UT Julian day number as double (day)
//' @param dgeo Geographic position as numeric vector (longitude, latitude, height)
//' @param datm Atmospheric conditions as numeric vector (pressure, temperature, relative humidity, visibility)
//' @param dobs Observer description as numeric vector
//' @param objectname  Name of fixed star or planet as string
//' @param event_type  Event type as integer
//' @param helflag Calculation flag (incl. ephe_flag values) as integer
//' @return \code{swe_heliacal_ut} returns a list with named entries \code{return} status flag as integer,
//'         \code{dret} heliacal results as numeric vector, and \code{serr} error message as string.
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_heliacal_ut)]]
Rcpp::List heliacal_ut(double jd_utstart, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int event_type, int helflag) {
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have a length of 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have a length of 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_heliacal_ut(jd_utstart, dgeo.begin(),datm.begin(),dobs.begin(),&objectname[0],event_type,helflag, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn,
                            Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' @details
//' \describe{
//' \item{swe_vis_limit_mag()}{Determine the limiting visual magnitude in dark skies. If the visual magnitude mag of an object is known
//' for a given date (e. g. from a call of function swe_pheno_ut(), and if magnitude is smaller than the value returned
//' by swe_vis_limit_mag(), then it is visible.}
//' }
//' @return \code{swe_vis_limit_mag} returns a list with named entries: \code{return} status flag as integer,
//'      \code{dret} limiting magnitude as double and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_vis_limit_mag)]]
Rcpp::List vis_limit_mag(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int helflag ){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have a length of 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have a length of 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_vis_limit_mag(jd_ut, dgeo.begin(), datm.begin(),dobs.begin(), &objectname[0], helflag, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' @details
//' \describe{
//' \item{swe_heliacal_pheno_ut()}{Provide data that are relevant for the calculation of heliacal risings and settings.
//' This function does not provide data of heliacal risings and settings itself, just some
//' additional data mostly used for test purposes. To calculate heliacal risings and settings,
//' use the function swe_heliacal_ut().}
//' }
//' @return \code{swe_heliacal_pheno_ut} returns a list with named entries: \code{return} status flag as integer
//'      \code{darr} for heliacal details as numeric vector and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_heliacal_pheno_ut)]]
Rcpp::List heliacal_pheno_ut(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int event_type, int helflag ){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have a length of 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have a length of 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> darr{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_heliacal_pheno_ut(jd_ut, dgeo.begin(), datm.begin(),dobs.begin(), &objectname[0], event_type, helflag, darr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("darr") = darr,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' @details
//' \describe{
//' \item{swe_topo_arcus_visionis()}{Compute topocentric arcus visionis.}
//' }
//' @param mag   Object's visible magnitude (Vmag) as double (-)
//' @param AziO  Object's azimuth as double (deg)
//' @param AltO  Object's altitude as double (deg)
//' @param AziS  Sun's azimuth as double (deg)
//' @param AziM  Moon's azimuth as double (deg)
//' @param AltM  Moon's altitude as double (deg)
//' @return \code{swe_topo_arcus_visionis} returns a list with named entries: \code{return} status flag as integer,
//'      \code{darr} heliacal details as numeric vector and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_topo_arcus_visionis)]]
Rcpp::List topo_arcus_visionis(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,int helflag,double mag,double AziO, double AltO,double AziS, double AziM, double AltM){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have a length of 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have a length of 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<char, 256> serr{'\0'};
  double tav;
  int i = swe_topo_arcus_visionis(jd_ut, dgeo.begin(), datm.begin(),dobs.begin(), helflag, mag,AziO, AltO, AziS,  AziM,  AltM, &tav, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("tav") = tav,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' @details
//' \describe{
//' \item{swe_heliacal_angle()}{Compute heliacal angle.}
//' }
//' @return \code{swe_heliacal_angle} returns a list with named entries: \code{return} status flag as integer,
//'      \code{dret} heliacal angle as numeric vector and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_heliacal_angle)]]
Rcpp::List heliacal_angle(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,int helflag,double mag,double AziO, double AziS, double AziM, double AltM){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have a length of 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have a length of 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_heliacal_angle(jd_ut, dgeo.begin(), datm.begin(),dobs.begin(), helflag, mag,AziO, AziS,  AziM,  AltM, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

// to be added in future:
// swe_sol_eclipse_when_glob( tjd...) finds the next eclipse globally.
// swe_sol_eclipse_where() computes the geographic location of a solar eclipse for a given tjd.
// swe_sol_eclipse_how() computes attributes of a solar eclipse for a given tjd, geographic longitude, latitude and height.

// swe_lun_occult_when_loc( tjd...) finds the next occultation for a body and a given geographic position.
// swe_lun_occult_when_glob( tjd...) finds the next occultation of a given body globally.
// swe_lun_occult_where() computes the geographic location of an occultation for a given tjd.


//////////////////////////////////////////////////////////////////////////
//' @title Section 7: Date and time conversion functions
//' @name Section7
//' @description Functions related to calendar and time conversions.
//' @seealso Section 7 in \url{http://www.astro.com/swisseph/swephprg.htm}
//' @details
//' \describe{
//'   \item{swe_julday()}{Convert calendar dates to the astronomical time scale which measures time in Julian day number.}
//'   \item{swe_date_conversion()}{Convert calendar dates to the astronomical time scale which measures time in Julian day
//'   number and checks if the calendar date is legal.}
//'   \item{swe_revjul()}{Compute year, month, day and hour from a Julian day number.}
//' }
//' @examples
//' data(SE)
//' swe_julday(2000,1,1,12,SE$GREG_CAL)
//' swe_date_conversion(2000,1,1,12,"g")
//' swe_revjul(2452500,SE$GREG_CAL)
//' @param year  Astronomical year as integer
//' @param month  Month as integer
//' @param day  Day as integer
//' @param hour  Hour as double
//' @param gregflag  Calendar type as integer (SE$JUL_CAL=0 or SE$GREG_CAL=1)
//' @rdname Section7
//' @export
// [[Rcpp::export(swe_julday)]]
double julday(int year, int month, int day, double hour, int gregflag) {
    double i;
    i = swe_julday(year, month, day, hour, gregflag);
  return i;
}

//' @param cal  Calendar type "g" [Gregorian] or "j" [Julian] as char
//' @return \code{swe_date_conversion} returns a list with named entries: \code{return} status flag as integer,
//'      \code{jd} Julian day number as double
//' @rdname Section7
//' @export
// [[Rcpp::export(swe_date_conversion)]]
Rcpp::List date_conversion(int year, int month, int day, double hour, char cal) {
  double jd;
  int i = swe_date_conversion(year, month, day, hour, cal, &jd);
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("jd") = jd);
}

//' @param jd  Julian day number as double
//' @return \code{swe_revjul} returns a list with named entries: \code{year} year as integer,
//'      \code{month} month as integer, \code{day} day as integer and \code{hour} hour as double.
//' @rdname Section7
//' @export
// [[Rcpp::export(swe_revjul)]]
Rcpp::List revjul(double jd, int gregflag ) {
  int year;
  int month;
  int day;
  double hour;
  swe_revjul(jd, gregflag, &year, &month, &day, &hour);
  return Rcpp::List::create(Rcpp::Named("year") = year,
                            Rcpp::Named("month") = month,
                            Rcpp::Named("day") = day,
                            Rcpp::Named("hour") = hour);
}


//////////////////////////////////////////////////////////////////////////
//' @title Section 8: Delta T-related functions
//' @name Section8
//' @description Functions related to DeltaT and tidal acceleration
//' @seealso Section 8 in \url{http://www.astro.com/swisseph/swephprg.htm}
//' @param ephe_flag  ephemeris flag as integer (SE$FLG_JPLEPH=1, SE$FLG_SWIEPH=2 or SE$FLG_MOSEPH=4) (section 2.3.2)
//' @details
//' \describe{
//' \item{swe_deltat_ex()}{Determine DeltaT from Julian day number for a specific ephemeris.}
//' }
//' @param jd_ut  Julian day number (UT) as numeric vector (day)
//' @param t_acc Tidal acceleration as double (arcsec/century^2)
//' @param delta_t DeltaT (day)
//' @examples
//' data(SE)
//' swe_deltat_ex(1234.567, SE$FLG_MOSEPH)
//' swe_deltat(1234.567)
//' swe_set_tid_acc(1.23)
//' swe_get_tid_acc()
//' swe_set_delta_t_userdef(0.23)
//' @return \code{swe_deltat_ex} returns a list with named entries: \code{deltat} for DeltaT as double (day)
//'          and \code{serr} for error message as string.
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_deltat_ex)]]
Rcpp::List deltat_ex(Rcpp::NumericVector jd_ut, int ephe_flag) {
  Rcpp::NumericVector deltat(jd_ut.length());
  Rcpp::CharacterVector serr_(jd_ut.length());

  for (int i = 0; i < jd_ut.length(); ++i) {
    std::array<char, 256> serr{'\0'};
    deltat(i) = swe_deltat_ex(jd_ut(i), ephe_flag, &serr[0]);
    serr_(i) = std::string(&serr[0]);
  }
  return Rcpp::List::create(Rcpp::Named("deltat") = deltat,
                            Rcpp::Named("serr") = serr_);
}

//' @details
//' \describe{
//' \item{swe_deltat()}{Determine DeltaT from Julian day number for a used ephemeris.
//' This function is only safe if:
//'   \itemize{
//'   \item your software consistently uses the same ephemeris flag
//'   \item if software consistently uses the same ephemeris files (with SE$FLG_SWIEPH and SE$FLG_MOSEPH)
//'   \item if swe_set_ephe_path() is first called (with SE$FLG_SWIEPH) and swe_set_jpl_file() (with SE$FLG_JPLEPH)
//' }
//' }
//' }
//' @return \code{swe_deltat} returns the DeltaT as double (day)
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_deltat)]]
Rcpp::NumericVector deltat(Rcpp::NumericVector jd_ut) {
  Rcpp::NumericVector result(jd_ut.size());
  std::transform(jd_ut.begin(), jd_ut.end(), result.begin(), swe_deltat);
  return result;
}

//' @details
//' \describe{
//' \item{swe_set_tid_acc()}{Set the tidal acceleration.}
//' }
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_set_tid_acc)]]
void set_tid_acc(double t_acc) {
  swe_set_tid_acc(t_acc);
}

//' @details
//' \describe{
//' \item{swe_get_tid_acc()}{Get the present configured tidal acceleration.}
//' }
//' @return \code{swe_get_tid_acc} returns the tidal acceleration as double (arcsec/century^2)
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_get_tid_acc)]]
double get_tid_acc() {
  return swe_get_tid_acc();
}

//' @details
//' \describe{
//' \item{swe_set_delta_t_userdef()}{Allows the user to set a fixed DeltaT value that will
//' be returned by swe_deltat() or swe_deltat_ex().}
//' }
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_set_delta_t_userdef)]]
void set_delta_t_userdef (double delta_t) {
  swe_set_delta_t_userdef (delta_t);
}

//////////////////////////////////////////////////////////////////////////
//' @title Section 9: The function for calculating topocentric planet position
//' @name Section9
//' @description Function for topocentric planet positions
//' @seealso Section 9 in \url{http://www.astro.com/swisseph/swephprg.htm}
//' @details
//' \describe{
//' \item{swe_set_topo()}{Set the topocentric location of the observer.}
//' }
//' @param longitude  Geographic longitude as double (deg)
//' @param lat  Geographic latitude as double (deg)
//' @param height  Height as double (m)
//' @examples
//' swe_set_topo(0,50,10)
//' @rdname Section9
//' @export
// [[Rcpp::export(swe_set_topo)]]
void set_topo(double longitude, double lat, double height) {
  swe_set_topo(longitude, lat, height);
}

//////////////////////////////////////////////////////////////////////////
//' @title Section 10: Sidereal mode functions
//' @name Section10
//' @description Functions to support the determination of siderial information
//' @seealso Section 10 in \url{http://www.astro.com/swisseph/swephprg.htm}
//' @param jd_et  ET Julian day number as double (day)
//' @param jd_ut  UT Julian day number as double (day)
//' @param iflag Computation flag as integer, many options possible (section 2.3)
//' @details
//' \describe{
//' \item{swe_set_sid_mode()}{Set the mode for sidereal computations.}
//' }
//' @param sid_mode  Siderial mode as integer
//' @param t0  Reference date as double (day)
//' @param ayan_to  The initial latitude value of the ayanamsha as double (deg)
//' @examples
//' swe_set_sid_mode(SE$SIDM_FAGAN_BRADLEY,0,0)
//' @rdname Section10
//' @export
// [[Rcpp::export(swe_set_sid_mode)]]
void set_sid_mode(int sid_mode, double t0, double ayan_t0) {
  swe_set_sid_mode(sid_mode, t0, ayan_t0);
}

//' @details
//' \describe{
//' \item{swe_get_ayanamsa_ex_ut()}{It computes ayanamsa using UT.}
//' }
//' @return \code{swe_get_ayanamsa_ex_ut} returns a list with named entries: \code{return} status flag as integer,
//'      \code{daya} ayanamsa value as double and \code{serr} error message as string
//' @examples
//' swe_get_ayanamsa_ex_ut(2458346.82639,SE$FLG_MOSEPH)
//' @rdname Section10
//' @export
// [[Rcpp::export(swe_get_ayanamsa_ex_ut)]]
Rcpp::List get_ayanamsa_ex_ut(double jd_ut, int iflag){
  double daya;
  std::array<char, 256> serr{'\0'};
  int i = swe_get_ayanamsa_ex_ut(jd_ut, iflag,  &daya, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("daya") = daya,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}


//' @details
//' \describe{
//' \item{swe_get_ayanamsa_ex()}{It computes ayanamsa using ET.}
//' }
//' @return \code{swe_get_ayanamsa_ex} returns a list with named entries: \code{return} status flag as integer,
//'      \code{daya} ayanamsa value as double and \code{serr} error message as string
//' @examples
//' swe_get_ayanamsa_ex(2458346.82639,SE$FLG_MOSEPH)
//' @rdname Section10
//' @export
// [[Rcpp::export(swe_get_ayanamsa_ex)]]
Rcpp::List get_ayanamsa_ex(double jd_et, int iflag){
  double daya;
  std::array<char, 256> serr{'\0'};
  int i = swe_get_ayanamsa_ex(jd_et, iflag,  &daya, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("daya") = daya,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}


//////////////////////////////////////////////////////////////////////////
//' @title Section 16.7: Other functions that may be useful
//' @name Section16
//' @description Useful functions
//' @seealso Section 16.7 in \url{http://www.astro.com/swisseph/swephprg.htm}
//' @details
//' \describe{
//'   \item{swe_day_of_week()}{Determine day of week from Julian day number.}
//' }
//' @param jd  Julian day number as numeric vector (day)
//' @return \code{swe_day_of_week} returns the day of week as integer vector (0 Monday .. 6 Sunday)
//' @examples
//' swe_day_of_week(1234.567)
//' @rdname Section16
//' @export
// [[Rcpp::export(swe_day_of_week)]]
Rcpp::IntegerVector day_of_week(Rcpp::NumericVector jd) {
  Rcpp::IntegerVector result(jd.size());
  std::transform(jd.begin(), jd.end(), result.begin(), swe_day_of_week);
  return result;
}
