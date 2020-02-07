#!/bin/bash -e
#
# Author:: Lance Albertson <lance@osuosl.org>
# Copyright:: Copyright 2020, Cinc Project
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

package_cloud_push () {
  bundle exec package_cloud push cinc-project/${CHANNEL} $@
}

source /home/omnibus/load-omnibus-toolchain.sh
set -x
bundle install
cd inspec
gem build inspec-core.gemspec
gem build inspec.gemspec
package_cloud_push inspec-core-[0-9]*.gem
package_cloud_push inspec-[0-9]*.gem
cd inspec/inspec-bin
gem build cinc-auditor-bin.gemspec
gem build cinc-auditor-core-bin.gemspec
package_cloud_push cinc-auditor-bin-[0-9]*.gem
package_cloud_push cinc-auditor-core-bin-[0-9]*.gem
