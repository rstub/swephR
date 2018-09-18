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

//' @title Expert interface
//'
//' @description For experts that are familiar with the C API of the underlying
//'   \code{libswe}, an expert interface that mimicks that interface as closely
//'   as possbile is provided.
//' @param jd  Julian date as numeric vector
//' @param t_acc tidal acceleration as double (arcsec/century^2)
//' @param tjd  Julian day Number
//' @param path  the directory where the ephemeris files are stored (a string)
//' @param delta_t DeltaT value (sec)
//' @return  \code{swe_deltat} returns the DeltaT (sec)
//' @return \code{swe_day_of_week} retruns the day of week as integer vector
//' @return \code{get_tid_acc} returns the tidal acceleration as double (arcsec/century^2)
//' @return \code{swe_version} returns the Swiss Ephemeris version number as string
//' @name expert-interface


//' Compute day of week
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_day_of_week)]]
Rcpp::IntegerVector day_of_week(Rcpp::NumericVector jd) {
  Rcpp::IntegerVector result(jd.size());
  std::transform(jd.begin(), jd.end(), result.begin(), swe_day_of_week);
  return result;
}

//' Get the present configured tidal acceleration
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_get_tid_acc)]]
double get_tid_acc() {
  return swe_get_tid_acc();
}

//' Get the Swiss Ephemeris version number
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_version)]]
std::string version() {
  std::array<char, 256> version{'\0'};
  swe_version(&version[0]);
  return std::string(&version[0]);
}

//' Set the tidal acceleration
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_set_tid_acc)]]
void set_tid_acc(double t_acc) {
  swe_set_tid_acc(t_acc);
}

//' Determine the DeltaT at a certain date
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_deltat)]]
Rcpp::NumericVector deltat(Rcpp::NumericVector tjd) {
  Rcpp::NumericVector result(tjd.size());
  std::transform(tjd.begin(), tjd.end(), result.begin(), swe_deltat);
  return result;
}

//' Set the directory for the sefstar.txt, swe_deltat.txt and jpl files
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_set_ephe_path)]]
void set_ephe_path(Rcpp::Nullable<Rcpp::CharacterVector> path) {
  if (path.isNotNull()) {
    swe_set_ephe_path(path.as().at(0));
  } else {
    swe_set_ephe_path(NULL);
  }
}

//' Determine Julian date number from calendar date
//' @param year  Year
//' @param month  Month
//' @param day  Day
//' @param hour  Hour
//' @param gregflag  Greogiran (1) or juian calandar (0)
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_julday)]]
double julday(int year, int month, int day, double hour, int gregflag) { 
    double i;
    i = swe_julday(year, month, day, hour, gregflag);
  return i;
}

//' Set one's own DeltaT
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_set_delta_t_userdef)]]
void set_delta_t_userdef (double delta_t) {
  swe_set_delta_t_userdef (delta_t);
}




//' Determine DeltaT
//' @param ephe_flag  the epheemris flag (one of SEFLG_SWIEPH=2, SEFLG_JPLEPH=1, SEFLG_MOSEPH=4)
//' @return \code{swe_deltat_ex} returns a list with named entries: \code{return} for return value
//'          and \code{serr} for error message.
//' @rdname expert-interface
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


//' Close Swiss Ephemeris files
//' @rdname expert-interface
//' @export
// [[Rcpp::export(swe_close)]]
void close() {
  swe_close();
}
