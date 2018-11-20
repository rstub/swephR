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
//'   \item{swe_date_conversion()}{Convert calendar dates to the astronomical time scale which measures time in Julian day 
//'   number and checks if the calendar date is legal.}
//'   \item{swe_revjul()}{Compute year, month, day and hour from a Julian day number.}
//' }
//' @examples
//' data(SE)
//' swe_julday(2000,1,1,12,SE$GREG_CAL)
//' swe_date_conversion(2000,1,1,12,"g")
//' swe_revjul(2452500,SE$GREG_CAL)
//' @param year  Year as integer
//' @param month  Month as integer
//' @param day  Day as integer
//' @param hour  Hour as double
//' @param gregflag  Calendar type (SE$JUL_CAL=0 or SE$GREG_CAL=1)
//' @rdname Section7
//' @export
// [[Rcpp::export(swe_julday)]]
double julday(int year, int month, int day, double hour, int gregflag) { 
    double i;
    i = swe_julday(year, month, day, hour, gregflag);
  return i;
}

//' @param cal  Calendar type "g"[regorian] or "j"[ulian] 
//' @return \code{swe_date_conversion} returns a list with named entries: \code{return} status flag as integer,
//'      \code{jd} Julian day number as double
//' @rdname Section7
//' @export
// [[Rcpp::export(swe_date_conversion)]]
Rcpp::List date_conversion(int year, int month, int day, double hour, char cal) { 
  double jd;
  int i = swe_date_conversion(year, month, day, hour, cal, &jd);
  return Rcpp::List::create(Rcpp::Named("return") = i,
                            Rcpp::Named("jd") = jd);
}

//' @param jd  Julian day number as double
//' @return \code{swe_revjul} returns a list with named entries: \code{year} year as integer,
//'      \code{month} month as interger, \code{day} day as integer and \code{hour} hour as double.
//' @rdname Section7
//' @export
// [[Rcpp::export(swe_revjul)]]
Rcpp::List revjul(double jd, int gregflag ) { 
  int year;
  int month;
  int day;
  double hour;
  swe_revjul(jd, gregflag, &year, &month, &day, &hour);
  return Rcpp::List::create(Rcpp::Named("year") = year,
                            Rcpp::Named("month") = month,
                            Rcpp::Named("day") = day,
                            Rcpp::Named("hour") = hour);
}
