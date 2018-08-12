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

