#
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# common msm8660 configs
$(call inherit-product, device/xiaomi/msm8660-common/msm8660.mk)

$(call inherit-product-if-exists, vendor/xiaomi/mione_plus/mione_plus-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/xiaomi/mione_plus/overlay

# GPS and Light
PRODUCT_PACKAGES += \
    gps.mione \
    lights.mione \
    libreadmac

# gps.conf
PRODUCT_COPY_FILES += \
    device/xiaomi/mione_plus/configs/gps.conf:system/etc/gps.conf

# Ramdisk files
PRODUCT_COPY_FILES += \
    device/xiaomi/mione_plus/ramdisk/init.mione.rc:root/init.mione.rc \
    device/xiaomi/mione_plus/ramdisk/init.qcom.rc:root/init.qcom.rc \
    device/xiaomi/mione_plus/ramdisk/init.qcom.sh:root/init.qcom.sh \
    device/xiaomi/mione_plus/ramdisk/init.qcom.usb.rc:root/init.qcom.usb.rc \
    device/xiaomi/mione_plus/ramdisk/init.qcom.usb.sh:root/init.qcom.usb.sh \
    device/xiaomi/mione_plus/ramdisk/init.target.rc:root/init.target.rc \
    device/xiaomi/mione_plus/ramdisk/ueventd.mione.rc:root/ueventd.mione.rc \
    device/xiaomi/mione_plus/ramdisk/sbin/chargeonlymode:root/sbin/chargeonlymode \
    device/xiaomi/mione_plus/ramdisk/init.mione.syspart_system.rc:root/init.mione.syspart_system.rc \
    device/xiaomi/mione_plus/ramdisk/init.mione.syspart_system1.rc:root/init.mione.syspart_system1.rc \
    device/xiaomi/mione_plus/ramdisk/mount_ext4.sh:/system/bin/mount_ext4.sh \
    device/xiaomi/mione_plus/ramdisk/fstab.mione:/root/fstab.mione \

# wifi
PRODUCT_COPY_FILES += \
    device/xiaomi/mione_plus/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Input device config
PRODUCT_COPY_FILES += \
    device/xiaomi/mione_plus/configs/mxt224_ts_input.idc:system/usr/idc/synaptics_rmi4_i2c.idc \
    device/xiaomi/mione_plus/configs/mxt224_ts_input.idc:system/usr/idc/ft5x0x.idc \
    device/xiaomi/mione_plus/configs/mxt224_ts_input.idc:system/usr/idc/sensor00fn11.idc \
    device/xiaomi/mione_plus/configs/mxt224_ts_input.idc:system/usr/idc/sensor00fn54.idc \
    device/xiaomi/mione_plus/configs/mxt224_ts_input.idc:system/usr/idc/mxt224_ts_input.idc \
    device/xiaomi/mione_plus/configs/mxt224_ts_input.idc:system/usr/idc/mXT-touch.idc

# Kernel modules
ifeq ($(TARGET_PREBUILT_KERNEL),)
PRODUCT_COPY_FILES += $(shell \
    find device/xiaomi/mione_plus/prebuilt -name '*.ko' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
    | tr '\n' ' ')
endif

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-flags=m=y

# xiaomi mione wifi config
$(call inherit-product, device/xiaomi/mione_plus/mione_bcm43xx.mk)

# dalvik tweak
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

