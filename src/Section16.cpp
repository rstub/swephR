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
#include <swephexp.h>

//' @title Section 16.7: Other functions that may be useful
//' @description Useful functions
//' @seealso \url{http://www.astro.com/swisseph/swephprg.htm#_Toc505244906}
//' @details
//' \describe{
//'   \item{we_day_of_week()}{Determine day of week from Julian day number.}
//' }
//' @param jd  Julian day number as numeric vector (day)
//' @return \code{swe_day_of_week} retruns the day of week as integer vector (0 Monday .. 6 Sunday)
//' @examples
//' swe_day_of_week(1234.567)
//' @rdname Section16
//' @export
// [[Rcpp::export(swe_day_of_week)]]
Rcpp::IntegerVector day_of_week(Rcpp::NumericVector jd) {
  Rcpp::IntegerVector result(jd.size());
  std::transform(jd.begin(), jd.end(), result.begin(), swe_day_of_week);
  return result;
}
