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

//' @title Eclipses and planetary phenomena and computation of solar eclipse at location
//' @param jd_et  Julian day number as double (ET)
//' @param ipl  body/planet as interger (SE_SUN=0, SE_Moon=1,  ... SE_PLUTO=9)
//' @param starname  star name as string ("" for no star)
//' @param jd_ut  Julian day number (UT)
//' @param calc_flag flag as interger: reference system (e.g.: SEFLG_EQUATORIAL	2048 or ecliptic) or refraction direction (SE_TRUE_TO_APP=0, SE_APP_TO_TRUE=1)
//' @param atpress atmospheric pressure as double (hPa)
//' @param attemp atmospheric temperature as double (Celsius)
//' @param ephe_flag ephemeris flag as integer (SEFLG_JPLEPH=1, SEFLG_SWIEPH=2 or SEFLG_MOSEPH=4)
//' @param horhgt horizon apparent altitude as double (deg)
//' @param xin  position of body as numeric vector (either ecliptical or equatorial coordinates, depending on calc_flag)
//' @param rsmi  event flag as integer (e.g.: SE_CALC_RISE=1, SE_CALC_SET=2,SE_CALC_MTRANSIT=4,SE_CALC_ITRANSIT=8)
//' @return \code{swe_rise_trans_true_hor} returns a list with named entries: \code{return} status flag as interger,
//'      \code{tret} for azi/alt info as numeric vector and \code{serr} error message as string
//' @return \code{swe_azalt} returns a list with named entries:
//'      \code{xaz} for azi/alt info as numeric vector.
//' @return \code{swe_sol_eclipse_when_loc} returns a list with named entries: 
//'      \code{return} status flag as interger, \code{tret} for eclipse timing moments as numeric vector, 
//'      \code{attr} pheneomena during eclipse as numeric vector and \code{serr} error message as string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_sol_eclipse_when_loc)]]
Rcpp::List sol_eclipse_when_loc(double jd_start, int ephe_flag, Rcpp::NumericVector geopos, bool backward) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 10> tret{0.0};
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_sol_eclipse_when_loc(jd_start, ephe_flag, geopos.begin(), tret.begin(), attr.begin(), backward, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("tret") = tret,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
    );
}

//' Compute lunar eclipse at location
//' @param geopos The position numeric vector (longitude, latitude, height)
//' @param backward backwards search as boolean (TRUE)
//' @return \code{swe_lun_eclipse_when_loc} returns a list with named entries:
//'      \code{return} status flag as integer, \code{tret} for eclipse timing moments,
//'      \code{attr} pheneomena during eclipse and \code{serr} error warning as string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_lun_eclipse_when_loc)]]
Rcpp::List lun_eclipse_when_loc(double jd_start, int ephe_flag, Rcpp::NumericVector geopos, bool backward) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 10> tret{0.0};
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_when_loc(jd_start, ephe_flag, geopos.begin(), tret.begin(), attr.begin(), backward, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("tret") = tret,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}

//' Computes the attributes of a lunar eclipse at a given time
//' @param jd_start  Julian day number (UT)
//' @return \code{swe_lun_eclipse_how} returns a list with named entries:
//'      \code{return} status flag as integer,
//'      \code{attr} pheneomena during eclipse as numeric vector and \code{serr} error message as string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_lun_eclipse_how)]]
Rcpp::List lun_eclipse_how(double jd_start, int ephe_flag, Rcpp::NumericVector geopos) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_how(jd_start, ephe_flag, geopos.begin(), attr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}


//' Search a lunar eclipse on earth
//' @param ifltype eclipse tper as interger (e.g.: SE_ECL_CENTRAL=1,SE_ECL_NONCENTRAL=2,SE_ECL_TOTAL=4,SE_ECL_ANNULAR=8,SE_ECL_PARTIAL=16,SE_ECL_ANNULAR_TOTAL=32)
//' @return \code{swe_lun_eclipse_when} returns a list with named entries:
//'      \code{return} status flag as interger, \code{tret} for eclipse timing moments as numeric vector
//'      and \code{serr} error warning as string
//' @rdname eclipse_pheno
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

//' Compute the rise and set location of the object
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_rise_trans_true_hor)]]
Rcpp::List rise_trans_true_hor(double jd_ut, int ipl, std::string starname, int ephe_flag, int rsmi,Rcpp::NumericVector geopos, double atpress, double attemp, double horhgt) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<char, 256> serr{'\0'};
  double tret;
  starname.resize(41);
  int i = swe_rise_trans_true_hor(jd_ut, ipl, &starname[0], ephe_flag, rsmi, geopos.begin(), atpress, attemp, horhgt, &tret, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("tret") = tret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}


//' Compute horizon information: azimuth, altiiude
//' @return \code{swe_azalt} returns a list with named entries:
//'      \code{xaz} for azi/alt info as numeric vector.
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_azalt)]]
Rcpp::List azalt(double jd_ut, int calc_flag, Rcpp::NumericVector geopos, double atpress, double attemp, Rcpp::NumericVector xin) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 3> xaz{0.0};
  swe_azalt(jd_ut, calc_flag, geopos.begin(), atpress, attemp, xin.begin(), xaz.begin());
  return Rcpp::List::create(Rcpp::Named("xaz") = xaz);
}

