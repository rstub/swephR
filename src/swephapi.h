#ifdef __cplusplus
extern "C" {
#endif

#ifndef _SWEPHAPI_H
#define _SWEPHAPI_H

/* from sweodef.h */
typedef int	int32;
typedef long long	int64;
typedef unsigned int	uint32;
typedef short	int16;
typedef double  REAL8;  /* real with at least 64 bit precision */
typedef int     INT4;   /* signed integer with at least 32 bit precision */
typedef unsigned int UINT4;
			/* unsigned integer with at least 32 bit precision */
typedef int     AS_BOOL;
typedef unsigned short UINT2;	/* unsigned 16 bits */
# define ABS4	abs		/* abs function for long */


/* monday = 0, ... sunday = 6 */
int swe_day_of_week(double jd);

/* acquire the tidal acceleration */
double swe_get_tid_acc() ;

char * swe_version(char *);
char * swe_get_library_path(char *);

/* vr added functions */
void swe_set_tid_acc(double t_acc);
double swe_deltat(double tjd);
void swe_set_ephe_path(char *);
void swe_set_topo(double geolon, double geolat, double altitude);
void swe_set_delta_t_userdef (double t_acc);


/* planets, moon, nodes etc. */
int32 swe_calc(
        double tjd, int ipl, int32 iflag,
        double *xx,
        char *serr);

/* star info. */
int32 swe_fixstar(
    char *star, double tjd, int32 iflag,
    double *xx,
    char *serr);

void swe_azalt(
    double tjd_ut,     /* UT */
    int32 calc_flag,    /* SE_ECL2HOR=0 or SE_EQU2HOR=1 */
    double *geopos, /* array of 3 doubles: geograph. long., lat., height */
    double atpress,   /* atmospheric pressure in mbar (hPa) */
    double attemp,   /* atmospheric temperature in degrees Celsius */  
  double *xin,
  double *xaz);


int32 swe_calc_ut(double tjd_ut, int32 ipl, int32 iflag,
	double *xx, char *serr);


#ifdef __cplusplus
}
#endif

#endif // _SWEPHAPI_H
