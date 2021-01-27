#!/bin/bash

iconvver="1.16"
wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

emconfigure ./configure -q --enable-static --disable-shared
emmake make

mkdir -p ../dist/emscripten/system/lib
mkdir -p ../dist/emscripten/system/include
cp ./lib/.libs/libiconv.a ../dist/emscripten/system/lib
cp ./include/iconv.h ../dist/emscripten/system/include

emmake make clean

PATH=/usr/x86_64-w64-mingw32/bin:$PATH
./configure -q --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32 \
            CC=x86_64-w64-mingw32-gcc \
            CPPFLAGS="-I/usr/x86_64-w64-mingw32/include -Wall" \
            LDFLAGS="-L/usr/x86_64-w64-mingw32/lib"
make

mkdir -p ../dist/win64
cp ./include/iconv.h ./lib/.libs/libiconv-2.dll ./lib/.libs/libiconv.dll.a ./lib/.libs/libiconv.lai ../dist/win64

make clean

PATH=/usr/i686-w64-mingw32/bin:$PATH
./configure -q --host=i686-w64-mingw32 --prefix=/usr/i686-w64-mingw32 \
            CC=i686-w64-mingw32-gcc \
            CPPFLAGS="-I/usr/i686-w64-mingw32/include -Wall" \
            LDFLAGS="-L/usr/i686-w64-mingw32/lib"

make

mkdir -p ../dist/win32
cp ./include/iconv.h ./lib/.libs/libiconv-2.dll ./lib/.libs/libiconv.dll.a ./lib/.libs/libiconv.lai ../dist/win32

cd ..
