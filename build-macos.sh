#!/bin/bash -e
#
# Author:: Lance Albertson <lance@osuosl.org>
# Copyright:: Copyright 2020-2025, Cinc Project
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

TOP_DIR="$(pwd)"
export CI_PROJECT_DIR=${CI_PROJECT_DIR:-${TOP_DIR}}
source /Users/omnibus/load-omnibus-toolchain.sh
set -ex
mkdir -p ${TOP_DIR}/cache/git_cache
echo "cache_dir '${TOP_DIR}/cache'" >> inspec/omnibus/omnibus.rb
echo "git_cache_dir '${TOP_DIR}/cache/git_cache'" >> inspec/omnibus/omnibus.rb
echo "use_git_caching true" >> inspec/omnibus/omnibus.rb
cd inspec/omnibus
bundle config set --local path ${CI_PROJECT_DIR}/bundle/vendor
bundle config set --local without 'development'
bundle install
sudo rm -rf /var/cache/omnibus/pkg/*
sudo -E bundle exec omnibus build cinc-auditor -l ${OMNIBUS_LOG_LEVEL} --override append_timestamp:false
sudo chown -R omnibus:omnibus pkg
mkdir -p ${CI_PROJECT_DIR}/data
mv -v pkg/cinc*dmg* ${CI_PROJECT_DIR}/data/
cp ../VERSION ${CI_PROJECT_DIR}/