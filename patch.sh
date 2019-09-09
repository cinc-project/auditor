#!/bin/sh -e

cd inspec
git reset --hard
git clean -f -d
cd ..

cp -rp cinc-auditor/* inspec/

cd inspec/
patch < ../patch/Gemfile.patch

# removing EULA check as for now there is no way to disable this code
patch lib/inspec/cli.rb ../patch/cli.rb.patch

cd ..
