swe_set_ephe_path("C:\\ARCHAEOCOSMO\\ephe")
swe_set_topo(0,50,10)
swe_fixstar("sirius",1234567,34818)
# $`return`
# [1] 34818
# 
# $star
# [1] "Sirius,alCMa"
# 
# $xx
# [1]  6.465315e+01 -1.780315e+01  5.518192e+05 -3.482530e-04  1.170200e-05 -3.109594e-03
# 
# $serr
# [1] "SwissEph file 'seplm18.se1' not found in PATH 'C:\\ARCHAEOCOSMO\\ephe\\' \nusing Moshier eph.; "



swe_azalt(1234567,1,c(0,50,10),15,1013.25,c(186,22))
# $`xaz`
# [1] 114.636188   8.210881   8.209274