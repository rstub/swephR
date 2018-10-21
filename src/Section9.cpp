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


//' @title Section 9: The function for topocentric planet positions
//' @description Function for topocentric planet positions
//' @param geolon  geographic longitude as double (deg)
//' @param geolat  geographic latitude as double (deg)
//' @param altitude  height as double (m)
//' @rdname Section9
//' @export
// [[Rcpp::export(swe_set_topo)]]
void set_topo(double geolon, double geolat, double altitude) {
  swe_set_topo(geolon, geolat, altitude);
}

