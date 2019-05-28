# encoding: utf-8
#
# Copyright:: Copyright 2019, Cinc Community
# Copyright:: Copyright 2016-2019, Chef Software Inc.
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
require_relative '../../../lib/inspec/version.rb'

name 'outspec'

license :project_license

default_version "v#{Inspec::VERSION}"

source path: "#{Omnibus::Config.project_root}/../",
       options: { exclude: ['omnibus'] }

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # Remove existing built gems in case they exist in the current dir
  delete "#{name}-*.gem"

  # We bundle install to ensure the versions of gems we are going to
  # appbundle-lock to are definitely installed
  bundle 'install --without test integration tools maintenance', env: env

  gem "build inspec.gemspec", env: env
  gem "install inspec-*.gem --no-document", env: env

  gem 'build outspec-bin.gemspec', env: env, cwd: "#{project_dir}/outspec-bin"
  gem 'install outspec-bin-*.gem --no-document', env: env, cwd: "#{project_dir}/outspec-bin"

  block do
    if Dir.exist?("#{project_dir}/outspec-bin")
      appbundle 'outspec', lockdir: project_dir, gem: 'outspec-bin', env: env
    else
      appbundle 'outspec', env: env
    end
  end

  copy "#{project_dir}/#{name}/#{name}-wrapper", "#{install_dir}/bin/"
  block "fix script permissions" do
    FileUtils.chmod_R "a+rx", "#{install_dir}/bin/#{name}-wrapper"
  end
end
