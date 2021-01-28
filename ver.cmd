@echo off

if not exist dist mkdir dist

echo VCToolsVersion=%VCToolsVersion%>dist\vsversion.txt
echo VisualStudioVersion=%VisualStudioVersion%>>dist\vsversion.txt
echo VSCMD_VER=%VSCMD_VER%>>dist\vsversion.txt
