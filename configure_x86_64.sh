DEVELOPER="$(xcode-select --print-path)"
SDKROOT="$(xcodebuild -version -sdk iphonesimulator | grep -E '^Path' | sed 's/Path: //')"
ARCH="x86_64"

ICU_PATH="$(pwd)/icu"
ICU_FLAGS="-I$ICU_PATH/source/common/ -I$ICU_PATH/source/tools/tzcode/ "

export CXX="$DEVELOPER/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++"
export CC="$DEVELOPER/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang"
export CFLAGS="-isysroot $SDKROOT -I$SDKROOT/usr/include/ -I./include/ -arch $ARCH -miphoneos-version-min=7.0 $ICU_FLAGS"
export CXXFLAGS="-stdlib=libc++ -std=c++11 -isysroot $SDKROOT -I$SDKROOT/usr/include/ -I./include/ -arch $ARCH -miphoneos-version-min=5.0 $ICU_FLAGS"
export LDFLAGS="-stdlib=libc++ -L$SDKROOT/usr/lib/ -isysroot $SDKROOT -Wl,-dead_strip -miphoneos-version-min=7.0 -lstdc++"

mkdir -p build-$ARCH && cd build-$ARCH

[ -e Makefile ] && make distclean

sh $ICU_PATH/source/configure --host=i686-apple-darwin11 --enable-static --disable-shared
