#!/bin/bash

iconvver="1.16"

if [ ! -f "libiconv-$iconvver.tar.gz" ]; then
  wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
fi

rm -rf "libiconv-$iconvver"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

emconfigure ./configure --enable-extra-encodings --enable-static --disable-shared
emmake make

mkdir -p ../dist/emscripten/system/lib
mkdir -p ../dist/emscripten/system/include
cp ./lib/.libs/libiconv.a ../dist/emscripten/system/lib
cp ./include/iconv.h ../dist/emscripten/system/include

cd ..
