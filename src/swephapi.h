#ifdef __cplusplus
extern "C" {
#endif

#ifndef _SWEPHAPI_H
#define _SWEPHAPI_H

/* monday = 0, ... sunday = 6 */
int swe_day_of_week(double jd);

/* acquire the tidal acceleration */
double swe_get_tid_acc() ;

#ifdef __cplusplus
}
#endif

#endif // _SWEPHAPI_H
