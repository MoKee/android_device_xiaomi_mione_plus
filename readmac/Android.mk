
# Hack for build
$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libnv_intermediates)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libnv_intermediates/export_includes)
$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/liboncrpc_intermediates)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/liboncrpc_intermediates/export_includes)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SHARED_LIBRARIES := libnv liboncrpc
LOCAL_SHARED_LIBRARIES  += libcutils

LOCAL_SRC_FILES:= readmac.c
LOCAL_MODULE:= libreadmac
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

