#!/bin/sh -e

cd inspec
git reset --hard
git clean -f -d
cd ..

cp -rp cinc-auditor/* inspec/

cd inspec/
patch < ../patch/Gemfile.patch

cd ..
