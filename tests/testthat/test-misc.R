context("test-misc.R")

test_that("day_of_week works", {
  expect_equal(swe_day_of_week(1234.567), 3)
})

test_that("day_of_week works with vector input", {
  expect_equal(swe_day_of_week(c(1234.567, 1235.67)), c(3, 4))
})

test_that("tidal accelaration can be retrieved", {
  expect_equal(swe_get_tid_acc(), 0)
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
})

swe_set_ephe_path("")
swe_set_topo(0,50,10)
test_that("Existing star position", {
  result <- swe_fixstar("sirius",1234567,34818)
  expect_true(is.list(result))
  expect_equal(result$return, 34818)
  expect_equal(result$xx, c(6.465315e+01, -1.780315e+01,  5.518192e+05, -3.482530e-04,  1.170200e-05, -3.109594e-03),tolerance = .00001)
})



test_that("Azimuth and altitude postions", {
  result <- swe_azalt(1234567,1,c(0,50,10),15,1013.25,c(186,22))
  expect_equal(result$xaz, c(114.636188,   8.210881,   8.209274),tolerance = .0000001)
})


test_that("Rise/set azimuth", {
  result <- swe_rise_trans_true_hor(1234567.5,0,"",4,0,c(0,50,10),1013.25,15,0)
  expect_equal(result$tret, 1234567.83559187, tolerance = .0000001)
})
