# iconv-win-build

Build `libiconv` in WSL 2

## Environment requirements

* WSL 2

* Visual Studio 2019 Desktop development with C++ workload

* Emscripten 2.x for building wasm

## Building wasm

Open "x64 Native Tools Command Prompt for VS 2019"

```
> wsl
$ ./wasm.sh       # output dist/emscripten
```

## Building x64 DLL

Open "x64 Native Tools Command Prompt for VS 2019"

```
> wsl
$ ./mingw64.sh    # output dist/mingw64
$ ./msvc64.sh     # output dist/msvc64
```

## Building x86 DLL

Open "x64_x86 Cross Tools Command Prompt for VS 2019"

```
> wsl
$ ./mingw32.sh    # output dist/mingw32
$ ./msvc32.sh     # output dist/msvc32
```

## Note

* MinGW DLLs require `msvcrt.dll`

* MSVC DLLs use `/MD` by default so require [Microsoft Visual C++ Redistributable for Visual Studio 2015, 2017 and 2019](https://support.microsoft.com/en-us/topic/the-latest-supported-visual-c-downloads-2647da03-1eea-4433-9aff-95f26a218cc0)

* Executable and DLL should use the same C runtime to make `errno` works well.
