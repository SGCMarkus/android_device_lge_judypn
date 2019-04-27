#
# Copyright 2018 The LineageOS Project
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

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

LOCAL_PATH := $(call my-dir)

ifneq ($(filter judypn,$(TARGET_DEVICE)),)
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

# A/B builds require us to create the mount points at compile time.
# Just creating it for all cases since it does not hurt.
ELS_MOUNT_POINT := $(TARGET_OUT_VENDOR)/els
$(ELS_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(ELS_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/els

SNS_MOUNT_POINT := $(TARGET_OUT_VENDOR)/sns
$(SNS_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(SNS_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/sns

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

DRM_MOUNT_POINT := $(TARGET_OUT_VENDOR)/persist-lg
$(DRM_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DRM_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/persist-lg

MPT_MOUNT_POINT := $(TARGET_OUT_VENDOR)/mpt
$(MPT_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(MPT_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/mpt

SRTC_MOUNT_POINT := $(TARGET_OUT_VENDOR)/srtc
$(SRTC_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(SRTC_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/srtc

POWER_MOUNT_POINT := $(TARGET_OUT_VENDOR)/power
$(POWER_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(POWER_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/power

VZW_MOUNT_POINT := $(TARGET_OUT_VENDOR)/vzw/quality
$(VZW_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(VZW_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/vzw/quality

ERI_MOUNT_POINT := $(TARGET_OUT_VENDOR)/eri
$(ERI_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(ERI_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/eri

CARRIER_MOUNT_POINT := $(TARGET_OUT_VENDOR)/carrier
$(CARRIER_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(CARRIER_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/carrier

PERSDATA_MOUNT_POINT := $(TARGET_OUT_VENDOR)/persdata/absolute
$(PERSDATA_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(PERSDATA_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/persdata/absolute

ALL_DEFAULT_INSTALLED_MODULES += $(ELS_MOUNT_POINT) $(SNS_MOUNT_POINT) $(DSP_MOUNT_POINT) \
    $(DRM_MOUNT_POINT) $(MPT_MOUNT_POINT) $(SRTC_MOUNT_POINT) $(POWER_MOUNT_POINT) $(VZW_MOUNT_POINT) \
    $(ERI_MOUNT_POINT) $(CARRIER_MOUNT_POINT) $(PERSDATA_MOUNT_POINT)
# END A/B Vendor mounts

# libsymphony
SYMPHONY_LIBS := libsymphonypower.so libsymphony-cpu.so
SYMPHONY_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/lib/,$(notdir $(SYMPHONY_LIBS)))
$(SYMPHONY_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Symphony lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib/libsymphony-1.1.4.so $@

ALL_DEFAULT_INSTALLED_MODULES += $(SYMPHONY_SYMLINKS)

# END libsymphony

# RFS MSM
RFS_MSM_ADSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/adsp/
$(RFS_MSM_ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM ADSP folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/lpass $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/adsp $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_MPSS_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/mpss/
$(RFS_MSM_MPSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM MPSS folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/mpss $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_SLPI_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/slpi/
$(RFS_MSM_SLPI_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM SLPI folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/slpi $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

ALL_DEFAULT_INSTALLED_MODULES += $(RFS_MSM_ADSP_SYMLINKS) $(RFS_MSM_MPSS_SYMLINKS) $(RFS_MSM_SLPI_SYMLINKS)
# END RFS MSM

# WIDEVINE Images
WIDEVINE_IMAGES := \
    widevine.b00 widevine.b01 widevine.b02 widevine.b03 widevine.b04 \
    widevine.b05 widevine.b06 widevine.b07 widevine.mdt

WIDEVINE_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/,$(notdir $(WIDEVINE_IMAGES)))
$(WIDEVINE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WIDEVINE firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/persist-lg/firmware/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WIDEVINE_SYMLINKS)
# END WIDEVINE Images

# Wifi
BDWLAN_IMAGES := \
    bdwlan.bin bdwlan_ch0.bin bdwlan_ch1.bin

BDWLAN_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/,$(notdir $(BDWLAN_IMAGES)))
$(BDWLAN_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "BDWLAN firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/persist-lg/wifi/qcom/$(notdir $@) $@

WCNSS_INI_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini
$(WCNSS_INI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS config ini link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/etc/wifi/$(notdir $@) $@

WCNSS_MAC_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/wlan_mac.bin
$(WCNSS_MAC_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS MAC bin link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /data/misc/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_INI_SYMLINK) $(WCNSS_MAC_SYMLINK) $(BDWLAN_SYMLINKS)
# END Wifi

endif
