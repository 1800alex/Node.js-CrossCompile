# For ARM sudo apt-get install gcc-arm-linux-gnueabi g++-arm-linux-gnueabi
NODEJS_VERSION=node-v4.6.2
mkdir -p ../BuiltNode/

#### x86 Build ####
rm -rf ./$NODEJS_VERSION/ &>/dev/null

tar -xf $NODEJS_VERSION.tar*
cd $NODEJS_VERSION/

./configure --without-snapshot --fully-static
make -j4

rm -rf ./nodejsinstall/
mkdir -p ./nodejsinstall/
make install DESTDIR=./nodejsinstall/
strip ./nodejsinstall/usr/local/bin/node
mkdir -p ../BuiltNode/
mksquashfs nodejsinstall/ ../BuiltNode/$NODEJS_VERSION-x86.tcz
cd ../
rm -rf ./$NODEJS_VERSION/ &>/dev/null
#### end of x86 Build ####

#### ARM iMX6 Build ####
rm -rf ./$NODEJS_VERSION/ &>/dev/null

tar -xf $NODEJS_VERSION.tar.xz
cd $NODEJS_VERSION/

# Build for iMX6
export TARGET_ARCH="-march=armv7-a"
export TARGET_TUNE="-mthumb -O3 -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon -mvectorize-with-neon-quad -mfloat-abi=softfp"

#Define the cross compilators on your system
export AR="arm-linux-gnueabi-ar"
export CC="arm-linux-gnueabi-gcc"
export CXX="arm-linux-gnueabi-g++"
export LINK="arm-linux-gnueabi-g++"
export CPP="arm-linux-gnueabi-gcc -E"
export LD="arm-linux-gnueabi-ld"
export AS="arm-linux-gnueabi-as"
export CCLD="arm-linux-gnueabi-gcc ${TARGET_ARCH} ${TARGET_TUNE}"
export NM="arm-linux-gnueabi-nm"
export STRIP="arm-linux-gnueabi-strip"
export OBJCOPY="arm-linux-gnueabi-objcopy"
export RANLIB="arm-linux-gnueabi-ranlib"
export F77="arm-linux-gnueabi-g77 ${TARGET_ARCH} ${TARGET_TUNE}"
unset LIBC

#Define flags
export CXXFLAGS="-march=armv7-a"
export LDFLAGS="-L${CSTOOLS_LIB} -Wl,-rpath-link,${CSTOOLS_LIB} -Wl,-O1 -Wl,--hash-style=gnu"
export CFLAGS="-isystem${CSTOOLS_INC} -fexpensive-optimizations -frename-registers -fomit-frame-pointer -O2 -ggdb3"
export CPPFLAGS="-isystem${CSTOOLS_INC}"
export CCFLAGS="-march=armv7-a"

#Tools
export CSTOOLS=/usr/arm-linux-gnueabi
export CSTOOLS_INC=${CSTOOLS}/include
export CSTOOLS_LIB=${CSTOOLS}/lib
export ARM_TARGET_LIB=$CSTOOLS_LIB
export GYP_DEFINES="armv7=1"

./configure --without-snapshot --dest-cpu=arm --dest-os=linux --fully-static
make -j4

rm -rf ./nodejsinstall/
mkdir -p ./nodejsinstall/
make install DESTDIR=./nodejsinstall/
${STRIP} ./nodejsinstall/usr/local/bin/node
mkdir -p ../BuiltNode/
mksquashfs nodejsinstall/ ../BuiltNode/$NODEJS_VERSION-imx6.tcz
cd ../
rm -rf ./$NODEJS_VERSION/ &>/dev/null
#### end of ARM iMX6 Build ####

#### ARM RPI Build ####
rm -rf ./$NODEJS_VERSION/ &>/dev/null

tar -xf $NODEJS_VERSION.tar.xz
cd $NODEJS_VERSION/

# Build for RPI
export TARGET_ARCH="-march=armv7-a"
export TARGET_TUNE="-mthumb -O3 -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon -mvectorize-with-neon-quad -mfloat-abi=softfp"

#Define the cross compilators on your system
export AR="arm-linux-gnueabi-ar"
export CC="arm-linux-gnueabi-gcc"
export CXX="arm-linux-gnueabi-g++"
export LINK="arm-linux-gnueabi-g++"
export CPP="arm-linux-gnueabi-gcc -E"
export LD="arm-linux-gnueabi-ld"
export AS="arm-linux-gnueabi-as"
export CCLD="arm-linux-gnueabi-gcc ${TARGET_ARCH} ${TARGET_TUNE}"
export NM="arm-linux-gnueabi-nm"
export STRIP="arm-linux-gnueabi-strip"
export OBJCOPY="arm-linux-gnueabi-objcopy"
export RANLIB="arm-linux-gnueabi-ranlib"
export F77="arm-linux-gnueabi-g77 ${TARGET_ARCH} ${TARGET_TUNE}"
unset LIBC

#Define flags
export CXXFLAGS="-march=armv7-a"
export LDFLAGS="-L${CSTOOLS_LIB} -Wl,-rpath-link,${CSTOOLS_LIB} -Wl,-O1 -Wl,--hash-style=gnu"
export CFLAGS="-isystem${CSTOOLS_INC} -fexpensive-optimizations -frename-registers -fomit-frame-pointer -O2 -ggdb3"
export CPPFLAGS="-isystem${CSTOOLS_INC}"
export CCFLAGS="-march=armv7-a"

#Tools
export CSTOOLS=/usr/arm-linux-gnueabi
export CSTOOLS_INC=${CSTOOLS}/include
export CSTOOLS_LIB=${CSTOOLS}/lib
export ARM_TARGET_LIB=$CSTOOLS_LIB
export GYP_DEFINES="armv7=1"

./configure --without-snapshot --dest-cpu=arm --dest-os=linux --fully-static
make -j4

rm -rf ./nodejsinstall/
mkdir -p ./nodejsinstall/
make install DESTDIR=./nodejsinstall/
${STRIP} ./nodejsinstall/usr/local/bin/node
mkdir -p ../BuiltNode/
mksquashfs nodejsinstall/ ../BuiltNode/$NODEJS_VERSION-rpi.tcz
cd ../
rm -rf ./$NODEJS_VERSION/ &>/dev/null
#### end of ARM RPI Build ####
