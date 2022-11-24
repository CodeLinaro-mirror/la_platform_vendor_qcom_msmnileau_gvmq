TARGET_BOARD_PLATFORM := msmnile
TARGET_BOOTLOADER_BOARD_NAME := msmnile
TARGET_BOARD_TYPE := auto
TARGET_BOARD_SUFFIX := _gvmq
PRODUCT_MANUFACTURER := qti
PRODUCT_DEVICE := msmnile_gvmq

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

ALLOW_MISSING_DEPENDENCIES := true
# Enable AVB 2.0
BOARD_AVB_ENABLE := true
BOARD_USES_QCNE := false
TARGET_BOARD_AUTO := true
TARGET_USES_AOSP := true
TARGET_USES_GAS := true
TARGET_USES_QCOM_BSP := false
TARGET_NO_TELEPHONY := true
TARGET_USES_QTIC := false
TARGET_USES_QTIC_EXTENSION := false
ENABLE_HYP := true
BOARD_HAS_QCOM_WLAN := true
TARGET_NO_QTI_WFD := true
BOARD_HAVE_QCOM_FM := false
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := false
TARGET_ENABLE_QC_AV_ENHANCEMENTS := false
TARGET_FWK_SUPPORTS_AV_VALUEADDS := true
TARGET_USES_AOSP_FOR_WLAN := true
ENABLE_CAR_POWER_MANAGER := true
VPP_TARGET_USES_SERVICE := NO
BOARD_HAVE_DUAL_BLUETOOTH := true
TARGET_SUPPORT_DUAL_WLAN := true

# Mismatch in the uses-library tags between build system and the manifest leads
# to soong APK manifest_check tool errors. Enable the flag to fix this.
RELAX_USES_LIBRARY_CHECK := true

