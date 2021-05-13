context("Misc tests")

test_that("day_of_week works", {
  expect_equal(swe_day_of_week(1234.567), 3 )
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
        expect_equal(swe_deltat(1234.567), 1.5976757, tolerance = .0000001)
})

test_that("deltat can be retrieved for vector", {
    if (requireNamespace("swephRdata", quietly = TRUE))
        expect_equal(swe_deltat(c(1234.567, 1234567)), c(1.5976757, 0.3685434), tolerance = .0000001)
    else
        expect_equal(swe_deltat(c(1234.567, 1234567)), c(1.5976757, 0.3685434), tolerance = .0000001)
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
    expect_equal(swe_version(), "2.10.01")
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
  expect_equal(result$daya, 24.99676, tolerance = .000001)
})

test_that("Determing ayanamsa using ET:", {
  result <- swe_get_ayanamsa_ex(2458346.82639,4)
  expect_true(is.list(result))
  expect_equal(result$return, 68)
  expect_equal(result$serr, "")
  expect_equal(result$daya, 24.99676, tolerance = .000001)
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

test_that("Determine Gauquelin sector position of a planet:", {
  data(SE)
result <- swe_gauquelin_sector(1234567.5,SE$VENUS,"",SE$FLG_MOSEPH,0,c(0,50,10),1013.25,15)
expect_equal(result$return, 0)
expect_equal(result$dgsect, 31.41367,tolerance = .000001)
expect_equal(result$serr, "")
})

test_that("Compute planetary nodes and apsides (based on UT):", {
  data(SE)
  result <- swe_nod_aps_ut(2451545,SE$MOON, SE$FLG_MOSEPH,SE$NODBIT_MEAN)
  expect_equal(result$return, 0)
  expect_equal(result$xnasc, c(1.250406e+02, 3.476104e-13, 2.460922e-03, 0,0,0),tolerance = .000001)
  expect_equal(result$xndsc, c(3.050406e+02, 2.439083e-13, 2.671325e-03, 0,0,0),tolerance = .000001)
  expect_equal(result$xperi, c(83.464332724, -3.419715015,  0.002428485, 0,0,0),tolerance = .000001)
  expect_equal(result$xaphe, c(2.634643e+02, 3.419715e+00, 2.710625e-03, 0,0,0),tolerance = .000001)
  expect_equal(result$serr, "")
})

test_that("Compute planetary nodes and apsides (based on ET):", {
  data(SE)
  result <- swe_nod_aps(2451545,SE$MOON, SE$FLG_MOSEPH,SE$NODBIT_MEAN)
  expect_equal(result$return, 0)
  expect_equal(result$xnasc, c(1.250407e+02, 1.105681e-13, 2.460922e-03, 0,0,0),tolerance = .000001)
  expect_equal(result$xndsc, c(3.050407e+02, -2.612689e-13,  2.671325e-03, 0,0,0),tolerance = .000001)
  expect_equal(result$xperi, c(83.464250479, -3.419723161 , 0.002428485, 0,0,0),tolerance = .000001)
  expect_equal(result$xaphe, c(2.634643e+02, 3.419723e+00, 2.710625e-03, 0,0,0),tolerance = .000001)
  expect_equal(result$serr, "")
})

test_that("calculates osculating elements (Kepler elements) and orbital periods:", {
  data(SE)
  result <- swe_get_orbital_elements(2451545,SE$MOON, SE$FLG_MOSEPH)
  expect_equal(result$return, 0)
  expect_equal(result$dret[0:17], c(2.552584e-03,  6.317394e-02,  5.240360e+00,  1.239572e+02 , 3.089075e+02 , 7.286466e+01 , 1.466895e+02 , 1.504159e+02 , 1.485766e+02,
                              2.195542e+02,  7.435498e-02 , 1.325595e+01,  7.435776e-02 ,-2.933903e+01,  2.451534e+06 , 2.391328e-03 , 2.713841e-03),tolerance = .000001)
  expect_equal(result$serr, "")
})

test_that("Calculates the maximum possible distance, the minimum possible distance and the current true distance:", {
  data(SE)
  result <- swe_orbit_max_min_true_distance(2451545,SE$MOON, SE$FLG_MOSEPH)
  expect_equal(result$return, 0)
  expect_equal(result$dmax, 0.002713841,tolerance = .000001)
  expect_equal(result$dmin, 0.002391328,tolerance = .000001)
  expect_equal(result$dtrue, 0.002690191,tolerance = .000001)
  expect_equal(result$serr, "")
})

test_that("Calcuate the time zone time:", {
  result <- swe_utc_time_zone(2000,1,1,12,5,1.2,2)
  expect_equal(result$year_out, 2000)
  expect_equal(result$month_out, 1)
  expect_equal(result$day_out, 1)
  expect_equal(result$hour_out, 10)
  expect_equal(result$min_out, 5)
  expect_equal(result$sec_out, 1.2,tolerance = .000001)
})

test_that("Calcuate Julian day number ET and UT):", {
  result <- swe_utc_to_jd(2000,1,1,0,12,3.4,SE$GREG_CAL)
  expect_equal(result$return,0)
  expect_equal(result$dret, c(2451544.50911556, 2451544.50837680),tolerance = .000001)
  expect_equal(result$serr, "")
})

test_that("Calcuate UTC from Julian day number ET):", {
  result <- swe_jdet_to_utc(2452500,SE$GREG_CAL)
  expect_equal(result$year_out, 2002)
  expect_equal(result$month_out, 8)
  expect_equal(result$day_out, 13)
  expect_equal(result$hour_out, 11)
  expect_equal(result$min_out, 58)
  expect_equal(result$sec_out, 55.8159989118576,tolerance = .000001)
})

test_that("Calcuate UTC from Julian day number UT):", {
  result <- swe_jdut1_to_utc(2452500,SE$GREG_CAL)
  expect_equal(result$year_out, 2002)
  expect_equal(result$month_out, 8)
  expect_equal(result$day_out, 13)
  expect_equal(result$hour_out, 12)
  expect_equal(result$min_out, 0)
  expect_equal(result$sec_out, 0.23009330034256,tolerance = .000001)
})

test_that("Calculate equation of time):", {
  skip_if_not_installed("swephRdata")
  result <- swe_time_equ(2452500)
  expect_equal(result$return,0)
  expect_equal(result$e, -0.00338739864203035,tolerance = .000001)
  expect_equal(result$serr, "")
})

test_that("Calculate LAT):", {
  skip_if_not_installed("swephRdata")
  result <- swe_lmt_to_lat(2452500,0)
  expect_equal(result$return,0)
  expect_equal(result$jd_lat, 2452499.9966126,tolerance = .000001)
  expect_equal(result$serr, "")
})

test_that("Calculate LMT):", {
  skip_if_not_installed("swephRdata")
  result <- swe_lat_to_lmt(2452500,0)
  expect_equal(result$return,0)
  expect_equal(result$jd_lmt, 2452500.00338698,tolerance = .000001)
  expect_equal(result$serr, "")
})
