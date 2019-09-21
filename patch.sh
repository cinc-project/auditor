#!/bin/sh -e

rm -rf inspec
git clone --depth=1 -b ${REF:-master} ${ORIGIN:-https://github.com/inspec/inspec.git}
cp -rp cinc-auditor/* inspec/
