// Copyright 2018 Ralf Stubner and Victor Reijs
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

//' @title Section 6: Eclipses, Risings, Settings, Meridian Transits, Planetary Phenomena
//' @description Functions for: determining eclipse and occultation calculations, computing the times of rising, setting and 
//' meridian transits for all planets, asteroids, the moon and the fixed stars; computing phase, phase angle, elongation, 
//' apparent diameter, apparent magnitude for the Sun, the Moon, all planets and asteroids; and determing 
//' heliacal phenomenon after a given start date
//' @seealso \url{http://www.astro.com/swisseph/swephprg.htm#_Toc505244853}
//' @param jd_et  ET Julian day number as double (day)
//' @param ipl  body/planet as integer (SE$SUN=0, SE$MOON=1,  ... SE$PLUTO=9)
//' @param starname  star name as string ("" for no star)
//' @param jd_ut  UT Julian day number as double (day)
//' @param calc_flag flag as integer (refraction direction (SE$TRUE_TO_APP=0 or SE$APP_TO_TRUE=1))
//' @param coord_flag flag as integer (reference system (SE$ECL2HOR=0 or SE$EQU2HOR=1)) 
//' @param atpress atmospheric pressure as double (hPa)
//' @param attemp atmospheric temperature as double (Celsius)
//' @param ephe_flag ephemeris flag as integer (SE$FLG_JPLEPH=1, SE$FLG_SWIEPH=2 or SE$FLG_MOSEPH=4)
//' @param horhgt horizon apparent altitude as double (deg)
//' @param xin  position of body as numeric vector (either ecliptical or equatorial coordinates, depending on coord_flag)
//' @param rsmi  event flag as integer (e.g.: SE$CALC_RISE=1, SE$CALC_SET=2,SE$CALC_MTRANSIT=4,SE$CALC_ITRANSIT=8)
//' @details
//' \describe{
//'   \item{swe_sol_eclipse_when_loc()}{Find the next solar eclipse for a given geographic position.}
//'   }
//' @examples
//' SE<-SEConstants()
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
//'      \code{attr} pheneomena during eclipse as numeric vector and \code{serr} error message as string
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
//'      \code{attr} pheneomena during eclipse and \code{serr} error warning as string
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
//'      \code{attr} pheneomena during eclipse as numeric vector and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_lun_eclipse_how)]]
Rcpp::List lun_eclipse_how(double jd_start, int ephe_flag, Rcpp::NumericVector geopos) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have a length of 3");
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_how(jd_start, ephe_flag, geopos.begin(), attr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}


//' @details 
//' \describe{
//' \item{swe_lun_eclipse_when()}{Find the next lunar eclipse on earth.}
//' }
//' @param ifltype eclipse type as integer (e.g.: SE$ECL_CENTRAL=1,SE$ECL_NONCENTRAL=2,SE$ECL_TOTAL=4,SE$ECL_ANNULAR=8,SE$ECL_PARTIAL=16,SE$ECL_ANNULAR_TOTAL=32)
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
//'      \code{tret} for azi/alt info as numeric vector and \code{serr} error message as string
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
//'      \code{xaz} for celestial info a snumeric vector.
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
//' @param geoheight  observer's height as double (m)
//' @param lapse_rate  lapse rate as double (K/m)
//' @return \code{swe_refrac_extended} returns a list with named entries: \code{return} status flag as integer,
//'      \code{dret} refraction results as nemeric vector (TopoAlt, AppAlt, refraction)
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_refrac_extended)]]
Rcpp::List refrac_extended(double InAlt, double geoheight, double atpress, double attemp, double lapse_rate, int calc_flag) {
  std::array<double, 10> dret{0.0};
  double i = swe_refrac_extended(InAlt,geoheight,atpress,attemp,lapse_rate,calc_flag, dret.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret);
}

//' @details 
//' \describe{
//' \item{swe_heliacal_ut()}{Compute the Julian day of the next heliacal phenomenon after a given UT start date. 
//' It works between geographic latitudes 60 South and 60 North.}
//' }
//' @param jd_utstart  UT Julian day number as double (day)
//' @param dgeo Geographic position as numeric vector
//' @param datm Atmospheric conditions as numeric vector
//' @param dobs Observer description as numeric vector
//' @param objectname  name of fixed star or planet as string
//' @param event_type  event type as integer
//' @param helflag calculation flag (incl. ephe_flag values) as integer
//' @return \code{swe_heliacal_ut} returns a list with named entries \code{return} status flag as integer,
//'         \code{dret} heliacal results as numeric vector, and \code{serr} error message as string.
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_heliacal_ut)]]
Rcpp::List heliacal_ut(double jd_utstart, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int event_type, int helflag) {
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have a length of 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
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
//' by swe_vis_limt_mag(), then it is visible.}
//' }
//' @return \code{swe_vis_limit_mag} returns a list with named entries: \code{return} status flag as integer,
//'      \code{dret} limiting magnitude as double and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_vis_limit_mag)]]
Rcpp::List vis_limit_mag(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int helflag ){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have a length of 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
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
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
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
//' @param mag   object's visible magnitude (Vmag) as double (-)
//' @param AziO  object's azimuth as double (deg)
//' @param AltO  object's altitude as double (deg)
//' @param AziS  Sun's azimuth as double (deg)
//' @param AziM  Moon's azimut as double (deg)
//' @param AltM  Moon's altitude as double (deg)
//' @return \code{swe_topo_arcus_visionis} returns a list with named entries: \code{return} status flag as integer,
//'      \code{darr} heliacal details as numeric vector and \code{serr} error message as string
//' @rdname Section6
//' @export
// [[Rcpp::export(swe_topo_arcus_visionis)]]
Rcpp::List topo_arcus_visionis(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,int helflag,double mag,double AziO, double AltO,double AziS, double AziM, double AltM){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have a length of 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
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
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
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

