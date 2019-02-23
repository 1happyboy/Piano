#!/bin/bash

source build/envsetup.sh >/dev/null && setpaths
TARGET_PRODUCT=`get_build_var TARGET_PRODUCT`

# source environment and chose target product
DEVICE=`get_build_var TARGET_PRODUCT`
BUILD_VARIANT=`get_build_var TARGET_BUILD_VARIANT`
UBOOT_DEFCONFIG=rk3126_defconfig
KERNEL_DEFCONFIG=rockchip_defconfig
KERNEL_DTS=rk3126-86v-r2
PACK_TOOL_DIR=RKTools/linux/Linux_Pack_Firmware
IMAGE_PATH=rockdev/Image-$TARGET_PRODUCT

lunch $DEVICE-$BUILD_VARIANT

# build uboot
echo "start build uboot"
cd u-boot && make distclean && make $UBOOT_DEFCONFIG && make -j4 && cd -

# build kernel
echo "start build kernel"
cd kernel && make $KERNEL_DEFCONFIG && make $KERNEL_DTS.img -j4 && cd -

# build android
echo "start build android"
make installclean
make -j8

# mkimage.sh
echo "make and copy android images"
./mkimage.sh
cp -f $IMAGE_PATH/* $PACK_TOOL_DIR/rockdev/Image/

# copy images to rockdev
echo "copy u-boot images"
cp u-boot/uboot.img $PACK_TOOL_DIR/rockdev/Image/
cp u-boot/RK3126MiniLoaderAll* $PACK_TOOL_DIR/rockdev/RK3126MiniLoaderAll.bin

echo "copy kernel images"
cp kernel/resource.img $PACK_TOOL_DIR/rockdev/Image
cp kernel/kernel.img $PACK_TOOL_DIR/rockdev/Image

echo "copy manifest.xml"
DATE=$(date  +%Y%m%d_%H%M)
cp manifest.xml $IMAGE_PATH/manifest_${DATE}.xml

cd RKTools/linux/Linux_Pack_Firmware/rockdev && ./mkupdate.sh
