#!/bin/bash

iconvver="1.16"

if [ ! -f "libiconv-$iconvver.tar.gz" ]; then
  wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
fi

rm -rf "libiconv-$iconvver"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

VCFLAGS="/nologo /GS /analyze- /Gm- /WX- /Gd /W3 /O2 /Oy- /MD /source-charset:utf-8 /Zc:wchar_t,inline,forScope /fp:precise /diagnostics:column"

./configure --enable-extra-encodings --host=i686-w64-mingw32  --prefix=/usr/local/msvc32 \
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

mkdir -p ../dist/msvc32
cp ./include/iconv.h ./lib/.libs/* ../dist/msvc32
