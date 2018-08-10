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
//' @return tidal acceleration as double
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
  char *version = (char*) malloc(256*sizeof(char));
  swe_version(version);
  std::string result(version);
  free(version);
  return result;
}
