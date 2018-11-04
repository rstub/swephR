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


//' @title Section 7: Date and time conversion functions 
//' @description Functions related to calendar and time conversions.
//' @seealso \url{http://www.astro.com/swisseph/swephprg.htm#_Toc505244873}
//' @details
//' \describe{
//'   \item{swe_julday()}{Convert calendar dates to the astronomical time scale which measures time in Julian day number.}
//' }
//' @examples
//' SE<-SEConstants()
//' swe_julday(2000,1,1,12,SE$GREG_CAL)
//' @param year  Year as integer
//' @param month  Month as integer
//' @param day  Day as integer
//' @param hour  Hour as double
//' @param gregflag  calendar type (SE$JUL_CAL=0 or SE$GREG_CAL=1)
//' @rdname Section7
//' @export
// [[Rcpp::export(swe_julday)]]
double julday(int year, int month, int day, double hour, int gregflag) { 
    double i;
    i = swe_julday(year, month, day, hour, gregflag);
  return i;
}

