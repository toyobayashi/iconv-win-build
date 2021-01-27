#!/bin/bash

iconvver="1.16"

if [ ! -f "libiconv-$iconvver.tar.gz" ]; then
  wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
fi

rm -rf "libiconv-$iconvver"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

emconfigure ./configure -q --enable-static --disable-shared
emmake make

mkdir -p ../dist/emscripten/system/lib
mkdir -p ../dist/emscripten/system/include
cp ./lib/.libs/libiconv.a ../dist/emscripten/system/lib
cp ./include/iconv.h ../dist/emscripten/system/include

emmake make clean

VCFLAGS="/nologo /GS /Gm- /WX- /Gd /W3 /O2 /MD /source-charset:utf-8 /Zc:wchar_t,inline,forScope /fp:precise /diagnostics:column"

./configure -q --host=x86_64-w64-mingw32  --prefix=/usr/local/msvc64 \
            CC="cl.exe" \
            CFLAGS="$VCFLAGS" \
            CXX="cl.exe" \
            CXXFLAGS="$VCFLAGS" \
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
