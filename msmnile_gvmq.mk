TARGET_BOARD_PLATFORM := msmnile
TARGET_BOOTLOADER_BOARD_NAME := msmnile
TARGET_BOARD_TYPE := auto
TARGET_BOARD_SUFFIX := _gvmq
ENABLE_AIDL_VHAL := true
TARGET_DISABLE_DISPLAY := false
TARGET_DISABLE_CODEC2 := true
TARGET_DISABLE_VPP_FILTER := true
AUDIO_USE_STUB_HAL := false
# Skip VINTF checks for kernel configs since we do not have kernel source
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

ALLOW_MISSING_DEPENDENCIES := true
  ENABLE_AB ?= true
  # Enable virtual-ab by default
  ifeq ($(ENABLE_AB), true)
    ENABLE_VIRTUAL_AB ?= false
  endif
  ifeq ($(ENABLE_VIRTUAL_AB), true)
    $(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
  endif
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
TARGET_CONSOLE_ENABLED ?= true
# FR77687: Migrate AIDL interface using -ndk_platform.so to -ndk.so
NEED_AIDL_NDK_PLATFORM_BACKEND := true
TARGET_NO_QTI_WFD := true
BOARD_HAVE_QCOM_FM := false
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := false
TARGET_ENABLE_QC_AV_ENHANCEMENTS := false
TARGET_FWK_SUPPORTS_AV_VALUEADDS := true
#TARGET_FWK_SUPPORTS_FULL_VALUEADDS := false
TARGET_USES_AOSP_FOR_WLAN := true
BOARD_HAS_QCOM_WLAN := true
ENABLE_CAR_POWER_MANAGER := true
VPP_TARGET_USES_SERVICE := NO



# Dynamic-partition enabled by default
BOARD_DYNAMIC_PARTITION_ENABLE := true
ifeq ($(strip $(BOARD_DYNAMIC_PARTITION_ENABLE)),true)

  PRODUCT_USE_DYNAMIC_PARTITIONS := true
  BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
  PRODUCT_BUILD_SUPER_PARTITION := true
  PRODUCT_BUILD_RAMDISK_IMAGE := true
  # Enable System_ext
  PRODUCT_BUILD_SYSTEM_EXT_IMAGE := true
  PRODUCT_PACKAGES += fastbootd
  
# Mismatch in the uses-library tags between build system and the manifest leads
# to soong APK manifest_check tool errors. Enable the flag to fix this.
RELAX_USES_LIBRARY_CHECK := true

ifeq ($(ENABLE_AB), true)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_AB_dynamic_partition_variant.qti:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
else
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_non_AB_dynamic_partition_variant.qti:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
endif
endif
#PRODUCT_BUILD_SYSTEM_IMAGE := true
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
#PRODUCT_BUILD_VENDOR_IMAGE := true
PRODUCT_BUILD_PRODUCT_IMAGE := false
PRODUCT_BUILD_PRODUCT_SERVICES_IMAGE := false
#PRODUCT_BUILD_ODM_IMAGE := true
PRODUCT_BUILD_CACHE_IMAGE := false
PRODUCT_BUILD_RAMDISK_IMAGE := true
PRODUCT_BUILD_USERDATA_IMAGE := true
PRODUCT_BUILD_VENDOR_BOOT_IMAGE := true
PRODUCT_BUILD_VENDOR_DLKM_IMAGE := true
PRODUCT_BUILD_SYSTEM_DLKM_IMAGE := true

ifneq ("$(wildcard device/qcom/$(TARGET_BOARD_PLATFORM)-kernel/vendor_dlkm/system_dlkm.modules.blocklist)", "")
PRODUCT_COPY_FILES += device/qcom/$(TARGET_BOARD_PLATFORM)-kernel/vendor_dlkm/system_dlkm.modules.blocklist:$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules/system_dlkm.modules.blocklist
endif

TARGET_DEFINES_DALVIK_HEAP := true
$(call inherit-product, device/qcom/common/common64.mk)
#Inherit all except heap growth limit from phone-xhdpi-2048-dalvik-heap.mk
PRODUCT_PROPERTY_OVERRIDES  += \
   dalvik.vm.heapstartsize=8m \
   dalvik.vm.heapsize=512m \
   dalvik.vm.heaptargetutilization=0.75 \
   dalvik.vm.heapminfree=512k \
   dalvik.vm.heapmaxfree=8m \
   vendor.gatekeeper.disable_spu = true #\


PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=enforce
$(call inherit-product, packages/services/Car/car_product/build/car.mk)

PRODUCT_NAME := msmnile_gvmq
PRODUCT_DEVICE := msmnile_gvmq
PRODUCT_BRAND := qti
PRODUCT_MODEL := msmnile_gvmq for arm64


# Sensor conf files
PRODUCT_COPY_FILES += \
    device/qcom/msmnile_gvmq/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml


SHIPPING_API_LEVEL := 33
PRODUCT_SHIPPING_API_LEVEL := 33

#Initial bringup flags

#Default vendor image configuration
ifeq ($(ENABLE_VENDOR_IMAGE),)
ENABLE_VENDOR_IMAGE := false
endif

TARGET_KERNEL_VERSION := 5.15
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

# Bluetooth DLKM
BT_DLKM := btpower.ko
PRODUCT_PACKAGES += $(BT_DLKM)

PCIE_DLKM := pci_msm_drv
PRODUCT_PACKAGES += $(PCIE_DLKM)

# HS-I2S DLKM
#PRODUCT_PACKAGES += hsi2s.ko
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

PRODUCT_PROPERTY_OVERRIDES  += \
   ro.crypto.state=unencrypted


PRODUCT_PACKAGES += fstab.postinstall \
                    cppreopts.sh \
                    preloads_copy.sh \
                    cppreopts.rc

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
#PRODUCT_COPY_FILES += device/qcom/msmnile/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

#Copy unsupported features list
#PRODUCT_COPY_FILES += \
#    device/qcom/msmnile_gvmq/msmnile_gvmq_excluded_features.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/msmnile_gvmq_excluded_features.xml


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
TARGET_WLAN_CHIP := qca6390
include device/qcom/wlan/msmnile_au/wlan.mk
endif

TARGET_MOUNT_POINTS_SYMLINKS := false


PRODUCT_PROPERTY_OVERRIDES += vendor.usb.diag_mdm.inst.name=diag_mdm2

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

#PRODUCT_PACKAGES += android.hardware.automotive.audiocontrol@1.0-service

PRODUCT_PACKAGES += android.hardware.health@2.1-service \
                    android.hardware.health@2.1-impl \
                    android.hardware.health@2.1-impl.recovery \
                    android.hardware.dumpstate@1.1-service.example \
                    android.hardware.thermal@2.0-service.mock \

PRODUCT_PACKAGES += android.hardware.gnss@2.0-service
PRODUCT_PACKAGES += qcar-gsi.avbpubkey

#add vndservicemanager
PRODUCT_PACKAGES += vndservicemanager

#add neuralnetworks
PRODUCT_PACKAGES += android.hardware.neuralnetworks@1.0.vendor \
                    android.hardware.neuralnetworks@1.1.vendor \
                    android.hardware.neuralnetworks@1.2.vendor \
                    android.hardware.neuralnetworks@1.3.vendor

PRODUCT_ENFORCE_RRO_TARGETS := framework-res

#add libnbaio for avenhancement
PRODUCT_PACKAGES += libnbaio

PRODUCT_VENDOR_PROPERTIES += rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so \
                persist.rild.nitz_plmn=
                persist.rild.nitz_long_ons_0=
                persist.rild.nitz_long_ons_1=
                persist.rild.nitz_long_ons_2=
                persist.rild.nitz_long_ons_3=
                persist.rild.nitz_short_ons_0=
                persist.rild.nitz_short_ons_1=
                persist.rild.nitz_short_ons_2=
                persist.rild.nitz_short_ons_3=
                ril.subscription.types=NV,RUIM \
                persist.adb.tcp.port=5555 \
                DEVICE_PROVISIONED=1 \
                dalvik.vm.heapsize=36m \
                dev.pm.dyn_samplingrate=1 \
                qcom.hw.aac.encoder=true

# Set network mode to (T/L/G/W/1X/EVDO, T/L/G/W/1X/EVDO) for 7+7 mode device on DSDS mode
PRODUCT_VENDOR_PROPERTIES += ro.telephony.default_network=22,22 \
                            ro.radio.noril=true

# system props for the cne module
PRODUCT_VENDOR_PROPERTIES += persist.vendor.cne.feature=1

#system props for the MM modules
PRODUCT_VENDOR_PROPERTIES += media.stagefright.enable-player=true \
                            media.stagefright.enable-http=true \
                            media.stagefright.enable-aac=true \
                            media.stagefright.enable-qcp=true \
                            media.stagefright.enable-fma2dp=true \
                            media.stagefright.enable-scan=true \
                            mmp.enable.3g2=true \
                            media.aac_51_output_enabled=true \
                            mm.enable.smoothstreaming=true

#13631487 is decimal sum of supported codecs in AAL
#codecs:(PARSER_)AAC AC3 AMR_NB AMR_WB ASF AVI DTS FLV 3GP 3G2 MKV MP2PS MP2TS MP3 OGG QCP WAV FLAC AIFF APE DSD MOV XVID
PRODUCT_VENDOR_PROPERTIES += vendor.mm.enable.qcom_parser=63963135 \
                            persist.mm.enable.prefetch=true

# system props for the data modules
PRODUCT_VENDOR_PROPERTIES += ro.vendor.use_data_netmgrd=true \
                            persist.vendor.data.mode=concurrent

#system props for time-services
PRODUCT_VENDOR_PROPERTIES += persist.timed.enable=true

# system prop for opengles version
# 196608 is decimal for 0x30000 to report version 3
# 196609 is decimal for 0x30001 to report version 3.1
# 196610 is decimal for 0x30002 to report version 3.2
PRODUCT_VENDOR_PROPERTIES += ro.opengles.version=196610

# system property for maximum number of HFP client connections
PRODUCT_VENDOR_PROPERTIES += bt.max.hfpclient.connections=1

# system prop to turn on CdmaLTEPhone always
PRODUCT_VENDOR_PROPERTIES += telephony.lteOnCdmaDevice=1

#Simulate sdcard on /data/media
PRODUCT_VENDOR_PROPERTIES += persist.fuse_sdcard=true

#system prop for wipower support
PRODUCT_VENDOR_PROPERTIES += ro.bluetooth.emb_wp_mode=false \
                            ro.bluetooth.wipower=false

PRODUCT_VENDOR_PROPERTIES += persist.vendor.service.bt.a2dp.sink=true \
                            persist.vendor.btstack.enable.splita2dp=false \
                            persist.vendor.service.bdroid.sibs=false \
                            persist.bt.clock_boottime_alarm=false

# system prop for Hardware type Automotive
PRODUCT_VENDOR_PROPERTIES += ro.hardware.type=automotive

PRODUCT_VENDOR_PROPERTIES += ro.hardware.sensors=msmnile.asm_auto

# snapdragon value add features
PRODUCT_VENDOR_PROPERTIES += ro.qc.sdk.audio.ssr=false

# fluencetype can be "fluence" or "fluencepro" or "none"
PRODUCT_VENDOR_PROPERTIES += ro.qc.sdk.audio.fluencetype=none \
                            persist.audio.fluence.voicecall=true \
                            persist.audio.fluence.voicerec=false \
                            persist.audio.fluence.speaker=true

# system prop for RmNet Data
PRODUCT_VENDOR_PROPERTIES += persist.rmnet.data.enable=true \
                            persist.data.wda.enable=true \
                            persist.data.df.dl_mode=5 \
                            persist.data.df.ul_mode=5 \
                            persist.data.df.agg.dl_pkt=10 \
                            persist.data.df.agg.dl_size=4096 \
                            persist.data.df.mux_count=8 \
                            persist.data.df.iwlan_mux=9 \
                            persist.data.df.dev_name=rmnet_usb0

# property to enable user to access Google WFD settings
PRODUCT_VENDOR_PROPERTIES += persist.debug.wfd.enable=1

# property to choose between virtual/external wfd display
PRODUCT_VENDOR_PROPERTIES += persist.sys.wfd.virtual=0

# enable tunnel encoding for amrwb
PRODUCT_VENDOR_PROPERTIES += tunnel.audio.encode = true

#Buffer size in kbytes for compress offload playback
PRODUCT_VENDOR_PROPERTIES += audio.offload.buffer.size.kb=32

# Enable offload audio video playback by default
PRODUCT_VENDOR_PROPERTIES += av.offload.enable=true

# Enable voice path for PCM VoIP by default
PRODUCT_VENDOR_PROPERTIES += use.voice.path.for.pcm.voip=true

# system prop for NFC DT
PRODUCT_VENDOR_PROPERTIES += ro.nfc.port=I2C

# Enable dsp gapless mode by default
PRODUCT_VENDOR_PROPERTIES += audio.offload.gapless.enabled=true

# initialize QCA1530 detection
PRODUCT_VENDOR_PROPERTIES += sys.qca1530=detect

# Enable stm events
PRODUCT_VENDOR_PROPERTIES += persist.debug.coresight.config=stm-events

# hwui properties
PRODUCT_VENDOR_PROPERTIES += ro.hwui.texture_cache_size=72 \
                            ro.hwui.layer_cache_size=48 \
                            ro.hwui.r_buffer_cache_size=8 \
                            ro.hwui.path_cache_size=32 \
                            ro.hwui.gradient_cache_size=1 \
                            ro.hwui.drop_shadow_cache_size=6 \
                            ro.hwui.texture_cache_flushrate=0.4 \
                            ro.hwui.text_small_cache_width=1024 \
                            ro.hwui.text_small_cache_height=1024 \
                            ro.hwui.text_large_cache_width=2048 \
                            ro.hwui.text_large_cache_height=1024 \

PRODUCT_VENDOR_PROPERTIES += config.disable_rtt=true

#Bringup properties
PRODUCT_VENDOR_PROPERTIES += persist.sys.force_sw_gles=1 \
                            persist.vendor.radio.atfwd.start=true \
                            ro.kernel.qemu.gles=0 \
                            qemu.hw.mainkeys=0

#Increase cached app limit
PRODUCT_VENDOR_PROPERTIES += ro.vendor.qti.sys.fw.bg_apps_limit=60

# Enable ZRAM
PRODUCT_VENDOR_PROPERTIES += ro.vendor.qti.config.zram=true

#IOP properties
PRODUCT_VENDOR_PROPERTIES += vendor.iop.enable_uxe=1 \
                            vendor.perf.iop_v3.enable=true

# Property to enable perf boosts from System Server
PRODUCT_VENDOR_PROPERTIES += vendor.perf.gestureflingboost.enable=true

#Enable ULMK properties
PRODUCT_VENDOR_PROPERTIES += ro.lmk.kill_heaviest_task=true \
                            ro.lmk.kill_timeout_ms=15 \
                            ro.lmk.use_minfree_levels=true \
                            ro.lmk.enhance_batch_kill=true \
                            ro.lmk.enable_adaptive_lmk=true \
                            ro.lmk.vmpressure_file_min=80640 \

#Property to enable scroll pre-obtain view
PRODUCT_VENDOR_PROPERTIES += ro.vendor.scroll.preobtain.enable=true

#Expose aux camera for below packages
PRODUCT_VENDOR_PROPERTIES += vendor.camera.aux.packagelist=org.codeaurora.snapcam

#Display mirroring
PRODUCT_VENDOR_PROPERTIES += vendor.display.builtin_mirroring=true

#Display hwcId allocation
PRODUCT_VENDOR_PROPERTIES += vendor.display.builtin_baseid_and_size=5,3 \
                            vendor.display.pluggable_baseid_and_size=1,4 \
                            vendor.display.virtual_baseid_and_size=8,1 \

# Enable CPMS for LPM
PRODUCT_VENDOR_PROPERTIES += persist.vendor.car.lpm=true

# default wifi country code
PRODUCT_VENDOR_PROPERTIES += ro.boot.wificountrycode=us

# The property "persist.bluetooth.enablenewavrcp" is introduced in AOSP.
# See commit e63f6d6bda16bd94d43537fc5db754a103c6a757
# (1) If the property is set as true, it indicates that AVRCP(TG) is enabled.
# (2) If the property is set as false, it indicates that AVRCP(CT) is enabled.
# In Fluoride Bluetooth stack, the default value for the property is true. This is valid with Mobile SP.
# However in Automotive SP, AVRCP(CT) is enabled in Car UI.
# So the property should be set as false.
PRODUCT_VENDOR_PROPERTIES += persist.bluetooth.enablenewavrcp=false

###################################################################################
# This is the End of target.mk file.
# Now, Pickup other split product.mk files:
###################################################################################
# TODO: Relocate the system product.mk files pickup into qssi lunch, once it is up.
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/system/*.mk)
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/vendor/*.mk)
###################################################################################
