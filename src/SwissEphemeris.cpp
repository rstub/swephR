#include <Rcpp.h>
#include <swephexp.h>

//' Compute day of week
//' @param jd  Julian date as double
//' @return Day of week as integer
//' @export
// [[Rcpp::export]]
int day_of_week(double jd) {
  return swe_day_of_week(jd);
}
