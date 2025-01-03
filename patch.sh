#!/bin/bash -e
#
# Author:: Artem Sidorenko <artem@posteo.de>
# Author:: Lance Albertson <lance@osuosl.org>
# Copyright:: Copyright 2019-2025, Cinc Project
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

# This will patch InSpec using Cinc branded patches
git_patch() {
  if [ -n "${2}" ] ; then
    CINC_BRANCH="${2}"
  elif [ "${REF}" == "main" -o -z "${REF}" ] ; then
    CINC_BRANCH="stable/cinc"
  else
    CINC_BRANCH="stable/cinc-${REF}"
  fi
  echo "Patching ${1} from ${CINC_BRANCH}..."
  git remote add -f --no-tags -t ${CINC_BRANCH} cinc https://gitlab.com/cinc-project/${1}.git
  git merge --no-edit cinc/${CINC_BRANCH}
}

TOP_DIR="$(pwd)"
source /home/omnibus/load-omnibus-toolchain.sh
set -ex
# remove any previous builds
rm -rf inspec
git config --global user.email || git config --global user.email "maintainers@cinc.sh"
echo "Cloning ${REF:-main} branch from ${ORIGIN:-https://github.com/inspec/inspec.git}"
git clone -q -b ${REF:-main} ${ORIGIN:-https://github.com/inspec/inspec.git}
cd inspec
git_patch inspec ${CINC_REF}
mkdir -p inspec-bin/lib/inspec
cp lib/inspec/dist.rb inspec-bin/lib/inspec/
cd $TOP_DIR
cp -rp cinc-auditor/* inspec/
