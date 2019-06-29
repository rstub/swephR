context("Misc tests")

test_that("day_of_week works", {
  expect_equal(swe_day_of_week(1234.567), 3)
})

test_that("day_of_week works with vector input", {
  expect_equal(swe_day_of_week(c(1234.567, 1235.67)), c(3, 4))
})

test_that("tidal accelaration can be retrieved", {
  expect_equal(swe_get_tid_acc(), -25.8)
})

test_that("tidal accelaration can be set and retrieved", {
  swe_set_tid_acc(1.23)
  expect_equal(swe_get_tid_acc(), 1.23)
  swe_close()
})

test_that("deltat can be retrieved", {
    if (requireNamespace("swephRdata", quietly = TRUE))
        expect_equal(swe_deltat(1234.567), 1.5976757, tolerance = .0000001)
    else
        expect_equal(swe_deltat(1234.567), 1.58738640540236, tolerance = .0000001)
})

test_that("deltat can be retrieved for vector", {
    if (requireNamespace("swephRdata", quietly = TRUE))
        expect_equal(swe_deltat(c(1234.567, 1234567)), c(1.5976757, 0.3685434), tolerance = .0000001)
    else
        expect_equal(swe_deltat(c(1234.567, 1234567)), c(1.5873864, 0.366039979375346), tolerance = .0000001)
})

test_that("deltat can be set and retrieved", {
  swe_set_delta_t_userdef(1.23456)
  expect_equal(swe_deltat(1234.567), 1.23456)
  swe_set_delta_t_userdef(-1E-10) # SE_DELTAT_AUTOMATIC
})

test_that("deltat can be retrieved with SEFLG_MOSEPH", {
    result <- swe_deltat_ex(1234.567, 4)
    expect_true(is.list(result))
    expect_equal(result$serr, "")
    expect_equal(result$deltat, 1.5873865, tolerance = .0000001)
})

test_that("deltat can be retrieved with SEFLG_MOSEPH for vector", {
    result <- swe_deltat_ex(c(1234.567, 1234567), 4)
    expect_true(is.list(result))
    expect_equal(result$serr, c("", ""))
    expect_equal(result$deltat, c(1.5873865, 0.36604), tolerance = .0000001)
})

test_that("deltat can be retrieved with SEFLG_SWIEPH", {
    skip_if_not_installed("swephRdata")
    result <- swe_deltat_ex(1234.567, 2)
    expect_true(is.list(result))
    expect_equal(result$serr, "")
    expect_equal(result$deltat, 1.5976757, tolerance = .0000001)
})

test_that("deltat can be retrieved with SEFLG_SWIEPH for vector", {
    skip_if_not_installed("swephRdata")
    result <- swe_deltat_ex(c(1234.567, 1234567), 2)
    expect_true(is.list(result))
    expect_equal(result$serr, c("", ""))
    expect_equal(result$deltat, c(1.5976757, 0.3685434), tolerance = .0000001)
})

test_that("version works", {
    expect_equal(swe_version(), "2.08")
})


test_that("Converting calander date into Julian day number", {
  result <- swe_julday(2000,1,1,12,1)
  expect_equal(result, 2451545)
})

test_that("Determing ayanamsa using UT:", {
  result <- swe_get_ayanamsa_ex_ut(2458346.82639,4)
  expect_true(is.list(result))
  expect_equal(result$return, 68)
  expect_equal(result$serr, "")
  expect_equal(result$daya, 24.99688, tolerance = .000001)
})

test_that("Determing ayanamsa using ET:", {
  result <- swe_get_ayanamsa_ex(2458346.82639,4)
  expect_true(is.list(result))
  expect_equal(result$return, 68)
  expect_equal(result$serr, "")
  expect_equal(result$daya, 24.99688, tolerance = .000001)
})

test_that("Retrieving ayanammsa name:", {
  expect_equal(swe_get_ayanamsa_name(12), "Babylonian/Huber")
}) 

test_that("Retrieving house name:", {
  expect_equal(swe_house_name('G'), "Gauquelin sectors")
}) 

test_that("Retrieving Sidereal time:", {
  expect_equal(swe_sidtime(2451545), 18.69714,tolerance = .000001)
}) 

test_that("Determine house info using ARMC:", {
 result <- swe_houses_armc(12, 53, 23, 'B')
 expect_true(is.list(result))
 expect_equal(result$return, 0)
 expect_equal(result$cusps, c(0, 125.97068,147.38669,169.96807,193.00244,233.05493,269.54195,305.97068,327.38669,349.96807,13.00244
                            ,53.05493,  89.54195,   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), tolerance = .000001)
 expect_equal(result$ascmc, c(125.97068,13.00244,12.00000,263.98576,101.07060 ,71.50788,116.41241,251.50788,0,0), tolerance = .000001)
})

test_that("Determine house info using date/lat/long:", {
  result <- swe_houses_ex(1234567, 0, 53, 0, 'B')
  expect_true(is.list(result))
  expect_equal(result$return, 0)
  expect_equal(result$cusps, c(0, 46.64518 , 67.89822,  88.19583, 108.40898 ,145.68710, 186.61910 ,226.64518, 247.89822 ,268.19583, 288.40898
                               ,325.68710,6.61910,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), tolerance = .000001)
  expect_equal(result$ascmc, c(46.64518, 288.40898,289.99675, 196.36986 , 21.69681 , 13.76371 , 31.65048, 193.76371,0,0), tolerance = .000001)
})

test_that("Determine house info using date/lat/long:", {
  result <- swe_house_pos(12, 53, 23, 'B', c(0,0))
  expect_true(is.list(result))
  expect_equal(result$return, 9.435262,tolerance = .000001)
  expect_equal(result$serr, "")
})