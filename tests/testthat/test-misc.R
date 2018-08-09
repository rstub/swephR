context("test-misc.R")

test_that("day_of__week works", {
  expect_equal(day_of_week(1234.567), 3)
})

test_that("day_of__week works", {
  expect_equal(day_of_week(c(1234.567, 1235.67)), c(3, 4))
})
