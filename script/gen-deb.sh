#!/bin/sh
set -e
debroot=out/debroot
version="$(git describe --always --dirty)"
rm -rf $debroot
mkdir -p $debroot
mkdir -p $debroot/usr/share/doc/substitute
cp doc/installed-README.txt $debroot/usr/share/doc/README.txt
cp substrate/lgpl-3.0.tar.xz $debroot/usr/share/doc/
mkdir -p $debroot/usr/lib
cp out/libsubstitute.dylib $debroot/usr/lib/libsubstitute.0.dylib
ln -s libsubstitute.0.dylib $debroot/usr/lib/libsubstitute.dylib
mkdir -p $debroot/usr/include/substitute
cp lib/substitute.h $debroot/usr/include/substitute/
cp substrate/substrate.h $debroot/usr/include/substitute/
mkdir -p $debroot/Library/Substitute
cp out/{posixspawn-hook.dylib,bundle-loader.dylib,unrestrict,inject-into-launchd} $debroot/Library/Substitute/
cp -a DEBIAN $debroot/
sed "s#{VERSION}#$version#g" DEBIAN/control > $debroot/DEBIAN/control
#... add bootstrap stuff
# yay, old forks and deprecated compression
dpkg-deb -Zlzma -b $debroot out/com.ex.substitute-$version.deb




