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

//' @title Eclipses and planetary phenomena
//' Compute solar eclipse at location
//' @param tjd_et  Julian day, Ephemeris time
//' @param ipl  body/planet number (-1 for no planet possible with \code{swe_rise_trans_true_hor})
//' @param iflag  a 32 bit integer containing bit flags that indicate what
//'               kind of computation is wanted
//' @param starname  star name ("" for no star)
//' @param tjd_ut  Julian day, UT time
//' @param calc_flag Type of reference system or SE_TRUE_TO_APP=0 / SE_APP_TO_TRUE=1
//' @param atpress atmospheric pressure in mbar (hPa)
//' @param attemp atmospheric temperature in degrees Celsius
//' @param epheflag Type of ephemeris (4=Moshier, 1=JPL, 2=SE)
//' @param horhgt The apparent horizon at rise/set in degrees
//' @param xin  position of body in either ecliptical or equatorial coordinates, depending on calc_flag
//' @param rsmi  integer specifying that rise, set, or one of the two meridian transits is wanted
//' @return \code{swe_rise_trans_true_hor} returns a list with named entries: \code{i} success of function
//'      \code{tret} for azi/alt info and \code{serr} for possible error code
//' @return \code{swe_azalt} returns a list with named entries:
//'      \code{xaz} for azi/alt info.
//' @return \code{swe_sol_eclipse_when_loc} returns a list with named entries: 
//'      \code{return} visibility code, \code{tret} for eclipse timing moments, 
//'      \code{attr} pheneomena durign eclipse and \code{serr} error string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_sol_eclipse_when_loc)]]
Rcpp::List sol_eclipse_when_loc(double tjd_start, int ifl, Rcpp::NumericVector geopos, bool backward) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 10> tret{0.0};
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_sol_eclipse_when_loc(tjd_start, ifl, geopos.begin(), tret.begin(), attr.begin(), backward, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("tret") = tret,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
    );
}

//' Compute lunar eclipse at location
//' @param ifl Type of ephemeris (one of SEFLG_SWIEPH=2, SEFLG_JPLEPH=1, SEFLG_MOSEPH=4)
//' @param geopos The position vector (longitude, latitude, height)
//' @param backward TRUE for backwards search
//' @return \code{swe_lun_eclipse_when_loc} returns a list with named entries:
//'      \code{return} visibility code, \code{tret} for eclipse timing moments,
//'      \code{attr} pheneomena durign eclipse and \code{serr} error string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_lun_eclipse_when_loc)]]
Rcpp::List lun_eclipse_when_loc(double tjd_start, int ifl, Rcpp::NumericVector geopos, bool backward) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 10> tret{0.0};
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_when_loc(tjd_start, ifl, geopos.begin(), tret.begin(), attr.begin(), backward, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("tret") = tret,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}

//' Search a lunar eclipse on earth
//' @param ifltype Type of eclipse event (SE_ECL_TOTAL etc.  or 0, if any eclipse type)
//' @return \code{swe_lun_eclipse_when} returns a list with named entries:
//'      \code{return} visibility code, \code{tret} for eclipse timing moments
//'      and \code{serr} error string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_lun_eclipse_when)]]
Rcpp::List lun_eclipse_when(double tjd_start, int ifl, int ifltype, bool backward) {
  std::array<double, 20> tret{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_when(tjd_start, ifl, ifltype, tret.begin(), backward, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("tret") = tret,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}

//' Computes the attributes of a lunar eclipse at a given time
//' @param tjd_start  Julian day, UT time
//' @return \code{swe_lun_eclipse_how} returns a list with named entries:
//'      \code{return} visibility code,
//'      \code{attr} pheneomena durign eclipse and \code{serr} error string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_lun_eclipse_how)]]
Rcpp::List lun_eclipse_how(double tjd_start, int ifl, Rcpp::NumericVector geopos) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_lun_eclipse_how(tjd_start, ifl, geopos.begin(), attr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn,
                            Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}






//' Compute the rise and set location of the object
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_rise_trans_true_hor)]]
Rcpp::List rise_trans_true_hor(double tjd_ut, int ipl, std::string starname, int epheflag, int rsmi,Rcpp::NumericVector geopos, double atpress, double attemp, double horhgt) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<char, 256> serr{'\0'};
  double tret;
  starname.resize(41);
  int i = swe_rise_trans_true_hor(tjd_ut, ipl, &starname[0], epheflag, rsmi, geopos.begin(), atpress, attemp, horhgt, &tret, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("tret") = tret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}


//' Provide phenomom information of celestial body (UT)
//' @return \code{swe_pheno_ut} returns a list with named entries:
//'      \code{return} ???, \code{attr} for phenomenon information
//'      and \code{serr} error string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_pheno_ut)]]
Rcpp::List pheno_ut(double tjd_ut, int ipl, int iflag) {
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_pheno_ut(tjd_ut, ipl, iflag, attr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}


//' Provide phenomom information of celestial body (ET)
//' @return \code{swe_pheno} returns a list with named entries:
//'      \code{return} ???, \code{attr} for phenomenon information
//'      and \code{serr} error string
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_pheno)]]
Rcpp::List pheno(double tjd_et, int ipl, int iflag) {
  std::array<double, 20> attr{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_pheno(tjd_et, ipl, iflag, attr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn, Rcpp::Named("attr") = attr,
                            Rcpp::Named("serr") = std::string(serr.begin())
  );
}

//' Compute horizon information: azimuth, altiiude
//' @return \code{swe_azalt} returns a list with named entries:
//'      \code{xaz} for azi/alt info.
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_azalt)]]
Rcpp::List azalt(double tjd_ut, int calc_flag, Rcpp::NumericVector geopos, double atpress, double attemp, Rcpp::NumericVector xin) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 3> xaz{0.0};
  swe_azalt(tjd_ut, calc_flag, geopos.begin(), atpress, attemp, xin.begin(), xaz.begin());
  return Rcpp::List::create(Rcpp::Named("xaz") = xaz);
}

