#!/bin/bash

iconvver="1.16"
wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

./configure --host=x86_64-w64-mingw32  --prefix=/usr/local/msvc32 \
            CC="cl.exe -nologo" \
            CFLAGS="-MD" \
            CXX="cl.exe -nologo" \
            CXXFLAGS="-MD" \
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

mkdir -p ../dist/win64
cp ./include/iconv.h ./lib/.libs/* ../dist/win64

make clean

./configure --host=i686-w64-mingw32  --prefix=/usr/local/msvc64 \
            CC="cl.exe -nologo" \
            CFLAGS="-MD" \
            CXX="cl.exe -nologo" \
            CXXFLAGS="-MD" \
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

make clean
