#!/usr/bin/env bash
set -e
if(test $# -ne 1); then
    echo "Error: ソースファイル名を1つ指定してください。"
    exit
fi

if(test -e "resource.rc"); then
    # withres
    echo "*** C++ソース($1)をコンパイル+アセンブル中..."
    if(test -e "$1.o"); then
        rm -f "$1.o"
    fi
    arm-mingw32ce-g++ -Wall -O2 -std=gnu++2a -march=armv5tej -mcpu=arm926ej-s -c $1 -o $1.o
    if(! test -e "$1.o"); then
        echo "ビルド失敗"; exit
    fi

    echo "*** リソース(resource.rc)を前処理+アセンブル中..."
    if(test -e "resource.rc.o"); then
        rm -f "resource.rc.o"
    fi
    arm-mingw32ce-windres resource.rc resource.rc.o
    if(! test -e "resource.rc.o"); then
        echo "ビルド失敗"; exit
    fi

    echo "*** $1.oとresource.rc.oをリンク中..."
    arm-mingw32ce-g++ $1.o resource.rc.o -static -s -lcommctrl -o AppMain.exe
    if(! test -e "AppMain.exe"); then
        echo "ビルド失敗"; exit
    fi
else
    echo "*** C++ソース($1)をビルド中..."
    arm-mingw32ce-g++ -Wall -O2 -std=gnu++2a -march=armv5tej -mcpu=arm926ej-s -static -s -lcommctrl -o AppMain.exe $1
    if(! test -e "AppMain.exe"); then
        echo "ビルド失敗"; exit
    fi
fi

echo "ビルド成功"