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

//it seems the below can't be added by using ' after the two /
// @title  Expert interface: Planet and star phenomena
// @param iflag flag as interger, many options possible (section 2.3)
// @param jd_et  ET Julian day number as double (day)
// @param ipl  body/planet as interger (SE_SUN=0, SE_Moon=1,  ... SE_PLUTO=9)
// @param star  star name as string ("" for no star)
// @param jd_ut  UT Julian day number (day)

// Compute information of planet (UT)
// [[Rcpp::export]]
Rcpp::List calc_ut(Rcpp::NumericVector jd_ut, Rcpp::IntegerVector ipl, int iflag) {
  if (jd_ut.length() != ipl.length())
    Rcpp::stop("The number of bodies in 'ipl' and the number of dates in 'jd_ut' must be identical!");

  Rcpp::IntegerVector rc_(ipl.length());
  Rcpp::CharacterVector serr_(ipl.length());
  Rcpp::NumericMatrix xx_(ipl.length(), 6);

  for (int i = 0; i < ipl.length(); ++i) {
    std::array<double, 6> xx{0.0};
    std::array<char, 256> serr{'\0'};
    rc_(i) = swe_calc_ut(jd_ut[i], ipl(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
  }

  // remove dim attribute to return a vector
  if (ipl.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
			    Rcpp::Named("xx") = xx_,
			    Rcpp::Named("serr") = serr_);
}

// Compute information of planet (ET)
// [[Rcpp::export]]
Rcpp::List calc(Rcpp::NumericVector jd_et, Rcpp::IntegerVector ipl, int iflag) {
  if (jd_et.length() != ipl.length())
    Rcpp::stop("The number of bodies in 'ipl' and the number of dates in 'jd_et' must be identical!");

  Rcpp::IntegerVector rc_(ipl.length());
  Rcpp::CharacterVector serr_(ipl.length());
  Rcpp::NumericMatrix xx_(ipl.length(), 6);

  for (int i = 0; i < ipl.length(); ++i) {
    std::array<double, 6> xx{0.0};
    std::array<char, 256> serr{'\0'};
    rc_(i) = swe_calc(jd_et[i], ipl(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
  }
  // remove dim attribute to return a vector
  if (ipl.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("xx") = xx_,
                            Rcpp::Named("serr") = serr_);
}

// Compute information of star (UT)
// [[Rcpp::export]]
Rcpp::List fixstar2_ut(Rcpp::CharacterVector star, Rcpp::NumericVector jd_ut, int iflag) {
  if (jd_ut.length() != star.length())
    Rcpp::stop("The number of stars in 'star' and the number of dates in 'jd_ut' must be identical!");

  Rcpp::IntegerVector rc_(star.length());
  Rcpp::CharacterVector serr_(star.length());
  Rcpp::NumericMatrix xx_(star.length(), 6);

  for (int i = 0; i < star.length(); ++i) {
    std::array<double, 6> xx{0.0};
    std::array<char, 256> serr{'\0'};
    std::string star_(star(i));
    star_.resize(41);
    rc_(i) = swe_fixstar2_ut(&star_[0], jd_ut(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
    star(i) = star_;
  }

  // remove dim attribute to return a vector
  if (star.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("star") = star,
                            Rcpp::Named("xx") = xx_,
                            Rcpp::Named("serr") = serr_);
}


// Compute information of star (ET)
// [[Rcpp::export]]
Rcpp::List fixstar2(Rcpp::CharacterVector star, Rcpp::NumericVector jd_et, int iflag) {
  if (jd_et.length() != star.length())
    Rcpp::stop("The number of stars in 'star' and the number of dates in 'jd_et' must be identical!");

  Rcpp::IntegerVector rc_(star.length());
  Rcpp::CharacterVector serr_(star.length());
  Rcpp::NumericMatrix xx_(star.length(), 6);

  for (int i = 0; i < star.length(); ++i) {
    std::array<double, 6> xx{0.0};
    std::array<char, 256> serr{'\0'};
    std::string star_(star(i));
    star_.resize(41);
    rc_(i) = swe_fixstar2(&star_[0], jd_et(i), iflag, xx.begin(), serr.begin());
    Rcpp::NumericVector tmp(xx.begin(), xx.end());
    xx_(i, Rcpp::_) = tmp;
    serr_(i) = std::string(serr.begin());
    star(i) = star_;
  }

  // remove dim attribute to return a vector
  if (star.length() == 1)
    xx_.attr("dim") = R_NilValue;

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("star") = star,
                            Rcpp::Named("xx") = xx_,
                            Rcpp::Named("serr") = serr_);
}

//' Calculation magnitude of star
//' @return \code{swe_fixstar2_mag} returns a list with named entries \code{return} status flag as interger,
//'         \code{star} updated star name as string, \code{mag} magnitude of star as double, and \code{serr} for error message as string.
//' @rdname calculation
//' @export
// [[Rcpp::export(swe_fixstar2_mag)]]
Rcpp::List fixstar2_mag(Rcpp::CharacterVector star) {
  Rcpp::IntegerVector rc_(star.length());
  Rcpp::CharacterVector serr_(star.length());
  Rcpp::NumericVector mag_(star.length());

  for (int i = 0; i < star.length(); ++i) {
    double mag;
    std::array<char, 256> serr{'\0'};
    std::string star_(star(i));
    star_.resize(41);
    rc_(i) = swe_fixstar2_mag(&star_[0], &mag, serr.begin());
    mag_(i) = mag;
    serr_(i) = std::string(serr.begin());
    star(i) = star_;
  }

  return Rcpp::List::create(Rcpp::Named("return") = rc_,
                            Rcpp::Named("star") = star,
                            Rcpp::Named("mag") = mag_,
                            Rcpp::Named("serr") = serr_);
}

//' Set the geographic location
//' @rdname calculation
//' @param geolon  geographic longitude as double (deg)
//' @param geolat  geographic latitude as double (deg)
//' @param altitude  height as double (m)
//' @export
// [[Rcpp::export(swe_set_topo)]]
void set_topo(double geolon, double geolat, double altitude) {
  swe_set_topo(geolon, geolat, altitude);
}

// to be added in future:
// swe_get_planet_name()
// Kepler elements (section 5)