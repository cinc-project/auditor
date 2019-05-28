#!/bin/sh -e

cd inspec
git reset --hard
git clean -f -d
cd ..

cp -rp outspec/* inspec/

cd inspec/
patch < ../patch/Gemfile.patch
cd ..
