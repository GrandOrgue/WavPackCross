#!/bin/sh

set -e

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  file binutils autoconf automake bison libtool make \
  binutils-mingw-w64-x86-64 gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64 \
  xsltproc libxml2-utils docbook-xsl
