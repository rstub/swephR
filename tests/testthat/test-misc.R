context("test-misc.R")

#swe_set_ephe_path("")

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
        expect_equal(swe_deltat(1234.567), 1.5873865, tolerance = .0000001)
})

test_that("deltat can be retrieved for vector", {
    if (requireNamespace("swephRdata", quietly = TRUE))
        expect_equal(swe_deltat(c(1234.567, 1234567)), c(1.5976757, 0.3685434), tolerance = .0000001)
    else
        expect_equal(swe_deltat(c(1234.567, 1234567)), c(1.5873865, 0.36604), tolerance = .0000001)
})

test_that("deltat can be set and retrieved", {
  swe_set_delta_t_userdef(1.23456)
  expect_equal(swe_deltat(1234.567), 1.23456)
  swe_set_delta_t_userdef(-1E-10) # SE_DELTAT_AUTOMATIC
})

test_that("deltat can be retrieved with build in ephemeris", {
    result <- swe_deltat_ex(1234.567, 4)
    expect_true(is.list(result))
    expect_equal(result$serr, "")
    expect_equal(result$deltat, 1.5873865, tolerance = .0000001)
})

test_that("deltat can be retrieved with build in ephemeris for vector", {
    result <- swe_deltat_ex(c(1234.567, 1234567), 4)
    expect_true(is.list(result))
    expect_equal(result$serr, c("", ""))
    expect_equal(result$deltat, c(1.5873865, 0.36604), tolerance = .0000001)
})

test_that("deltat can be retrieved with SE", {
    skip_if_not_installed("swephRdata")
    result <- swe_deltat_ex(1234.567, 2)
    expect_true(is.list(result))
    expect_equal(result$serr, "")
    expect_equal(result$deltat, 1.5976757, tolerance = .0000001)
})

test_that("deltat can be retrieved with SE for vector", {
    skip_if_not_installed("swephRdata")
    result <- swe_deltat_ex(c(1234.567, 1234567), 2)
    expect_true(is.list(result))
    expect_equal(result$serr, c("", ""))
    expect_equal(result$deltat, c(1.5976757, 0.3685434), tolerance = .0000001)
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
  expect_equal(result$star, "Sirius,alCMa")
  expect_equal(result$xx, c(6.465315e+01, -1.780315e+01,  5.518192e+05, -3.482530e-04,  1.170200e-05, -3.109594e-03),tolerance = .00001)
  swe_close()
})

test_that("Two existing stars positions", {
  swe_set_topo(0,50,10)
  result <- swe_fixstar2(c("sirius", "aldebaran"), 1234567, 34820)
  expect_true(is.list(result))
  expect_equal(result$return, c(34820, 34820))
  expect_equal(result$star, c("Sirius,alCMa", "Aldebaran,alTau"))
  expect_equal(result$xx, matrix(c(6.465315e+01, -1.780315e+01, 5.518192e+05, -3.482530e-04, 1.170200e-05, -3.109594e-03,
                                   2.385093e+01, 4.006615e+00, 4.138739e+06, 0.000000e+00, 0.000000e+00, 0.000000e+00),
                                nrow = 2, byrow = TRUE), tolerance = .00001)
  swe_close()
})


test_that("Existing star magnitude", {
  result <- swe_fixstar2_mag("sirius")
  expect_true(is.list(result))
  expect_equal(result$return, 0)
  expect_equal(result$star, "Sirius,alCMa")
  expect_equal(result$mag, -1.46)
  swe_close()
})

