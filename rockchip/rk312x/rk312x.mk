$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
include device/rockchip/rk312x/BoardConfig.mk
$(call inherit-product, device/rockchip/common/device.mk)
PRODUCT_BRAND := rockchip
PRODUCT_DEVICE := rk312x
PRODUCT_NAME := rk312x
PRODUCT_MANUFACTURER := rockchip

# Override appt config
PRODUCT_AAPT_CONFIG := normal large xlarge mdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Get the long list of APNs
PRODUCT_COPY_FILES += vendor/rockchip/common/phone/etc/apns-full-conf.xml:system/etc/apns-conf.xml
PRODUCT_COPY_FILES += vendor/rockchip/common/phone/etc/spn-conf.xml:system/etc/spn-conf.xml

PRODUCT_CHARACTERISTICS := tablet

#$_rbox_$_modify_$_zhengyang: add displayd
PRODUCT_PACKAGES += \
    displayd

PRODUCT_PACKAGES += \
    Launcher3

PRODUCT_PROPERTY_OVERRIDES += \
    ro.rk.hdmi_enable = false \
    ro.product.version = 1.0.0 \
    ro.product.ota.host = www.rockchip.com:2300

