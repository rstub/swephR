## Test environments

* local Linux install: R 3.6.1
* Ubuntu 16.04 (on Travis CI): R oldrel, release, devel
* Mac OS X (on Travis CI): R release
* Windows (on Appveyor): R release
* Windows (on win-builder): R devel
* Solaris 10 (on r-hub): R patched

## R CMD check results

0 errors | 0 warnings | 2 notes

* The remark to use angle brackets on the URL is a false positive since the
  URL is part of literal R code.
* Suggested package swephRdata is only available in the 'additional repository'
  https://rstub.github.io/drat
