#!/bin/sh

set -e

sudo zypper addrepo http://download.opensuse.org/repositories/windows:mingw:win64/openSUSE_Tumbleweed/windows:mingw:win64.repo
sudo zypper --gpg-auto-import-keys refresh

sudo zypper install -y rpm-build

sudo zypper install -y autoconf automake bison gcc-c++ libtool \
  mingw64-cross-binutils mingw64-cross-gcc mingw64-cross-gcc-c++ mingw64-cross-pkg-config mingw64-filesystem \
  pkg-config unzip xorg-x11-libX11 zip
