## Resubmission
This is a resubmission. In this version I have:

* Downgraded the included SWE library so that dependent packages don't break
* Fixed the warnings w.r.t. incomplete functions

## Test environments

* local Linux install: R 4.3.0
* Ubuntu (on GHA): R oldrel, release, devel
* Mac OS X (on GHA): R release
* Windows (on GHA): R release
* Windows (on win-builder): R devel
* Solaris 10 (on r-hub): R patched

## R CMD check results

0 errors | 0 warnings | 2 notes

* The remark to use angle brackets on the URL is a false positive since the
  URL is part of literal R code.
* Suggested package swephRdata is only available in the 'additional repository'
  https://rstub.github.io/drat
