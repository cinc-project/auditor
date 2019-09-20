# encoding: utf-8
#
# Copyright:: Copyright 2019, Cinc Community
# Copyright:: Copyright 2016-2018, Chef Software Inc.
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
#

name 'cinc-auditor'
friendly_name 'Cinc-Auditor'
maintainer 'Cinc Community <cc-build@gmail.com>'
homepage 'https://gitlab.com/cinc-project/organization-subjects/wikis/home'

license 'Apache-2.0'
license_file '../LICENSE'

build_iteration 1
# Do not use __FILE__ after this point, use current_file. If you use __FILE__
# after this point, any dependent defs (ex: angrychef) that use instance_eval
# will fail to work correctly.
current_file ||= __FILE__
version_file = File.expand_path("../../../../VERSION", current_file)
build_version IO.read(version_file).strip

# Defaults to C:/opscode/inspec on Windows
# and /opt/inspec on all other platforms.
if windows?
  install_dir "#{default_root}/opscode/#{name}"
else
  install_dir "#{default_root}/#{name}"
end

# Load dynamically updated overrides
overrides_path = File.expand_path('../../../../omnibus_overrides.rb', __FILE__)
instance_eval(File.read(overrides_path), overrides_path)

dependency 'preparation'

dependency 'cinc-auditor'

# Mark all directories world readable.
dependency 'gem-permissions'
# Redirect all gem bat files and rb files to point to embedded ruby.
dependency 'shebang-cleanup'
# Ensure our SSL cert files are accessible to ruby.
dependency 'openssl-customization'

dependency 'ruby-cleanup'

package :rpm do
  compression_level 1
  compression_type :xz
end

package :deb do
  compression_level 1
  compression_type :xz
end

exclude '**/.git'
exclude '**/bundler/git'
