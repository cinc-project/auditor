#!/bin/bash -e
mkdir -p $HOME/.gem
touch $HOME/.gem/credentials
chmod 0600 $HOME/.gem/credentials
printf -- "---\n:rubygems_api_key: ${GEM_HOST_API_KEY}\n" > $HOME/.gem/credentials
source /home/omnibus/load-omnibus-toolchain.sh
cd inspec
gem build cinc-*.gemspec inspec-bin/cinc-*.gemspec
gem push cinc-*.gem inspec-bin/cinc-*.gem
rm -rf $HOME/.gem
