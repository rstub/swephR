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
int day_of_week(double jd) {
  return swe_day_of_week(jd);
}
