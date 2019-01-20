## Resubmission
This is a resubmission. In this version I have:

* Explicitly included the copyright holder of the included
  Swiss Ephemeris code without giving any names in places that might
  be interpreted as "adverticement" as request by the upstream authors
  in their license statement, c.f. LICENSE.

## Test environments

* local Linux install: R 3.5.2
* Ubuntu 16.04 (on Travis CI): R oldrel, release, devel
* Mac OS X (on Travis CI): R release
* Windows (on Appveyor): R release
* Windows (on win-builder): R release, devel

## R CMD check results

0 errors | 0 warnings | 2 notes

* This is a new release.
* Possibly mis-spelled words in DESCRIPTION are false positives:
  ephemerides (10:11)
  ephemeris (9:54)
  Ephemeris (3:29, 9:24, 12:69)
  JPL (10:35, 16:48)
  Moshier (11:67)
  repos (14:41)
  swephRdata (14:28)
* The remark to use angle brackets on the URL is a false positive since the
  URL is part of literal R code.
* Suggested package swephRdata is only available in the 'additional repository'
  https://rstub.github.io/drat
