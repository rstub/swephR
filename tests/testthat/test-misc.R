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
    result <- swe_calc(1234.567, -2)
    expect_true(is.list(result))
    expect_equal(result$rc, -1)
    expect_equal(result$serr, "illegal planet number -2.")
})
