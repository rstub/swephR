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


//' @title Section 9: The function for calculating topocentric planet position
//' @description Function for topocentric planet positions
//' @seealso \url{http://www.astro.com/swisseph/swephprg.htm#_Toc505244884}
//' @details
//' \describe{
//'   \item{we_set_topo{}}{Set the topocentric location of the observer.}
//' }
//' @param longitude  Geographic longitude as double (deg)
//' @param lat  Geographic latitude as double (deg)
//' @param height  Height as double (m)
//' @examples
//' swe_set_topo(0,50,10)
//' @rdname Section9
//' @export
// [[Rcpp::export(swe_set_topo)]]
void set_topo(double longitude, double lat, double height) {
  swe_set_topo(longitude, lat, height);
}

