library("swephR")
swe_set_ephe_path('')
options(digits=15)

for (i in 1:5) {
#swe_heliacal_ut(1234567,c(0,50,10),c(1013.25,15,50,0.15),c(25,1),"sirius",1,260)
#swe_heliacal_ut(1234567,c(0,50,10),c(1013.25,15,50,0.15),c(25,1),"sirius",1,256)
#swe_heliacal_ut(1234567,c(0,50,10),c(1013.25,15,50,0.15),c(25,1),"mars",1,260)
a <- swe_heliacal_ut(1234567+i,c(0,50,10),c(1013.25,15,50,0.15),c(25,1),"mercury",1,260)
print (i)
print (a$dret[1:3])
}


#swe_heliacal_ut(1234567,c(0,50,10),c(1013.25,15,50,0.25),c(25,1),"venus",1,260)

#swe_heliacal_ut(1234567,c(0,50,10),c(1013.25,15,50,0.25),c(25,1),"moon",3,260)

