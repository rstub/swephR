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
#include <swephexp.h>

//' @title Miscellaneous functions
//'
//' @description Miscellaneous functions from the C API of the underlying
//'   \code{libswe}.
//' @param path  the directory where the ephemeris files are stored (a string)
//' @param tjd  Julian day Number
//' @param ephe_flag  the epheemris flag (one of SEFLG_SWIEPH=2, SEFLG_JPLEPH=1, SEFLG_MOSEPH=4)
//' @param jd  Julian day as numeric vector
//' @param t_acc tidal acceleration as double (arcsec/century^2)
//' @param delta_t DeltaT value (sec)
//' @param year  Year
//' @param month  Month
//' @param day  Day
//' @param hour  Hour
//' @param gregflag  Gregorian (1) or Julian calandar (0)
//' @return  \code{swe_deltat} returns the DeltaT (sec)
//' @return \code{swe_day_of_week} retruns the day of week as integer vector (Monday = 0, ... Sunday = 6)
//' @return \code{swe_get_tid_acc} returns the tidal acceleration as double (arcsec/century^2)
//' @return \code{swe_version} returns the Swiss Ephemeris version number as string
//' @name misc

//' Set the directory for the sefstar.txt, swe_deltat.txt and jpl files
//' @rdname misc
//' @export
// [[Rcpp::export(swe_set_ephe_path)]]
void set_ephe_path(Rcpp::Nullable<Rcpp::CharacterVector> path) {
  if (path.isNotNull()) {
    swe_set_ephe_path(path.as().at(0));
  } else {
    swe_set_ephe_path(NULL);
  }
}

//' Close Swiss Ephemeris files
//' @rdname misc
//' @export
// [[Rcpp::export(swe_close)]]
void close() {
  swe_close();
}

//' Get the Swiss Ephemeris version number
//' @rdname misc
//' @export
// [[Rcpp::export(swe_version)]]
std::string version() {
  std::array<char, 256> version{'\0'};
  swe_version(&version[0]);
  return std::string(&version[0]);
}


//' Determine DeltaT
//' @return \code{swe_deltat_ex} returns a list with named entries: \code{return} for return value
//'          and \code{serr} for error message.
//' @rdname misc
//' @export
// [[Rcpp::export(swe_deltat_ex)]]
Rcpp::List deltat_ex(Rcpp::NumericVector tjd, int ephe_flag) {
  Rcpp::NumericVector deltat(tjd.length());
  Rcpp::CharacterVector serr_(tjd.length());

  for (int i = 0; i < tjd.length(); ++i) {
    std::array<char, 256> serr{'\0'};
    deltat(i) = swe_deltat_ex(tjd(i), ephe_flag, &serr[0]);
    serr_(i) = std::string(&serr[0]);
  }

  return Rcpp::List::create(Rcpp::Named("deltat") = deltat,
                            Rcpp::Named("serr") = serr_);
}

//' Determine the DeltaT at a certain date
//' @rdname misc
//' @export
// [[Rcpp::export(swe_deltat)]]
Rcpp::NumericVector deltat(Rcpp::NumericVector tjd) {
  Rcpp::NumericVector result(tjd.size());
  std::transform(tjd.begin(), tjd.end(), result.begin(), swe_deltat);
  return result;
}

//' Get the present configured tidal acceleration
//' @rdname misc
//' @export
// [[Rcpp::export(swe_get_tid_acc)]]
double get_tid_acc() {
  return swe_get_tid_acc();
}

//' Set the tidal acceleration
//' @rdname misc
//' @export
// [[Rcpp::export(swe_set_tid_acc)]]
void set_tid_acc(double t_acc) {
  swe_set_tid_acc(t_acc);
}

//' Set one's own DeltaT
//' @rdname misc
//' @export
// [[Rcpp::export(swe_set_delta_t_userdef)]]
void set_delta_t_userdef (double delta_t) {
  swe_set_delta_t_userdef (delta_t);
}



//' Compute day of week
//' @rdname misc
//' @export
// [[Rcpp::export(swe_day_of_week)]]
Rcpp::IntegerVector day_of_week(Rcpp::NumericVector jd) {
  Rcpp::IntegerVector result(jd.size());
  std::transform(jd.begin(), jd.end(), result.begin(), swe_day_of_week);
  return result;
}

//' Determine Julian date number from calendar date
//' @rdname misc
//' @export
// [[Rcpp::export(swe_julday)]]
double julday(int year, int month, int day, double hour, int gregflag) { 
    double i;
    i = swe_julday(year, month, day, hour, gregflag);
  return i;
}

