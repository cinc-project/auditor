#!/bin/sh -e

cd inspec
git reset --hard
git clean -f -d
cd ..

cd inspec/bin
rename 's/inspec/outspec/' *
cd ../..
sed -i '/spec.executables   =/ s/inspec/outspec/g' inspec/inspec.gemspec
sed -i '/binaries=/ s/inspec/outspec/g' inspec/omnibus/package-scripts/inspec/postinst inspec/omnibus/package-scripts/inspec/postrm
sed -i '/echo /s/InSpec/OutSpec/g' inspec/omnibus/package-scripts/inspec/postinst inspec/omnibus/package-scripts/inspec/postrm inspec/omnibus/package-scripts/inspec/preinst
