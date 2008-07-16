#!/bin/sh

name="GogoLock"
prog_bundle_source_dir="${PWD}/build/Release/GogoLock.app"
dmg_target_dir="${PWD}/build/"

tmpdir=`/usr/bin/mktemp -d /tmp/gogolock.XXXX`


cd $tmpdir

/usr/bin/hdiutil create -type SPARSE -fs "HFS+" -volname $name "${name}.sparseimage" && \
/usr/bin/hdiutil attach -nobrowse -mountpoint $name "${name}.sparseimage" && \
/bin/cp -R $prog_bundle_source_dir $name

/usr/bin/hdiutil detach $name

/usr/bin/hdiutil convert -format UDZO -o "${name}.dmg" "${name}.sparseimage" && \
/bin/cp ${name}.dmg $dmg_target_dir

/bin/rm -rf $tmpdir
