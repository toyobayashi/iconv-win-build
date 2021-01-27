#!/bin/bash

iconvver="1.16"

if [ ! -f "libiconv-$iconvver.tar.gz" ]; then
  wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
fi

rm -rf "libiconv-$iconvver"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

./configure -q --host=i686-w64-mingw32  --prefix=/usr/local/msvc64 \
            CC="cl.exe -nologo" \
            CFLAGS="/MD /source-charset:utf-8" \
            CXX="cl.exe -nologo" \
            CXXFLAGS="/MD /source-charset:utf-8" \
            CPPFLAGS="-D_WIN32_WINNT=_WIN32_WINNT_WIN7" \
            LDFLAGS="" \
            LD="link.exe" \
            NM="dumpbin.exe -symbols" \
            STRIP=":" \
            AR="lib.exe" \
            RANLIB=":"

cp ./libcharset/include/localcharset.h ./lib

cd lib
make all
cd ..

mkdir -p ../dist/win32
cp ./include/iconv.h ./lib/.libs/* ../dist/win32
