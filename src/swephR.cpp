#include <Rcpp.h>
#include "swephapi.h"

//' Compute day of week
//' @param jd  Julian date as double
//' @return Day of week as integer
//' @export
// [[Rcpp::export]]
Rcpp::IntegerVector day_of_week(Rcpp::NumericVector jd) {
  Rcpp::IntegerVector result(jd.size());
  std::transform(jd.begin(), jd.end(), result.begin(), swe_day_of_week);
  return result;
}

//' Get the present configured tidal acceleration
//' @return tidal acceleration as double (arcsec/century^2)
//' @export
// [[Rcpp::export]]
double get_tid_acc() {
  return swe_get_tid_acc();
}

//' Get the Swiss Ephemeris version number
//' @return Swiss Ephemeris version number as string
//' @export
// [[Rcpp::export]]
std::string version() {
  std::array<char, 256> version;
  swe_version(&version[0]);
  return std::string(&version[0]);
}

//' Set the tidal acceleration
//' @param t_acc tidal acceleration as double (arcsec/century^2)
//' @export
// [[Rcpp::export]]
void set_tid_acc(double t_acc) {
  swe_set_tid_acc(t_acc);
}

//' Determine the DeltaT at a certain date
//' @param tjd  Julian day Number
//' @return  DeltaT (sec)
//' @export
// [[Rcpp::export]]
double deltat(double tjd) {
  return swe_deltat(tjd);
}

//' Set the directory for the sefstar.txt, swe_deltat.txt and jpl files
//' @param file  the directory plus file (a string)
//' @export
// [[Rcpp::export]]
void set_ephe_path(std::string file) {
  swe_set_ephe_path(&file[0]);
}

//' Set the topocentric location (lon, lat, height)
//' @param geolon  Topocentric Longitude (deg)
//' @param geolat  Topocentric Latitude (deg)
//' @param altitude  the height (m)
//' @export
// [[Rcpp::export]]
void set_topo(double geolon, double geolat, double altitude) {
  swe_set_topo(geolon, geolat, altitude);
}

//' Set one's own DeltaT
//' @param t_acc DeltaT value (sec)
//' return void
//' @export
// [[Rcpp::export]]
void set_delta_t_userdef (double t_acc) {
  swe_set_delta_t_userdef (t_acc);
}

