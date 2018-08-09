#include <Rcpp.h>

#ifdef __cplusplus
extern "C" {
#endif

/* monday = 0, ... sunday = 6 */
int swe_day_of_week(double jd);

#ifdef __cplusplus
}
#endif

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
