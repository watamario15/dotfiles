#!/usr/bin/env bash

cd ~/Documents/buildbrain
mkdir -p bin
make ldefconfig lbuild
mv linux-brain/arch/arm/boot/zImage bin/zImage
cp linux-brain/arch/arm/boot/dts/imx28-pwsh*.dtb bin/
