context("test-misc.R")

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
})

test_that("version works", {
    expect_equal(swe_version(), "2.07.01")
})

test_that("non-existent planet produces error", {
    result <- swe_calc(1234.567, -2,4)
    expect_true(is.list(result))
    expect_equal(result$return, -1)
    expect_equal(result$serr, "illegal planet number -2.")
    swe_close()
})

test_that("Sun near present day with build in ephemeris", {
    result <- swe_calc(2458346.82639, 0, 4)
    expect_true(is.list(result))
    expect_equal(result$return, 4)
    expect_equal(result$serr, "")
    expect_equal(result$xx, c(143.411541546115, 0.000153328074557681, 1.01265945421508, 0, 0, 0))
    swe_close()
})

test_that("Sun near present day with SE", {
    skip_if_not_installed("swephRdata")
    result <- swe_calc(2458346.82639, 0, 2)
    expect_true(is.list(result))
    expect_equal(result$return, 2)
    expect_equal(result$serr, "")
    expect_equal(result$xx, c(143.411548004662, 0.000154522097263712, 1.01265952395477, 0, 0, 0))
    swe_close()
})

test_that("Moon near present day with build in ephemeris", {
    result <- swe_calc(2458346.82639, 1, 4)
    expect_true(is.list(result))
    expect_equal(result$return, 4)
    expect_equal(result$serr, "")
    expect_equal(result$xx, c(209.393205609575, 5.23865656062778, 0.00254763959909033, 0, 0, 0))
    swe_close()
})

test_that("Moon near present day with SE", {
    skip_if_not_installed("swephRdata")
    result <- swe_calc(2458346.82639, 1, 2)
    expect_true(is.list(result))
    expect_equal(result$return, 2)
    expect_equal(result$serr, "")
    expect_equal(result$xx, c(209.393307909087, 5.23884819964366, 0.00254765467381015, 0, 0, 0))
    swe_close()
})

test_that("Sun and Moon near present day with build in ephemeris", {
    result <- swe_calc(2458346.82639, c(0, 1), 4)
    expect_true(is.list(result))
    expect_equal(result$return, c(4, 4))
    expect_equal(result$serr, c("", ""))
    expect_equal(result$xx, matrix(c(143.411541546115, 0.000153328074557681, 1.01265945421508, 0, 0, 0,
                                     209.393205609575, 5.23865656062778, 0.00254763959909033, 0, 0, 0),
                                   nrow = 2, byrow = TRUE))
    swe_close()
})

test_that("Mercury near present day with build in ephemeris", {
    result <- swe_calc(2458346.82639, 2, 4)
    expect_true(is.list(result))
    expect_equal(result$return, 4)
    expect_equal(result$serr, "")
    expect_equal(result$xx, c(132.01192327168, -3.48121475787494, 0.67906546508584, 0, 0, 0))
    swe_close()
})

test_that("Mercury near present day with SE", {
    skip_if_not_installed("swephRdata")
    result <- swe_calc(2458346.82639, 2, 2)
    expect_true(is.list(result))
    expect_equal(result$return, 2)
    expect_equal(result$serr, "")
    expect_equal(result$xx, c(132.011933922771, -3.48121306761461, 0.679065645713915, 0, 0, 0))
    swe_close()
})

test_that("Existing star position", {
  swe_set_topo(0,50,10)
  result <- swe_fixstar2("sirius",1234567,34820)
  expect_true(is.list(result))
  expect_equal(result$return, 34820)
  expect_equal(result$xx, c(6.465315e+01, -1.780315e+01,  5.518192e+05, -3.482530e-04,  1.170200e-05, -3.109594e-03),tolerance = .00001)
  swe_close()
})


test_that("Existing star magnitude", {
  result <- swe_fixstar2_mag("sirius")
  expect_true(is.list(result))
  expect_equal(result$return, 0)
  expect_equal(result$mag, -1.46)
  swe_close()
})


test_that("Azimuth and altitude postions", {
  result <- swe_azalt(1234567,1,c(0,50,10),15,1013.25,c(186,22))
  expect_equal(result$xaz, c(114.636188,   8.210881,   8.209274),tolerance = .0000001)
  swe_close()
})


test_that("Rise/set azimuth", {
  result <- swe_rise_trans_true_hor(1234567.5,0,"",4,0,c(0,50,10),1013.25,15,0)
  expect_equal(result$tret, 1234567.83559187, tolerance = .0000001)
  swe_close()
})
