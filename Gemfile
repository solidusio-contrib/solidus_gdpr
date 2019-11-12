# frozen_string_literal: true

source 'https://rubygems.org'

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')

gem 'solidus', github: 'solidusio/solidus', branch: branch
gem 'solidus_auth_devise', '~> 2.0'

case ENV['DB']
when 'mysql'
  gem 'mysql2'
else
  gem 'pg'
end

gem 'solidus_extension_dev_tools', github: 'solidusio-contrib/solidus_extension_dev_tools'

gemspec
