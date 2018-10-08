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



//' @title Section 8: Delta T-related functions
//' @description FUnctions rleated to DeltaT and tidal acceleration
//' @param ephe_flag  ephemeris flag as integer (SEFLG_JPLEPH=1, SEFLG_SWIEPH=2 or SEFLG_MOSEPH=4) (section 2.3.2)
//' @param jd_ut  Julian day number (UT) as numeric vector (day)
//' @param t_acc tidal acceleration as double (arcsec/century^2)
//' @param delta_t DeltaT (day)
//' @return \code{swe_deltat_ex} returns a list with named entries: \code{deltat} for DeltaT as double (day)
//'          and \code{serr} for error message as string.
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_deltat_ex)]]
Rcpp::List deltat_ex(Rcpp::NumericVector jd_ut, int ephe_flag) {
  Rcpp::NumericVector deltat(jd_ut.length());
  Rcpp::CharacterVector serr_(jd_ut.length());
  
  for (int i = 0; i < jd_ut.length(); ++i) {
    std::array<char, 256> serr{'\0'};
    deltat(i) = swe_deltat_ex(jd_ut(i), ephe_flag, &serr[0]);
    serr_(i) = std::string(&serr[0]);
  }
  return Rcpp::List::create(Rcpp::Named("deltat") = deltat,
                            Rcpp::Named("serr") = serr_);
}

//' Determine the DeltaT at a certain date
//' @return \code{swe_deltat} returns the DeltaT as double (day)
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_deltat)]]
Rcpp::NumericVector deltat(Rcpp::NumericVector jd_ut) {
  Rcpp::NumericVector result(jd_ut.size());
  std::transform(jd_ut.begin(), jd_ut.end(), result.begin(), swe_deltat);
  return result;
}

//' Set the tidal acceleration
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_set_tid_acc)]]
void set_tid_acc(double t_acc) {
  swe_set_tid_acc(t_acc);
}

//' Get the present configured tidal acceleration
//' @return \code{swe_get_tid_acc} returns the tidal acceleration as double (arcsec/century^2)
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_get_tid_acc)]]
double get_tid_acc() {
  return swe_get_tid_acc();
}

//' Set one's own DeltaT
//' @rdname Section8
//' @export
// [[Rcpp::export(swe_set_delta_t_userdef)]]
void set_delta_t_userdef (double delta_t) {
  swe_set_delta_t_userdef (delta_t);
}


