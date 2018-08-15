#include <Rcpp.h>
#include "swephapi.h"

//' Expert interface
//'
//' For experts that are familiar with the C API of the underlying \code{libswe},
//' an expert interface that mimicks that interface as closely as possbile is
//' provided.
//' @name expert-interface


//' Compute day of week
//' @param jd  Julian date as numeric vector
//' @return \code{swe_day_of_week} retruns the day of week as integer vector
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_day_of_week)]]
Rcpp::IntegerVector day_of_week(Rcpp::NumericVector jd) {
  Rcpp::IntegerVector result(jd.size());
  std::transform(jd.begin(), jd.end(), result.begin(), swe_day_of_week);
  return result;
}

//' Get the present configured tidal acceleration
//' @return tidal acceleration as double (arcsec/century^2)
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_get_tid_acc)]]
double get_tid_acc() {
  return swe_get_tid_acc();
}

//' Get the Swiss Ephemeris version number
//' @return Swiss Ephemeris version number as string
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_version)]]
std::string version() {
  std::array<char, 256> version;
  swe_version(&version[0]);
  return std::string(&version[0]);
}

//' Set the tidal acceleration
//' @param t_acc tidal acceleration as double (arcsec/century^2)
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_set_tid_acc)]]
void set_tid_acc(double t_acc) {
  swe_set_tid_acc(t_acc);
}

//' Determine the DeltaT at a certain date
//' @param tjd  Julian day Number
//' @return  DeltaT (sec)
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_deltat)]]
double deltat(double tjd) {
  return swe_deltat(tjd);
}

//' Set the directory for the sefstar.txt, swe_deltat.txt and jpl files
//' @param file  the directory plus file (a string)
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_set_ephe_path)]]
void set_ephe_path(std::string file) {
  swe_set_ephe_path(&file[0]);
}

//' Set the topocentric location (lon, lat, height)
//' @param geolon  Topocentric Longitude (deg)
//' @param geolat  Topocentric Latitude (deg)
//' @param altitude  the height (m)
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_set_topo)]]
void set_topo(double geolon, double geolat, double altitude) {
  swe_set_topo(geolon, geolat, altitude);
}

//' Set one's own DeltaT
//' @param delta_t DeltaT value (sec)
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_set_delta_t_userdef)]]
void set_delta_t_userdef (double delta_t) {
  swe_set_delta_t_userdef (delta_t);
}

//' Compute information of planet
//' @param tjd_et  Julian day, Ephemeris time
//' @param ipl  body number
//' @param iflag  a 32 bit integer containing bit flags that indicate what
//'               kind of computation is wanted
//' @return \code{swe_calc} returns a list with named entries \code{rc},
//'         \code{xx}, and \code{serr} for return code, calculated values
//'         and error message.
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_calc)]]
Rcpp::List calc(double tjd_et, int ipl, int iflag = 4) {
  std::array<double, 6> xx;
  std::array<char, 256> serr;
  int rc = swe_calc(tjd_et, ipl, iflag, &xx[0], &serr[0]);
  return Rcpp::List::create(Rcpp::Named("return") = rc,
			    Rcpp::Named("xx") = xx,
			    Rcpp::Named("serr") = std::string(&serr[0]));
}


//' Compute information of stars
//' @param star  star name
//' @param tjd_et  Julian day, Ephemeris time
//' @param iflag  a 32 bit integer containing bit flags that indicate what
//'               kind of computation is wanted
//' @return \code{swe_fixstar} returns a list with named entries \code{return},
//'         \code{star}, \code{xx}, and \code{serr} for return code, updated star name, 
//'         calculated values and error message.
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_fixstar)]]
Rcpp::List fixstar(std::string star, double tjd_et, int iflag = 4) {
  std::array<double, 6> xx;
  std::array<char, 256> serr;
  star.resize(41);
  int rtn = swe_fixstar(&star[0], tjd_et, iflag, &xx[0], &serr[0]);
  return Rcpp::List::create(Rcpp::Named("return") = rtn,
                            Rcpp::Named("star") = std::string(&star[0]),
                            Rcpp::Named("xx") = xx,
                            Rcpp::Named("serr") = std::string(&serr[0]));
}

//' Compute horizon information: azimuth, altiiude
//' @param tjd_ut  Julian day, UT time
//' @param calc_flag Type of reference system
//' @param geopoas The position vector (longitude, latitude, height)
//' @param atpress atmospheric pressure in mbar (hPa)
//' @param attemp atmospheric temperature in degrees Celsius
//' @return \code{swe_azalt} returns a list with named entries: 
//'      \code{xaz} for azi/alt info.
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_azalt)]]
Rcpp::List azalt(double tjd_ut, int calc_flag, Rcpp::NumericVector geopos, double atpress, double attemp, Rcpp::NumericVector xin) {
  std::array<double, 3> xaz;
  swe_azalt(tjd_ut, calc_flag, &geopos[0], atpress, attemp, &xin[0], &xaz[0]);
  return Rcpp::List::create(Rcpp::Named("xaz") = xaz);
}

//' Compute the rise and set location of the object
//' @param tjd_ut  Julian day, UT time
//' @param ipl Plant number (otherwise -1)
//' @param starname The name of the star (otherwise "")
//' @param epheflag Type of ephemeris (4=Moshier, 1=JPL, 2=SE)
//' @param geopoas The position vector (longitude, latitude, height)
//' @param atpress atmospheric pressure in mbar (hPa)
//' @param attemp atmospheric temperature in degrees Celsius
//' @param horhgt The apparent horizon at rise/set in degrees
//' @return \code{swe_rise_trans_true_hor} returns a list with named entries: \code{i} success of function
//'      \code{tret} for azi/alt info and \code{serr} for possible error code
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_rise_trans_true_hor)]]
Rcpp::List rise_trans_true_hor(double tjd_ut, int ipl, std::string starname, int epheflag, int rsmi,Rcpp::NumericVector geopos, double atpress, double attemp, double horhgt) {
  std::array<char, 256> serr;
  double tret;
  int i = swe_rise_trans_true_hor(tjd_ut, ipl, &starname[0], epheflag, rsmi, &geopos[0], atpress, attemp, horhgt, &tret, &serr[0]);
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("tret") = tret,
                            Rcpp::Named("serr") = std::string(&serr[0]));
}
