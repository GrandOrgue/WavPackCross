#!/bin/bash

set -e

SRC_DIR=`dirname $0`/../..
PARALLEL_PRMS="-j$(nproc)"

mkdir -p build/win64
rm -rf build/win64/*
cp -Rv $SRC_DIR/wavpack-4.60.1 build/win64/src
mkdir build/win64/inst
INST_DIR=`readlink -f build/win64/inst`

pushd build/win64/src


export PATH="/usr/x86_64-w64-mingw32/sys-root/mingw/bin:$PATH"
export LIBPNG16_CONFIG=/usr/x86_64-w64-mingw32/sys-root/mingw/bin/libpng16-config
export HOST_CC=gcc
export CC=x86_64-w64-mingw32-gcc
export CFLAGS="-O2 -g -pipe -Wall -fexceptions --param=ssp-buffer-size=4 -mms-bitfields"
export CXX=x86_64-w64-mingw32-g++
export CXXFLAGS="-O2 -g -pipe -Wall -fexceptions --param=ssp-buffer-size=4 -mms-bitfields"
export PKG_CONFIG_PATH="/usr/x86_64-w64-mingw32/sys-root/mingw/lib/pkgconfig:/usr/x86_64-w64-mingw32/sys-root/mingw/share/pkgconfig"
export LDFLAGS="-Wl,--exclude-libs=libintl.a -Wl,--exclude-libs=libiconv.a -Wl,--no-keep-memory -fstack-protector"

./configure --cache-file=mingw64-config.cache \
	--host=x86_64-w64-mingw32 \
	--build=x86_64-suse-linux-gnu \
	--target=x86_64-w64-mingw32 \
	--prefix=/usr/x86_64-w64-mingw32/sys-root/mingw \
	--exec-prefix=/usr/x86_64-w64-mingw32/sys-root/mingw \
	--bindir=/usr/x86_64-w64-mingw32/sys-root/mingw/bin \
	--sbindir=/usr/x86_64-w64-mingw32/sys-root/mingw/sbin \
	--sysconfdir=/usr/x86_64-w64-mingw32/sys-root/mingw/etc \
	--datadir=/usr/x86_64-w64-mingw32/sys-root/mingw/share \
	--includedir=/usr/x86_64-w64-mingw32/sys-root/mingw/include \
	--libdir=/usr/x86_64-w64-mingw32/sys-root/mingw/lib \
	--libexecdir=/usr/x86_64-w64-mingw32/sys-root/mingw/libexec \
	--localstatedir=/usr/x86_64-w64-mingw32/sys-root/mingw/var \
	--sharedstatedir=/usr/x86_64-w64-mingw32/sys-root/mingw/com \
	--mandir=/usr/x86_64-w64-mingw32/sys-root/mingw/share/man \
	--infodir=/usr/x86_64-w64-mingw32/sys-root/mingw/share/info --disable-static


make $PARALLEL_PRMS
make DESTDIR=$INST_DIR install

popd

