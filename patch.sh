#!/bin/sh -e

rm -rf inspec
git clone --depth=1 -b ${REF:-master} ${ORIGIN:-https://github.com/inspec/inspec.git}
cd inspec
for patch in $(find ../patches/ -type f) ; do
  patch -p1 < $patch
done
cd ../
cp -rp cinc-auditor/* inspec/
