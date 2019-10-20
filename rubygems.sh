#!/bin/bash -e
mkdir -p $HOME/.gem
touch $HOME/.gem/credentials
chmod 0600 $HOME/.gem/credentials
printf -- "---\n:rubygems_api_key: ${GEM_HOST_API_KEY}\n" > $HOME/.gem/credentials
source /home/omnibus/load-omnibus-toolchain.sh
cd inspec/inspec-bin
gem build cinc-auditor-bin.gemspec
gem build cinc-auditor-core-bin.gemspec
gem push cinc-auditor-bin-[0-9]*.gem
gem push cinc-auditor-core-bin-[0-9]*.gem
rm -rf $HOME/.gem
