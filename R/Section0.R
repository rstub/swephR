SEtest <- function() {
swe_set_ephe_path(NULL)
iflag = SEFLG_SPEED
while (TRUE) 
{
#get year
stopyear <-readline(prompt="Year (yyyy): ")
#stop if a period . is entered */
if (stopyear==".") {return(-1)}
jyear<- as.integer(stopyear)
#get month
jmon<- as.integer(readline(prompt="Month (mm): "))
#get day
jday<- as.integer(readline(prompt="Day (dd): "))
#determine julian day number (at 12:00 GMT)
tjd_ut <- swe_julday(jyear,jmon,jday,12,SE_GREG_CAL )

for (p in SE_SUN: SE_CHIRON) {
  objectname=swe_get_planet_name(p)
  # calcualte for non Earth objects
  if (objectname!="Earth") {
  # calcualet positions
  i = swe_calc_ut(tjd_ut, p, iflag)
  # print data
  cat (objectname,":",i$xx,"\n")
  }
  }
}
return

}