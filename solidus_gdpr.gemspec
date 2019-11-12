# frozen_string_literal: true

$:.push File.expand_path('lib', __dir__)
require 'solidus_gdpr/version'

Gem::Specification.new do |s|
  s.name = 'solidus_gdpr'
  s.version = SolidusGdpr::VERSION
  s.summary = 'A Solidus extension for implementing GDPR in your store.'
  s.license = 'BSD-3-Clause'

  s.author = 'Alessandro Desantis'
  s.email = 'alessandrodesantis@nebulab.it'
  s.homepage = 'https://nebulab.it'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rubyzip', ['>= 1.2', '< 3.0']
  s.add_dependency 'solidus_core', ['>= 2.0', '< 3']

  s.add_development_dependency 'solidus_extension_dev_tools'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'gem-release'
  s.add_development_dependency 'github_changelog_generator'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'rspec-snapshot'
end
