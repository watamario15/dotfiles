#!/usr/bin/env bash
cd ~/Documents/buildbrain
mkdir -p bin
make ldefconfig lbuild
mv linux-brain/arch/arm/boot/zImage bin/zImage
mv linux-brain/arch/arm/boot/dts/imx28-pwsh*.dts bin/
mv linux-brain/arch/arm/boot/dts/imx28-pwsh*.dtb bin/
cp bin/imx28-pwsh6.dts bin/imx28-pwsh7.dts
cp bin/imx28-pwsh6.dtb bin/imx28-pwsh7.dtb
