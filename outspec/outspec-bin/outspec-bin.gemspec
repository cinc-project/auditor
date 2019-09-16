lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'outspec-bin/version'

Gem::Specification.new do |spec|
  spec.name          = 'outspec-bin'
  spec.version       = OutspecBin::VERSION
  spec.authors       = ['Cinc Community']
  spec.email         = ['cc-build@gmail.com']
  spec.summary       = 'Infrastructure and compliance testing'
  spec.description   = 'OutSpec executable'
  spec.homepage      = 'https://gitlab.com/cinc-project/organization-subjects/wikis/home'
  spec.license       = 'Apache-2.0'

  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4'

  spec.add_dependency 'inspec', "= #{OutspecBin::VERSION}"
  spec.add_development_dependency 'rake'

  spec.files = %w{README.md LICENSE Gemfile} + Dir.glob('*.gemspec') +
               Dir.glob('{lib,bin}/**/*', File::FNM_DOTMATCH).reject { |f| File.directory?(f) }

  spec.bindir = 'bin'
  spec.executables = %w{outspec}
end
