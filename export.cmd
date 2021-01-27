@echo off

@REM call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

pexports libiconv\win32\libiconv-2.dll -o>libiconv\win32\libiconv.def
pexports libiconv\win64\libiconv-2.dll -o>libiconv\win64\libiconv.def

lib /DEF:libiconv\win32\libiconv.def /MACHINE:x86 /OUT:libiconv\win32\libiconv.lib
lib /DEF:libiconv\win64\libiconv.def /MACHINE:x64 /OUT:libiconv\win64\libiconv.lib
