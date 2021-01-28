#!/bin/bash

iconvver="1.16"

if [ ! -f "libiconv-$iconvver.tar.gz" ]; then
  wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
fi

rm -rf "libiconv-$iconvver"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

PATH=/usr/i686-w64-mingw32/bin:$PATH
./configure --enable-extra-encodings --host=i686-w64-mingw32 --prefix=/usr/i686-w64-mingw32 \
            CC=i686-w64-mingw32-gcc \
            CPPFLAGS="-I/usr/i686-w64-mingw32/include -Wall" \
            LDFLAGS="-L/usr/i686-w64-mingw32/lib"
make

mkdir -p ../dist/mingw32
cp ./include/iconv.h ./lib/.libs/libiconv-2.dll ./lib/.libs/libiconv.dll.a ./lib/.libs/libiconv.lai ../dist/mingw32

cd ..

pexports.exe dist/mingw32/libiconv-2.dll -o>dist/mingw32/libiconv.def
lib.exe /DEF:dist/mingw32/libiconv.def /MACHINE:x64 /OUT:dist/mingw32/libiconv.lib