//' Compute equatorial/ecliptical information
//' @return \code{swe_azalt_rev} returns a list with named entries:
//'      \code{xaz} for celestial info a snumeric vector.
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_azalt_rev)]]
Rcpp::List azalt_rev(double jd_ut, int calc_flag, Rcpp::NumericVector geopos, Rcpp::NumericVector xin) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 3> xout{0.0};
  swe_azalt_rev(jd_ut, calc_flag, geopos.begin(), xin.begin(), xout.begin());
  return Rcpp::List::create(Rcpp::Named("xout") = xout);
}

//' Provide phenomom information of celestial body (UT)
//' @return \code{swe_pheno_ut} returns a list with named entries:
//'      \code{return} status fag as integer, \code{attr} for phenomenon information as numeric vector
//'      and \code{serr} error warning as string
//' @rdname eclipse_pheno
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


//' Provide phenomom information of celestial body (ET)
//' @return \code{swe_pheno} returns a list with named entries:
//'      \code{return} status fag as integer, \code{attr} for phenomenon information as numeric vector
//'      and \code{serr} error message as string
//' @rdname eclipse_pheno
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

//' Compute heliacal phenomena
//' @return \code{swe_heliacal_pheno_ut} returns a list with named entries: \code{return} status flag as integer
//'      \code{darr} for heliacal details as numeric vector and \code{serr} error message as string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_heliacal_pheno_ut)]]
Rcpp::List heliacal_pheno_ut(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int event_type, int helflag ){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> darr{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_heliacal_pheno_ut(jd_ut, dgeo.begin(), datm.begin(),dobs.begin(), &objectname[0], event_type, helflag, darr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("darr") = darr,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' Compute topocentric arcus visionis
//' @param mag   object's magnitude as double (-)
//' @param AziO  object's azimuth as double (deg)
//' @param AltO  object's altitude as double (deg)
//' @param AziS  Sun's azimuth as double (deg)
//' @param AziM  Moon's azimut as double (deg)
//' @param AltM  Moon's altitude as double (deg)
//' @return \code{swe_topo_arcus_visionis} returns a list with named entries: \code{return} status flag as integer,
//'      \code{darr} heliacal details as numeric vector and \code{serr} error message as string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_topo_arcus_visionis)]]
Rcpp::List topo_arcus_visionis(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,int helflag,double mag,double AziO, double AltO,double AziS, double AziM, double AltM){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<char, 256> serr{'\0'};
  double tav;
  int i = swe_topo_arcus_visionis(jd_ut, dgeo.begin(), datm.begin(),dobs.begin(), helflag, mag,AziO, AltO, AziS,  AziM,  AltM, &tav, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("tav") = tav,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' Compute heliacal angle
//' @return \code{swe_heliacal_angle} returns a list with named entries: \code{return} status flag as integer,
//'      \code{dret} heliacal angle as numeric vector and \code{serr} error message as string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_heliacal_angle)]]
Rcpp::List heliacal_angle(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,int helflag,double mag,double AziO, double AziS, double AziM, double AltM){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_heliacal_angle(jd_ut, dgeo.begin(), datm.begin(),dobs.begin(), helflag, mag,AziO, AziS,  AziM,  AltM, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}
//' Compute the heliacale event of celestial object
//' @param jdstart  Julian day number as double (UT)
//' @param dgeo Geographic position as numeric vector
//' @param datm Atmospheric conditions as numeric vector
//' @param dobs Observer description as numeric vector
//' @param objectname  celectial object as string
//' @param event_type  event type as integer
//' @param helflag calcuation flag as integer
//' @return \code{swe_heliacal_ut} returns a list with named entries \code{return} status flag as integer,
//'         \code{dret} heliacal results as numeric vector, and \code{serr} error message as string.
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_heliacal_ut)]]
Rcpp::List heliacal_ut(double jdstart, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int event_type, int helflag) {
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_heliacal_ut(jdstart, dgeo.begin(),datm.begin(),dobs.begin(),&objectname[0],event_type,helflag, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn,
			    Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' Compute the limiting visibiliy magnitude
//' @return \code{swe_vis_limit_mag} returns a list with named entries: \code{return} status flag as interger,
//'      \code{dret} limiting magnitude as double and \code{serr} error message as string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_vis_limit_mag)]]
Rcpp::List vis_limit_mag(double jd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int helflag ){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_vis_limit_mag(jd_ut, dgeo.begin(), datm.begin(),dobs.begin(), &objectname[0], helflag, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' Compute the refraction
//' @param InAlt  object's apparent/topocentric altitude as double (depending on calc_flag) (deg)
//' @param geoheight  observer's height as double (m)
//' @param lapse_rate  lapse rate as double (K/m)
//' @return \code{swe_refrac_extended} returns a list with named entries: \code{return} status flag as interger,
//'      \code{dret} refraction results as nemeric vector (TopoAlt, AppAlt, refraction)
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_refrac_extended)]]
Rcpp::List refrac_extended(double InAlt, double geoheight, double atpress, double attemp, double lapse_rate, int calc_flag) {
  std::array<double, 10> dret{0.0};
  double i = swe_refrac_extended(InAlt,geoheight,atpress,attemp,lapse_rate,calc_flag, dret.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret);
}
