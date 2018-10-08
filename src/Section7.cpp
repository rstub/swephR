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
#include <array>
#include "swephapi.h"

//' @title Expert interface: miscellanious functions
//'
//' @description For experts that are familiar with the C API of the underlying
//'   \code{libswe}, an expert interface that mimicks that interface as closely
//'   as possbile is provided.
//' @param jd  Julian day number as numeric vector (day)
//' @param t_acc tidal acceleration as double (arcsec/century^2)
//' @param path  directory as string, where the ephemeris files are stored
//' @param delta_t DeltaT (day)
//' @return \code{swe_day_of_week} retruns the day of week as integer vector (0 Monday .. 6 Sunday)
//' @return \code{swe_get_tid_acc} returns the tidal acceleration as double (arcsec/century^2)
//' @return \code{swe_version} returns the Swiss Ephemeris version number as string
//' @return \code{swe_deltat} returns the DeltaT as double (day)
//' @name expert-interface


//' Determine Julian day number from calendar date
//' @param year  Year as interger
//' @param month  Month as interger
//' @param day  Day as interger
//' @param hour  Hour as double
//' @param gregflag  calendar type (SE_JUL_CAL=0 or SE_GREG_CAL=1)
//' @rdname Section7
//' @export
// [[Rcpp::export(swe_julday)]]
double julday(int year, int month, int day, double hour, int gregflag) { 
    double i;
    i = swe_julday(year, month, day, hour, gregflag);
  return i;
}
