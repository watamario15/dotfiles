#!/usr/bin/env bash

cd ~/Documents/buildbrain
mkdir -p bin
make udefconfig-sh1 ubuild nkbin-maker nk.bin
mv nk.bin bin/edsa1exe.bin
make udefconfig-sh2 ubuild nkbin-maker nk.bin
mv nk.bin bin/edsa2exe.bin
make udefconfig-sh3 ubuild nkbin-maker nk.bin
mv nk.bin bin/edsa3exe.bin
make udefconfig-sh4 ubuild nkbin-maker nk.bin
mv nk.bin bin/edsh4exe.bin
make udefconfig-sh5 ubuild nkbin-maker nk.bin
mv nk.bin bin/edsh5exe.bin
make udefconfig-sh6 ubuild nkbin-maker nk.bin
mv nk.bin bin/edsh6exe.bin
make udefconfig-sh7 ubuild nkbin-maker nk.bin
mv nk.bin bin/edsh7exe.bin
