library(swephR)

#I need to do these others testi snot found
# library(roxygen2)
# roxygenise()

swe_set_ephe_path("C:\\ARCHAEOCOSMO\\ephe")
swe_set_topo(0,50,10)
test_that("Existing star position", {
  result <- swe_fixstar("sirius",1234567,34818)
  expect_true(is.list(result))
  expect_equal(result$return, 34818)
  expect_equal(result$xx, c(6.465315e+01, -1.780315e+01,  5.518192e+05, -3.482530e-04,  1.170200e-05, -3.109594e-03),tolerance = .00001)
  expect_equal(result$serr, "SwissEph file 'seplm18.se1' not found in PATH 'C:\\ARCHAEOCOSMO\\ephe\\' \nusing Moshier eph.; ")
})



test_that("Azimuth and altitude postions", {
  result <- swe_azalt(1234567,1,c(0,50,10),15,1013.25,c(186,22))
  expect_equal(result$xaz, c(114.636188,   8.210881,   8.209274),tolerance = .0000001)
})
