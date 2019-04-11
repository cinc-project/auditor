#!/bin/sh -e

cd inspec
git reset --hard
git clean -f -d
cd ..

cd inspec/bin
rename 's/inspec/outspec/' *
cd ../..
sed -i '/spec.executables   =/ s/inspec/outspec/g' inspec/inspec.gemspec

cd inspec/omnibus/package-scripts
cp -r inspec outspec
cd ../../..

sed -i '/binaries=/ s/inspec/outspec/g' inspec/omnibus/package-scripts/outspec/postinst inspec/omnibus/package-scripts/outspec/postrm
sed -i '/echo /s/InSpec/OutSpec/g' inspec/omnibus/package-scripts/outspec/postinst inspec/omnibus/package-scripts/outspec/postrm inspec/omnibus/package-scripts/outspec/preinst
sed -i '/INSTALLER_DIR=/s/inspec/outspec/g' inspec/omnibus/package-scripts/outspec/postinst

cp inspec/omnibus/config/projects/inspec.rb inspec/omnibus/config/projects/outspec.rb

sed -i '/name / s/inspec/outspec/g' inspec/omnibus/config/projects/outspec.rb
sed -i '/friendly_name / s/InSpec/OutSpec/g' inspec/omnibus/config/projects/outspec.rb
sed -i "s/maintainer .*/maintainer 'Community <community@example.com>'/g" inspec/omnibus/config/projects/outspec.rb
