#!/bin/bash

iconvver="1.16"

if [ ! -f "libiconv-$iconvver.tar.gz" ]; then
  wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$iconvver.tar.gz"
fi

rm -rf "libiconv-$iconvver"
tar xf "libiconv-$iconvver.tar.gz"
cd "libiconv-$iconvver"

VCFLAGS="/nologo /GS /Gm- /WX- /Gd /W3 /O2 /MT /source-charset:utf-8 /Zc:wchar_t,inline,forScope /fp:precise /diagnostics:column"

./configure --enable-extra-encodings --host=x86_64-w64-mingw32  --prefix=/usr/local/msvc64 \
            --enable-static --disable-shared \
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
            AR_FLAGS="/OUT:" \
            RANLIB=":"
sed -i 's/old_archive_cmds="\\$AR \\$AR_FLAGS /old_archive_cmds="\\$AR \\$AR_FLAGS/' libtool

cp ./libcharset/include/localcharset.h ./lib

cd lib
make all
cd ..

mkdir -p ../dist/msvc64static
cp ./include/iconv.h ./lib/.libs/* ../dist/msvc64static
