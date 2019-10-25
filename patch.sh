#!/bin/sh -e

rm -rf inspec
git clone --depth=1 -b ${REF:-master} ${ORIGIN:-https://github.com/inspec/inspec.git}
cd inspec
for patch in $(find ../patches/ -type f | sort) ; do
  patch -p1 < $patch
done
mkdir -p inspec-bin/lib/inspec
cp lib/inspec/dist.rb inspec-bin/lib/inspec/
cd ../
cp -rp cinc-auditor/* inspec/