//' Compute equatorial/ecliptical information
//' @return \code{swe_azalt_rev} returns a list with named entries:
//'      \code{xaz} for celestial info.
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_azalt_rev)]]
Rcpp::List azalt_rev(double tjd_ut, int calc_flag, Rcpp::NumericVector geopos, Rcpp::NumericVector xin) {
  if (geopos.length() < 3) Rcpp::stop("Geographic position 'geopos' must have at least length 3");
  std::array<double, 3> xout{0.0};
  swe_azalt_rev(tjd_ut, calc_flag, geopos.begin(), xin.begin(), xout.begin());
  return Rcpp::List::create(Rcpp::Named("xout") = xout);
}

//' Compute the refraction
//' @param InAlt  The object's apparent/topocentric altitude (depending on calc_flag)
//' @param geoheight  The observer's height
//' @param lapse_rate  The lapse rate pK/m]
//' @return \code{swe_refrac_extended} returns a list with named entries: \code{i} success of function
//'      \code{dret} for refraction related calculations (TopoAlt, AppAlt, refraction)
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_refrac_extended)]]
Rcpp::List refrac_extended(double InAlt, double geoheight, double atpress, double attemp, double lapse_rate, int calc_flag) {
  std::array<double, 10> dret{0.0};
  int i = swe_refrac_extended(InAlt,geoheight,atpress,attemp,lapse_rate,calc_flag, dret.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret);
}

//' Compute the heliacale event of celestial object
//' @param tjdstart  Julian day, UT time
//' @param dgeo Geographic position
//' @param datm Atmospheric conditions
//' @param dobs Observer description
//' @param objectname  celectial object
//' @param event_type  event type
//' @param helflag calcuation flag
//' @return \code{swe_heliacal_ut} returns a list with named entries \code{return},
//'         \code{dret} results, and \code{serr} error message.
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_heliacal_ut)]]
Rcpp::List heliacal_ut(double tjdstart, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int event_type, int helflag) {
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int rtn = swe_heliacal_ut(tjdstart, dgeo.begin(),datm.begin(),dobs.begin(),&objectname[0],event_type,helflag, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = rtn,
			    Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' Compute the limiting visibiliy magnitude
//' @return \code{swe_vis_limit_mag} returns a list with named entries: \code{i} success of function
//'      \code{dret} for magnitude info and \code{serr} for possible error code
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_vis_limit_mag)]]
Rcpp::List vis_limit_mag(double tjd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int helflag ){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_vis_limit_mag(tjd_ut, dgeo.begin(), datm.begin(),dobs.begin(), &objectname[0], helflag, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' Compute heliacal event details
//' @return \code{swe_heliacal_pheno_ut} returns a list with named entries: \code{i} success of function
//'      \code{darr} for heliacal details and \code{serr} for possible error code
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_heliacal_pheno_ut)]]
Rcpp::List heliacal_pheno_ut(double tjd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,std::string objectname,int event_type, int helflag ){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> darr{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_heliacal_pheno_ut(tjd_ut, dgeo.begin(), datm.begin(),dobs.begin(), &objectname[0], event_type, helflag, darr.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("darr") = darr,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' Compute heliacal event details
//' @param mag   The object's magnitude
//' @param AziO  The object's azimut
//' @param AltO  The object's altitude
//' @param AziS  The sun's azimut
//' @param AziM  The moon's azimut
//' @param AltM  The moon's altitude
//' @return \code{swe_topo_arcus_visionis} returns a list with named entries: \code{i} success of function
//'      \code{darr} for heliacal details and \code{serr} for possible error code
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_topo_arcus_visionis)]]
Rcpp::List topo_arcus_visionis(double tjd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,int helflag,double mag,double AziO, double AltO,double AziS, double AziM, double AltM){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<char, 256> serr{'\0'};
  double tav;
  int i = swe_topo_arcus_visionis(tjd_ut, dgeo.begin(), datm.begin(),dobs.begin(), helflag, mag,AziO, AltO, AziS,  AziM,  AltM, &tav, serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("tav") = tav,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}

//' Compute heliacal event details
//' @return \code{swe_heliacal_angle} returns a list with named entries: \code{i} success of function
//'      \code{darr} for heliacal angle and \code{serr} for possible error code
//' @rdname eclipse_pheno
//' @export
// [[Rcpp::export(swe_heliacal_angle)]]
Rcpp::List heliacal_angle(double tjd_ut, Rcpp::NumericVector dgeo, Rcpp::NumericVector datm, Rcpp::NumericVector dobs,int helflag,double mag,double AziO, double AziS, double AziM, double AltM){
  if (dgeo.length() < 3) Rcpp::stop("Geographic position 'dgeo' must have at least length 3");
  if (datm.length() < 4) Rcpp::stop("Atmospheric conditions 'datm' must have at least length 4");
  if (dobs.length() < 6) Rcpp::stop("Observer description 'dobs' must have at least length 6");
  std::array<double, 50> dret{0.0};
  std::array<char, 256> serr{'\0'};
  int i = swe_heliacal_angle(tjd_ut, dgeo.begin(), datm.begin(),dobs.begin(), helflag, mag,AziO, AziS,  AziM,  AltM, dret.begin(), serr.begin());
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("dret") = dret,
                            Rcpp::Named("serr") = std::string(serr.begin()));
}
