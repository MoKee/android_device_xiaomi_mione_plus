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

//#ifdef __cplusplus
//extern "C" {
//#endif

typedef union {
  unsigned char                                            oem_item_8[31];
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
static unsigned char wlan_addr[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, };
#ifdef __cplusplus
}
#endif


unsigned char *read_mac() {
    static nv_item_type my_nv_item;
    static nv_stat_enum_type cmd_result;
	int i;
        oncrpc_init();
        oncrpc_task_start();
	nv_available = nv_null();
	cmd_result = nv_cmd_remote(NV_READ_F, NV_OEM_ITEM_8_I, &my_nv_item);
	printf("WLAN Address\n");
	for (i = 0; i < 6; i++) {
	    wlan_addr[i] = my_nv_item.oem_item_8[5 - i];
	  }
	return wlan_addr[i];
}

