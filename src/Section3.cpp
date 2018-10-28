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


//' @title Section 3: Find a planetary or asteroid name 
//' @description Find a planetary or asteroid name.
//' @seealso \url{http://www.astro.com/swisseph/swephprg.htm#_Toc505244843}
//' @details
//' \describe{
//'   \item{swe_get_planet_name()}{Convert object number into ubject name.}
//' }
//' @examples
//' swe_get_planet_name(SE_MOON)
//' @param ipl  body/planet as interger (SE_SUN=0, SE_Moon=1,  ... SE_PLUTO=9)
//' @return \code{swe_get_planet_name} returns objectname as string
//' @rdname Section3
//' @export
// [[Rcpp::export(swe_get_planet_name)]]
std::string get_planet_name(int ipl) { 
  std::array<char, 41> objectname{'\0'};
  swe_get_planet_name(ipl,&objectname[0]);
  return std::string(&objectname[0]);
}