test_that("Two existing star magnitudes", {
  result <- swe_fixstar2_mag(c("sirius", "aldebaran"))
  expect_true(is.list(result))
  expect_equal(result$return, c(0, 0))
  expect_equal(result$star, c("Sirius,alCMa", "Aldebaran,alTau"))
  expect_equal(result$mag, c(-1.46, 0.86))
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

test_that("Heliacal rise of sirus", {
  result <- swe_heliacal_ut(1234567,c(0,50,10),c(1013.25,15,50,0.25),c(25,1,1,1,5,0.8),"sirius",1,260)
  expect_equal(result$return, 0)
  expect_equal(result$dret[1:3],c(1234768.64491623, 1234768.65345790, 1234768.66307595), tolerance=.000001)
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Lunar eclipse conditions", {
  result <- swe_lun_eclipse_how(1234580.19960447,4,c(0,50,10))
  expect_equal(result$return, 16)
  expect_equal(result$attr[1:11],c(0.718169986750774,1.74556231683580,0 ,0,240.642969834840244,-0.351069739087650,0.185738292657396,  0.586663260830164  ,0.718169986750774,12,58))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Lunar eclipse", {
  result <- swe_lun_eclipse_when_loc(1234567,4,c(0,50,10),0)
  expect_equal(result$return, 20624)
  expect_equal(result$tret,c(1234580.19,0,0,1234580.23691550,0,0,0,1234580.28328264,1234580.19960447,0))
  expect_equal(result$attr[1:11],c(0.718169986750774,1.74556231683580,0 ,0,240.642969834840244,-0.351069739087650,0.185738292657396,  0.586663260830164  ,0.718169986750774,12,58))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Solar eclipse", {
  result <- swe_sol_eclipse_when_loc(1234567,4,c(0,50,10),0)
  expect_equal(result$return, 4242)
  expect_equal(result$tret[1:7],c(1.23477168584597e+06, 1.23477163960865e+06,0,0,  1.23477171224360e+06,  1.23477168584597e+06,0))
  expect_equal(result$attr[1:11],c( 5.45656645429638e-01, 9.61071876161396e-01,4.36668429108189e-01 , 1.40827740655886e+02, 2.40581275123498e+02,-3.45422559148016e-01 , 1.90452771420542e-01, 2.31444434882052e-01, 5.45656645429638e-01, 43,11))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Phenomenology info from Moon", {
  result <- swe_pheno_ut(1234567,1,4)
  expect_equal(result$return, 0)
    if (requireNamespace("swephRdata", quietly = TRUE))
        expect_equal(result$attr[1:6],c(149.60020709, 0.06874225, 30.32487839, 0.51802614, -6.82591793, 0.95053725))
    else
        expect_equal(result$attr[1:6],c(149.6307215971651772,0.0686075615100681,30.2944345224700591, 0.5180433249746146, -6.8235614464226826 , 0.9505687417907285))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Limiting visibility magnitude", {
  result <- swe_vis_limit_mag(1234567.5,c(0,50,10),c(1013.25,15,20,0.25),c(25,1,1,1,5,0.8),'sirius',260)
  expect_equal(result$return, 1)
  expect_equal(result$dret[1:8],c(5.96884644531082e+00  ,1.10797411875736e+01, 2.24100275575357e+02,-6.18080893675434e+01, 3.52678922475298e+02, -4.14868023984033e+01,   3.02677186429211e+02,-1.46), tolerance=.000001)
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Heliacal event details", {
  result <- swe_heliacal_pheno_ut(1234567.5,c(0,50,10),c(1013.25,15,20,0.25),c(25,1,1,1,5,0.8),'sirius',2,260)
  expect_equal(result$return, 0)
  expect_equal(result$darr[1:28],c( 1.10797411875736e+01,   1.11584553531197e+01
                                    ,  1.10797335338164e+01,   2.24100275575357e+02
                                    ,-6.18080893675434e+01,   3.52678922475298e+02
                                    ,7.28878305551170e+01,   7.28878229013598e+01
                                    ,1.28578646899941e+02,   1.00572920775361e+02
                                    ,2.50000000000000e-01,   8.40408325195312e+00
                                    ,9.99999990000000e+07,   1.23456819963629e+06
                                    ,1.23456756274629e+06,   9.99999990000000e+07
                                    ,   0.00000000000000e+00,   0.00000000000000e+00
                                    ,   0.00000000000000e+00 , -7.65375721556438e-06
                                    ,  -1.46000000000000e+00,   1.23456756274629e+06
                                    ,   1.23456818424277e+06 , -6.21496487408876e-01
                                    ,   9.99999990000000e+07,   0.00000000000000e+00
                                ,  1.00572920775361e+02 ,  1.00000000000000e+02), tolerance=.000001)
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Determine topocentric Arcusvisionis", {
  result <- swe_topo_arcus_visionis(1234567.5,c(0,50,10),c(1013.25,15,20,0.25),c(25,1,1,1,5,0.8),768,-1,124,2,120,0,-45)
  expect_equal(result$return, 0)
  expect_equal(result$tav,12.4801254272461, tolerance=.000001)
  expect_equal(result$serr, "")
  swe_close()
})
