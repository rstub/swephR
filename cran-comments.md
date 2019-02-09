## Resubmission

This is a resubmission for a previously archived package. Changes:

* Use autoconf to reliably checking for the presence of strnlen.
* Fixed a compilation error in the replacement function for strnlen.
* Moved the replacement function for strnlen after the include of string.h.

## Test environments

* local Linux install: R 3.5.2
* Ubuntu 16.04 (on Travis CI): R oldrel, release, devel
* Mac OS X (on Travis CI): R release
* Windows (on Appveyor): R release
* Windows (on win-builder): R release, devel
* Solaris 10 (on r-hub): R patched

## R CMD check results

0 errors | 0 warnings | 2 notes

* This is a resubmission of a previously archived package (see above).
* The remark to use angle brackets on the URL is a false positive since the
  URL is part of literal R code.
* Suggested package swephRdata is only available in the 'additional repository'
  https://rstub.github.io/drat

There is an additional WARNING on Solaris since the setup on r-hub cannot
build the vignette. This appears to be a Solaris on r-hub specific error.