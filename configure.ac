#                                               -*- Autoconf -*-
# Copyright (C) 2019 Ralf Stubner
#
# This file is part of swephR.
#
# swephR is free software: you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# swephR is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with swephR.  If not, see <http://www.gnu.org/licenses/>.
#
# Process this file with autoconf to produce a configure script.
AC_PREREQ([2.69])
AC_INIT([swephR], [0.1.5])

: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}" ; then
    echo "could not determin R_HOME"
    exit 1
fi

# get various settings from R and check if we can use them for compilation
AC_MSG_CHECKING(for R < 3.4.0 for CXX1X flag use)
R_GE_34=`"${R_HOME}/bin/R" --vanilla --slave -e 'cat(if (getRversion() >= numeric_version("3.4.0")) "yes" else "no")'`
if test "x$R_GE_34" == "xyes"; then
   AC_MSG_RESULT([no])
   CXX11=`"${R_HOME}/bin/R" CMD config CXX11`
   CXX11STD=`"${R_HOME}/bin/R" CMD config CXX11STD`
   CXXFLAGS=`"${R_HOME}/bin/R" CMD config CXX11FLAGS`
else
   AC_MSG_RESULT([yes])
   CXX11=`"${R_HOME}/bin/R" CMD config CXX1X`
   CXX11STD=`"${R_HOME}/bin/R" CMD config CXX1XSTD`
   CXXFLAGS=`"${R_HOME}/bin/R" CMD config CXX1XFLAGS`
fi
CXX="${CXX11} ${CXX11STD}"
CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`
CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
CC=`"${R_HOME}/bin/R" CMD config CC`

AC_REQUIRE_CPP
AC_LANG(C)
AC_PROG_CC
AC_LANG(C++)
AC_PROG_CXX

# check for strnlen missing on Solaris
AC_CHECK_FUNCS(strnlen)

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
