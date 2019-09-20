#!/bin/sh -e

rm -rf inspec

git clone --depth=10 https://github.com/inspec/inspec.git

#cd inspec
#git reset --hard
#git clean -f -d
#cd ..

cp -rp cinc-auditor/* inspec/

cd inspec/
patch < ../patch/Gemfile.patch
cd ..
