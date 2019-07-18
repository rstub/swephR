context("Eclipses and planetary phenomena")

test_that("Azimuth and altitude postions", {
  result <- swe_azalt(1234567,1,c(0,50,10),15,1013.25,c(186,22))
  expect_equal(result$xaz, c(114.636188,   8.210881,   8.209274),tolerance = .0000001)
  swe_close()
})

test_that("Ecliptic postions", {
  result <- swe_azalt_rev(1234567,0,c(0, 50,10),c(123,2))
  expect_equal(result$xout[1:2], c(166.0465305159982,  18.0853031826458),tolerance = .0000001)
  swe_close()
})

test_that("Equatorial postions", {
  result <- swe_azalt_rev(1234567,1,c(0, 50,10),c(123,2))
  expect_equal(result$xout[1:2], c(174.78989 , 22.12376),tolerance = .0000001)
  swe_close()
})


test_that("Rise time of Sun", {
  result <- swe_rise_trans_true_hor(1234567.5,0,"",4,1,c(0,50,10),1013.25,15,0)
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

test_that("Solar eclipse", {
  result <- swe_sol_eclipse_when_loc(1234567,4,c(0,50,10),FALSE)
  expect_equal(result$return, 4242)
  expect_equal(result$tret[1:7],c(1.23477168584597e+06, 1.23477163960865e+06,0,0,  1.23477171224360e+06,  1.23477168584597e+06,0))
  expect_equal(result$attr[1:11],c( 5.45656645429638e-01, 9.61071876161396e-01,4.36668429108189e-01 , 1.40827740655886e+02, 2.40581275123498e+02,-3.45422559148016e-01 , 1.90452771420542e-01, 2.31444434882052e-01, 5.45656645429638e-01, 43,11))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Solar eclipse on the earth", {
  result <- swe_sol_eclipse_when_glob(1234567,SE$FLG_MOSEPH,SE$ECL_TOTAL+SE$ECL_CENTRAL+SE$ECL_NONCENTRAL,FALSE)
  expect_equal(result$return, 5)
  expect_equal(result$tret[1:9],c(1235273.84604006, 1235273.84229895, 1235273.74011916, 1235273.95201148 ,1235273.78142695 ,1235273.91073758,
                                  1235273.78196505, 1235273.91018579,       0))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Attributes of a solar eclipse for a given geographic position and time", {
  result <- swe_sol_eclipse_how(1234580.19960447,SE$FLG_MOSEPH,c(0,50,10))
  expect_equal(result$return, 0)
  expect_equal(result$attr[1:9],c( 0,  0,  0,   0,  60.62086506454898,
                                   -1.19143795734667,  -1.19143795734667, 178.45733394452094,   0))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Find out the geographic position a central eclipse is central or where a non-central eclipse is maximal", {
  result <- swe_sol_eclipse_where(1234771.68584597,SE$FLG_MOSEPH)
  expect_equal(result$return, 18)
  expect_equal(result$attr[1:12],c( 0.8543063072704876 ,  0.9611528526089881  , 0.8028105727980597, 140.8277403641362184, 229.9817237267510848,
                                     -0.0647264377419630,   0.4278483711380141  , 0.0672014572289063  , 0.8543063072704876,  43,
                                   11,   0))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Finds the next occultation for a body and a given geographic position.", {
  result <- swe_lun_occult_when_loc(1234567,SE$VENUS,"",SE$FLG_MOSEPH+SE$ECL_ONE_TRY,c(0,50,10),FALSE)
  expect_equal(result$return, 32644)
  expect_equal(result$tret[1:6],c(1234620.01091964, 1234619.98320972, 1234619.98379339, 1234620.03675771, 1234620.03728753,0))
  expect_equal(result$attr[1:9],c( 4.50739631328003e+01,  1.01855850852554e+02 , 1.03746143528978e+04, -3.45194789925967e+03,
                                    4.14943252743968e+01 , 9.45639393731195e+00  ,9.54926910539598e+00,  3.25604915761606e-02,
                                   0))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("finds the next occultation of a given body globally", {
  result <- swe_lun_occult_when_glob(1234567,SE$VENUS,"",SE$FLG_MOSEPH+SE$ECL_ONE_TRY,SE$ECL_TOTAL,FALSE)
  expect_equal(result$return, 5)
  expect_equal(result$tret[1:9],c(1234590.44756319 ,1234590.44344933, 1234590.36836142, 1234590.52681093, 1234590.36900640, 1234590.52616638,
                                  1234590.39548933, 1234590.49967049,0))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Compute the geographic location of an occultation for a given tjd.", {
  result <- swe_lun_occult_where(1234590.44756319,SE$VENUS,"",SE$FLG_MOSEPH+SE$ECL_ONE_TRY)
  expect_equal(result$return, 5)
  expect_equal(result$pathpos[1:3],c(157.9771583092420 , 24.8563536921861,0))
  expect_equal(result$attr[1:9],c( 3.96133153349951e+01,  7.82747642094204e+01 , 6.12693871204036e+03 ,-3.44452665419664e+03,
                                    4.46760851275411e+00 , 4.39348319535477e+01 , 4.39516599201838e+01 , 1.65922292213691e-04,
                                   0))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Lunar eclipse at a certain location", {
  result <- swe_lun_eclipse_when_loc(1234567,4,c(0,50,10),FALSE)
  expect_equal(result$return, 20624)
  expect_equal(result$tret,c(1234580.19,0,0,1234580.23691550,0,0,0,1234580.28328264,1234580.19960447,0))
  expect_equal(result$attr[1:11],c(0.718169986750774,1.74556231683580,0 ,0,240.642969834840244,-0.351069739087650,0.185738292657396,  0.586663260830164  ,0.718169986750774,12,58))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Lunar eclipse on earth", {
  result <- swe_lun_eclipse_when(1234567,4,1,FALSE)
  expect_equal(result$return, 4)
  expect_equal(result$tret,c(1234580.16758062,0.00000000 ,1234580.09824349, 1234580.23691550, 1234580.16112524, 1234580.17402406, 1234580.05176974,
                             1234580.28328264  ,     0.00000000  ,     0.00000000  ,     0.00000000  ,     0.00000000 ,     0.00000000   ,    0.00000000,
                              0.00000000    ,   0.00000000 ,      0.00000000 ,      0.00000000    ,   0.00000000 ,     0.00000000))
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

test_that("Phenomena of Moon (UT)", {
  result <- swe_pheno_ut(1234567,1,4)
  expect_equal(result$return, 4)
  expect_equal(result$attr[1:6],c(149.6307215971651772,0.0686075615100681,30.2944345224700591, 0.5180433249746146, -6.8235614464226826 , 0.9505687417907285))
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Phenomena of Moon (ET)", {
  result <- swe_pheno(1234567,1,4)
  expect_equal(result$return, 4)
  expect_equal(result$attr[1:6],c(154.1161000624804274,0.0501597578258811, 25.8196104808596623, 0.5205532974955946, -6.4659828673145414, 0.9551682301559420))
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

test_that("Determine Heliacal angle", {
  result <- swe_heliacal_angle(1234567.5,c(0,50,10),c(1013.25,15,20,0.25),c(25,1,1,1,5,0.8),768,-1,124,120,0,-45)
  expect_equal(result$return, 0)
  expect_equal(result$dret[1:3],c(3.468750, 11.569977, -8.101227), tolerance=.000001)
  expect_equal(result$serr, "")
  swe_close()
})

test_that("Topocentric to Apparent altitude", {
  result <- swe_refrac_extended(2,0,1013.25,15,-0.065,0)
  expect_equal(result$return, 2.2787088)
  expect_equal(result$dret[1:3], c(2.0000000, 2.2787088, 0.2787088), tolerance=.000001)
})

test_that("Apparent to Topocentric altitude", {
  result <- swe_refrac_extended(2,0,1013.25,15,-0.065,1)
  expect_equal(result$return, 1.701016)
  expect_equal(result$dret[1:3], c(1.701016, 2.000000, 0.298984), tolerance=.000001)
})
