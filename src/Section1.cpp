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

//' @title The Ephemeris file related functions
//' @description Several initialisation functions
//' @seealso \url{http://www.astro.com/swisseph/swephprg.htm?lang=g#_Toc505244831}
//' @details
//' \describe{
//'   \item{swe_set_ephe_path()}{This is the first function that should be called
//'        before any other function of the Swiss Ephemeris. Even if you don't
//'        want to set an ephemeris path and use the Moshier ephemeris, it is
//'        nevertheless recommended to call swe_set_ephe_path(NULL), because this
//'        function makes important initializations. If you don't do that, the
//'        Swiss Ephemeris may work, but the results may be not 100\% consistent.}
//'   \item{swe_close()}{At the end of your computations this function releases most
//'        resources (open files and allocated memory) used by Swiss Ephemeris.}
//'   \item{swe_set_jpl_file()}{Set name of JPL ephemeris file.} 
//'   \item{swe_version()}{The function provides the version number of the Swiss Ephemeris software.}
//' }
//' @param path directory for the sefstars.txt, swe_deltat.txt and jpl files
//' @rdname Section1
//' @export
// [[Rcpp::export(swe_set_ephe_path)]]
void set_ephe_path(Rcpp::Nullable<Rcpp::CharacterVector> path) {
  if (path.isNotNull()) {
    swe_set_ephe_path(path.as().at(0));
  } else {
    swe_set_ephe_path(NULL);
  }
}

//' @rdname Section1
//' @export
// [[Rcpp::export(swe_close)]]
void close() {
  swe_close();
}


//' @param fname JPL ephemeris name as string (JPL ephemeris file, e.g. de431.eph)
//' @rdname Section1
//' @export
// [[Rcpp::export(swe_set_jpl_file)]]
void set_jpl_file(Rcpp::Nullable<Rcpp::CharacterVector> fname) {
    swe_set_jpl_file(fname.as().at(0));
 }

//' @return \code{swe_version} returns Swiss Ephemeris software version as string
//' @rdname Section1
//' @export
// [[Rcpp::export(swe_version)]]
std::string version() {
  std::array<char, 256> version{'\0'};
  swe_version(&version[0]);
  return std::string(&version[0]);
}

