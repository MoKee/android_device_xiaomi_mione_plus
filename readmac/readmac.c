#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <fcntl.h>
#include <stdarg.h>
#include <getopt.h>
#include <sys/ioctl.h>
#include <time.h>
#include <termios.h>

#define LOG_TAG "ReadMac"
#include "cutils/log.h"

//#ifdef __cplusplus
//extern "C" {
//#endif

typedef union {
  unsigned char    oem_item_8[31];
} nv_item_type;


/* temp until they appear in a header file somewhere */
extern void oncrpc_task_start(void);
extern void oncrpc_init(void);
extern int nv_null(void);
static int nv_available;

typedef enum {
    NV_READ_F,          /* Read item */
    NV_WRITE_F,         /* Write item */
} nv_func_enum_type;

typedef enum {
    NV_OEM_ITEM_8_I                                = 6860
} nv_items_enum_type;

typedef enum {
    NV_DONE_S,
    NV_BUSY_S
} nv_stat_enum_type;

nv_stat_enum_type nv_cmd_remote 
( 
  nv_func_enum_type cmd, 
  nv_items_enum_type item, 
  nv_item_type *data_ptr 
); 

#ifdef __cplusplus
}
#endif


unsigned char *read_mac() {
    static nv_item_type my_nv_item;
    static nv_stat_enum_type cmd_result;
	int i;
	char mac_buf[64];
        oncrpc_init();
        oncrpc_task_start();
	nv_available = nv_null();
	cmd_result = nv_cmd_remote(NV_READ_F, NV_OEM_ITEM_8_I, &my_nv_item);
	ALOGI("WLAN Address\n");
/*
  	for (i = 0; i < 6; i++) {
 	    ALOGE("%2x:",my_nv_item.oem_item_8[5 - i]);
 	  }
*/	
    return my_nv_item.oem_item_8;
}


/* Method For Bcm4330
 * 
 * hardware/libhardware_legacy/wifi/wifi.c
 * 
 * extern char *read_mac();
 * static char mac_buf[150];
 * 
 * char *x;
 * if(!strcmp(mac_buf,"")) {
 *     x=read_mac();
 * 
 * //    This is Mione_plus get mac address on Miuiv4 , but You can not use on CM10.1 , 
 * //    logcat : vsprintf buffer overflow detected 
 * //    sprintf(mac, "%s mac=0x%02x,0x%02x,0x%02x,0x%02x,0x%02x,0x%02x", DHD_DRIVER_MODULE_ARG, x[0],x[1],x[2],x[3],x[4],x[5]);
 * 
 * //  So we can use the following    
 *     sprintf(mac_buf,"mac=0x%02x,0x%02x,0x%02x,0x%02x,0x%02x,0x%02x", x[0],x[1],x[2],x[3],x[4],x[5]);
 * }
 * ALOGI("Got WLAN MAC Address: %s \ ",mac_buf);
 * 
 */

/* Official Kernel For Bcm4330
 *
 * if ((mac[0] != 0) || (mac[1] != 0)) {
 *     bcopy((char *)&mac, buf, 6);
 *     return ret;
 * }
 * ret = wifi_get_mac_addr(buf);
 * 
 */
