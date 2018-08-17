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

typedef int32    centisec;       /* centiseconds used for angles and times */
#define CS	(centisec)	/* use for casting */
#define CSEC	centisec	/* use for typing */

#define _SWEODEF_INCLUDED
#include <swephexp.h>

#ifdef __cplusplus
}
#endif

#endif // _SWEPHAPI_H
