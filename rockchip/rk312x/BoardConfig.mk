# config.mk
# 
# Product-specific compile-time definitions.
#
include device/rockchip/common/BoardConfig.mk
TARGET_BOARD_PLATFORM := rk312x
TARGET_BOARD_PLATFORM_GPU := mali400

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon

TARGET_CPU_VARIANT := cortex-a7

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
BOARD_USE_LOW_MEM := true
BOARD_HAVE_BLUETOOTH := false
PRODUCT_PACKAGE_OVERLAYS += device/rockchip/rk312x/overlay

#MALLOC_IMPL := dlmalloc

GRAPHIC_MEMORY_PROVIDER := dma_buf

ifeq ($(strip $(BOARD_USE_LOW_MEM)), true)
BUILD_WITH_GOOGLE_MARKET := true
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.jit.codecachesize=0
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heaptargetutilization=0.9
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapstartsize=5m
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapgrowthlimit=64m
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapsize=96m
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapminfree=512k
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapmaxfree=2m

PRODUCT_COPY_FILES += \
	device/rockchip/common/lowmem_package_filter.xml:system/etc/lowmem_package_filter.xml
endif

PRODUCT_COPY_FILES += \
    device/rockchip/rk312x/fstab.$(TARGET_BOARD_HARDWARE).bootmode.unknown:root/fstab.$(TARGET_BOARD_HARDWARE).bootmode.unknown \
    device/rockchip/rk312x/fstab.$(TARGET_BOARD_HARDWARE).bootmode.emmc:root/fstab.$(TARGET_BOARD_HARDWARE).bootmode.emmc \
    device/rockchip/rk312x/init.$(TARGET_BOARD_HARDWARE).bootmode.emmc.rc:root/init.$(TARGET_BOARD_HARDWARE).bootmode.emmc.rc \
    device/rockchip/rk312x/init.$(TARGET_BOARD_HARDWARE).bootmode.unknown.rc:root/init.$(TARGET_BOARD_HARDWARE).bootmode.unknown.rc
