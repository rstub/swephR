context("test-misc.R")

test_that("day_of_week works", {
  expect_equal(day_of_week(1234.567), 3)
})

test_that("day_of_week works with vector input", {
  expect_equal(day_of_week(c(1234.567, 1235.67)), c(3, 4))
})

test_that("tidal accelaration can be retrieved", {
  expect_equal(get_tid_acc(), 0)
})
