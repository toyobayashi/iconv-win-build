#!/bin/bash

iconvver="1.16"

if [ ! -f "libiconv-$iconvver.tar.gz" ]; then
  wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
fi

rm -rf "libiconv-$iconvver"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

PATH=/usr/x86_64-w64-mingw32/bin:$PATH
./configure --enable-extra-encodings --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32 \
            CC=x86_64-w64-mingw32-gcc \
            CPPFLAGS="-I/usr/x86_64-w64-mingw32/include -Wall" \
            LDFLAGS="-L/usr/x86_64-w64-mingw32/lib"
make

mkdir -p ../dist/ming64
cp ./include/iconv.h ./lib/.libs/libiconv-2.dll ./lib/.libs/libiconv.dll.a ./lib/.libs/libiconv.lai ../dist/ming64

cd ..

pexports.exe dist/ming64/libiconv-2.dll -o>dist/ming64/libiconv.def
lib.exe /DEF:dist/ming64/libiconv.def /MACHINE:x64 /OUT:dist/ming64/libiconv.lib
