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

// Compute information of star (UT)
// internal function that is called in Section4.R
// [[Rcpp::export]]
Rcpp::List fixstar2_ut(Rcpp::CharacterVector starname, Rcpp::NumericVector jd_ut, int iflag) {
  if (jd_ut.length() != starname.length())
    Rcpp::stop("The number of stars in 'starname' and the number of dates in 'jd_ut' must be identical!");

  Rcpp::IntegerVector rc_(starname.length());
  Rcpp::CharacterVector serr_(starname.length());
  Rcpp::NumericMatrix xx_(starname.length(), 6);

  for (int i = 0; i < starname.length(); ++i) {
    std::array<double, 6> xx{0.0};
    std::array<char, 256> serr{'\0'};
    std::string starname_(starname(i));
    starname_.resize(41);
    rc_(i) = swe_fixstar2_ut(&starname_[0], jd_ut(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
    starname(i) = starname_;
  }

  // remove dim attribute to return a vector
  if (starname.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("starname") = starname,
                            Rcpp::Named("xx") = xx_,
                            Rcpp::Named("serr") = serr_);
}


// Compute information of star (ET)
// internal function that is called in Section4.R
// [[Rcpp::export]]
Rcpp::List fixstar2(Rcpp::CharacterVector starname, Rcpp::NumericVector jd_et, int iflag) {
  if (jd_et.length() != starname.length())
    Rcpp::stop("The number of stars in 'starname' and the number of dates in 'jd_et' must be identical!");

  Rcpp::IntegerVector rc_(starname.length());
  Rcpp::CharacterVector serr_(starname.length());
  Rcpp::NumericMatrix xx_(starname.length(), 6);

  for (int i = 0; i < starname.length(); ++i) {
    std::array<double, 6> xx{0.0};
    std::array<char, 256> serr{'\0'};
    std::string starname_(starname(i));
    starname_.resize(41);
    rc_(i) = swe_fixstar2(&starname_[0], jd_et(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
    starname(i) = starname_;
  }

  // remove dim attribute to return a vector
  if (starname.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("starname") = starname,
                            Rcpp::Named("xx") = xx_,
                            Rcpp::Named("serr") = serr_);
}

//' @details swe_fixstar2_mag(starname)
//' 
//' Calculation visible magnitude (Vmag) of star
//' @return \code{swe_fixstar2_mag} returns a list with named entries \code{return} status flag as interger,
//'         \code{starname} updated star name as string, \code{mag} magnitude of star as double, and \code{serr} for error message as string.
//' @rdname Section4
//' @export
// [[Rcpp::export(swe_fixstar2_mag)]]
Rcpp::List fixstar2_mag(Rcpp::CharacterVector starname) {
  Rcpp::IntegerVector rc_(starname.length());
  Rcpp::CharacterVector serr_(starname.length());
  Rcpp::NumericVector mag_(starname.length());

  for (int i = 0; i < starname.length(); ++i) {
    double mag;
    std::array<char, 256> serr{'\0'};
    std::string starname_(starname(i));
    starname_.resize(41);
    rc_(i) = swe_fixstar2_mag(&starname_[0], &mag, serr.begin());
    mag_(i) = mag;
    serr_(i) = std::string(serr.begin());
    starname(i) = starname_;
  }

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("starname") = starname,
                            Rcpp::Named("mag") = mag_,
                            Rcpp::Named("serr") = serr_);
}