# Dynamic-partition enabled by default
BOARD_DYNAMIC_PARTITION_ENABLE := true
ifeq ($(strip $(BOARD_DYNAMIC_PARTITION_ENABLE)),true)
  ENABLE_AB = true
  # Enable virtual-ab by default
  ifeq ($(ENABLE_AB), true)
    ENABLE_VIRTUAL_AB ?= true
  endif
  ifeq ($(ENABLE_VIRTUAL_AB), true)
    $(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
  endif
  PRODUCT_USE_DYNAMIC_PARTITIONS := true
  BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
  PRODUCT_BUILD_SUPER_PARTITION := true
  PRODUCT_BUILD_RAMDISK_IMAGE := true
  # Enable System_ext
  PRODUCT_BUILD_SYSTEM_EXT_IMAGE := true
  PRODUCT_PACKAGES += fastbootd
  PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
  PRODUCT_BUILD_PRODUCT_IMAGE := false
  PRODUCT_BUILD_PRODUCT_SERVICES_IMAGE := false
  PRODUCT_BUILD_CACHE_IMAGE := false
  PRODUCT_BUILD_RAMDISK_IMAGE := true
  PRODUCT_BUILD_USERDATA_IMAGE := true
  PRODUCT_BUILD_VENDOR_BOOT_IMAGE := true

  # Using sha256 for dm-verity partitions.
  # system, system_other, system_ext and product.
  BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
  BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
  BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

  ifeq ($(ENABLE_AB), true)
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_AB_dynamic_partition_variant.qti:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_AB_dynamic_partition_variant.gen4.qti:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.gen4.qcom
  else
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_non_AB_dynamic_partition_variant.qti:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_non_AB_dynamic_partition_variant.gen4.qti:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.gen4.qcom
  endif
endif #BOARD_DYNAMIC_PARTITION_ENABLE
TARGET_DEFINES_DALVIK_HEAP := true
$(call inherit-product, device/qcom/common/common64.mk)
#Inherit all except heap growth limit from phone-xhdpi-2048-dalvik-heap.mk
PRODUCT_PROPERTY_OVERRIDES  += \
   dalvik.vm.heapstartsize=8m \
   dalvik.vm.heapsize=512m \
   dalvik.vm.heaptargetutilization=0.75 \
   dalvik.vm.heapminfree=512k \
   dalvik.vm.heapmaxfree=8m \
   vendor.gatekeeper.disable_spu = true \

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES  += \
   persist.vendor.usb.config=diag,adb
else
PRODUCT_PROPERTY_OVERRIDES  += \
   persist.vendor.usb.config=adb
endif

PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=enforce

$(call inherit-product, packages/services/Car/car_product/build/car.mk)

PRODUCT_NAME := msmnile_gvmq
PRODUCT_DEVICE := msmnile_gvmq
PRODUCT_BRAND := qti
PRODUCT_MODEL := msmnile_gvmq for arm64


# Sensor conf files
PRODUCT_COPY_FILES += \
    device/qcom/msmnile_gvmq/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

SHIPPING_API_LEVEL := 32
PRODUCT_SHIPPING_API_LEVEL := 32

#Initial bringup flags

#Default vendor image configuration
ifeq ($(ENABLE_VENDOR_IMAGE),)
ENABLE_VENDOR_IMAGE := false
endif

TARGET_KERNEL_VERSION := 5.4
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

#Enable llvm support for kernel
KERNEL_LLVM_SUPPORT := true

#Enable sd-llvm suppport for kernel
KERNEL_SD_LLVM_SUPPORT := false

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

BOARD_FRP_PARTITION_NAME := frp

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# diag-router
ifeq ($(strip $(TARGET_BUILD_VARIANT)),user)
    TARGET_HAS_DIAG_ROUTER := false
else
    TARGET_HAS_DIAG_ROUTER := true
endif

# Memtrack HAL deprecated. Replaced with AIDL for target-level 6.
ENABLE_MEMTRACK_AIDL_HAL := true

-include $(QCPATH)/common/config/qtic-config.mk

PRODUCT_BOOT_JARS += tcmiface

ifneq ($(TARGET_NO_TELEPHONY), true)
 PRODUCT_BOOT_JARS += telephony-ext
 PRODUCT_PACKAGES += telephony-ext
endif

TARGET_DISABLE_DASH := true
TARGET_DISABLE_QTI_VPP := false

ifneq ($(TARGET_DISABLE_DASH), true)
    PRODUCT_BOOT_JARS += qcmediaplayer
endif

ifeq ($(TARGET_NO_QTI_WFD),)
    PRODUCT_BOOT_JARS += WfdCommon
endif

# Ethernet configuration file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

# Video codec configuration files
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msmnile/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml

PRODUCT_COPY_FILES += device/qcom/msmnile/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
PRODUCT_COPY_FILES += device/qcom/msmnile/media_codecs_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor.xml

PRODUCT_COPY_FILES += device/qcom/msmnile/media_codecs_vendor_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_audio.xml

PRODUCT_COPY_FILES += device/qcom/msmnile/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml
endif #TARGET_ENABLE_QC_AV_ENHANCEMENTS

#PRODUCT_COPY_FILES += hardware/qcom/media/conf_files/msmnile/system_properties.xml:$(TARGET_COPY_OUT_VENDOR)/etc/system_properties.xml

PRODUCT_PACKAGES += android.hardware.media.omx@1.0-impl

#Audio DLKM
AUDIO_DLKM := audio_apr.ko
AUDIO_DLKM += audio_snd_event.ko
AUDIO_DLKM += audio_q6_notifier.ko
AUDIO_DLKM += audio_adsp_loader.ko
AUDIO_DLKM += audio_q6.ko
AUDIO_DLKM += audio_platform.ko
AUDIO_DLKM += audio_hdmi.ko
AUDIO_DLKM += audio_stub.ko
AUDIO_DLKM += audio_native.ko
AUDIO_DLKM += audio_machine_msmnile.ko
PRODUCT_PACKAGES += $(AUDIO_DLKM)

PCIE_DLKM := pci_msm_drv
PRODUCT_PACKAGES += $(PCIE_DLKM)

CNSS_DLKM := cnss2
PRODUCT_PACKAGES += $(CNSS_DLKM)

ifeq ($(BOARD_HAVE_DUAL_BLUETOOTH),true)
BT_DLKM += btpower_new.ko
PRODUCT_PACKAGES += $(BT_DLKM)
endif

# HS-I2S DLKM
PRODUCT_PACKAGES += hsi2s.ko
# HS-I2S test app
PRODUCT_PACKAGES += hsi2s_test

PRODUCT_PACKAGES += fs_config_files

#A/B related packages
PRODUCT_PACKAGES += update_engine \
    update_engine_client \
    update_verifier \
    bootctrl.msmnile \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    update_engine_sideload

# bootctrl property
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.bootctrl.enable=true

PRODUCT_HOST_PACKAGES += \
	brillo_update_payload

#Healthd packages
PRODUCT_PACKAGES += \
    libhealthd.msm

# MTMD enablement
PRODUCT_COPY_FILES += \
    device/qcom/msmnile_gvmq/input-port-associations.xml:$(TARGET_COPY_OUT_VENDOR)/etc/input-port-associations.xml \
    device/qcom/msmnile_gvmq/display_settings.xml:$(TARGET_COPY_OUT_VENDOR)/etc/display_settings.xml

DEVICE_MANIFEST_FILE := device/qcom/msmnile_gvmq/manifest.xml
DEVICE_MATRIX_FILE   := device/qcom/common/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := device/qcom/msmnile_gvmq/framework_manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := vendor/qcom/opensource/core-utils/vendor_framework_compatibility_matrix.xml

# Enable Scoped Storage related
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Display/Graphics
PRODUCT_PACKAGES += \
    android.hardware.broadcastradio@1.0-impl

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += device/qcom/msmnile/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

#Copy unsupported features list
PRODUCT_COPY_FILES += \
    device/qcom/msmnile_gvmq/msmnile_gvmq_excluded_features.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/msmnile_gvmq_excluded_features.xml


# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/msmnile_gvmq/$(KERNEL_MODULES_INSTALL)/lib/modules

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

#Enable full treble flag
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

#Enable vndk-sp Libraries
PRODUCT_PACKAGES += vndk_package

DEVICE_PACKAGE_OVERLAYS += device/qcom/msmnile_gvmq/overlay

# Enable flag to support slow devices
TARGET_PRESIL_SLOW_BOARD := true

ENABLE_VENDOR_RIL_SERVICE := true

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
# Multiple chips
TARGET_WLAN_CHIP := qca6174 qca6390 qcn7605 qca6490
include device/qcom/wlan/msmnile_au/wlan.mk
WLAN_CFG_OVERRIDE_qca6390 += CONFIG_VCPU_TIMESTOLEN=y
WLAN_CFG_OVERRIDE_qca6174 += CONFIG_VCPU_TIMESTOLEN=y
WLAN_CFG_OVERRIDE_qcn7605 += CONFIG_VCPU_TIMESTOLEN=y
WLAN_CFG_OVERRIDE_qca6490 += CONFIG_VCPU_TIMESTOLEN=y
endif

TARGET_MOUNT_POINTS_SYMLINKS := false

#Copy supported features list
ifeq ($(TARGET_USES_GAS),true)
PRODUCT_COPY_FILES += device/qcom/msmnile_gvmq/msmnile_gvmq_features.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/msmnile_gvmq_features.xml
endif

# Camera configuration file. Shared by passthrough/binderized camera HAL
PRODUCT_PACKAGES += camera.device@3.2-impl
PRODUCT_PACKAGES += camera.device@1.0-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-service

# enable audio hidl hal 5.0
PRODUCT_PACKAGES += \
    android.hardware.audio@5.0 \
    android.hardware.audio.common@5.0 \
    android.hardware.audio.common@5.0-util \
    android.hardware.audio@5.0-impl \
    android.hardware.audio.effect@5.0 \
    android.hardware.audio.effect@5.0-impl

#Boot control HAL test app
PRODUCT_PACKAGES_DEBUG += bootctl

PRODUCT_PACKAGES += \
   update_engine_sideload

PRODUCT_PACKAGES += android.hardware.health@2.1-service \
                    android.hardware.health@2.1-impl \
                    android.hardware.health@2.1-impl.recovery \
                    android.hardware.dumpstate@1.1-service.example \
                    android.hardware.thermal@2.0-service.mock \

PRODUCT_PACKAGES += android.hardware.gnss@2.0-service
PRODUCT_PACKAGES += qcar-gsi.avbpubkey

#add vndservicemanager
PRODUCT_PACKAGES += vndservicemanager
PRODUCT_PACKAGES += fstab.gen4.qcom

#add neuralnetworks
PRODUCT_PACKAGES += android.hardware.neuralnetworks@1.0.vendor \
                    android.hardware.neuralnetworks@1.1.vendor \
                    android.hardware.neuralnetworks@1.2.vendor \
                    android.hardware.neuralnetworks@1.3.vendor

PRODUCT_ENFORCE_RRO_TARGETS := framework-res

#add libnbaio for avenhancement
PRODUCT_PACKAGES += libnbaio

###################################################################################
# This is the End of target.mk file.
# Now, Pickup other split product.mk files:
###################################################################################
# TODO: Relocate the system product.mk files pickup into qssi lunch, once it is up.
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/system/*.mk)
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/vendor/*.mk)
###################################################################################
