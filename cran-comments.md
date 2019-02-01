## Resubmission

This is a resubmission. In this version I have:

* Provided a version of strnlen for Solaris.
* Renamed ERR to SE_ERR.
* Fixed a buffer underrun issue.

These changes were triggered by ERRORs reported by CRAN servers. Since I am
not able to reproduce the corresponding ERRORs, the fixes are made on a
"best effort" basis.

## Test environments

* local Linux install: R 3.5.2
* Ubuntu 16.04 (on Travis CI): R oldrel, release, devel
* Mac OS X (on Travis CI): R release
* Windows (on Appveyor): R release
* Windows (on win-builder): R release, devel

## R CMD check results

0 errors | 0 warnings | 2 notes

* This is a resubmission to fix ERRORs reported on CRAN servers.
* The remark to use angle brackets on the URL is a false positive since the
  URL is part of literal R code.
* Suggested package swephRdata is only available in the 'additional repository'
  https://rstub.github.io/drat
