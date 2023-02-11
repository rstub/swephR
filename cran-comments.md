## Test environments

* local Linux install: R 4.2.2
* Ubuntu (on GHA): R oldrel, release, devel
* Mac OS X (on GHA): R release
* Windows (on GHA): R release
* Windows (on win-builder): R devel

## R CMD check results

0 errors | 0 warnings | 2 notes

* The remark to use angle brackets on the URL is a false positive since the
  URL is part of literal R code.
* Suggested package swephRdata is only available in the 'additional repository'
  https://rstub.r-universe.dev
