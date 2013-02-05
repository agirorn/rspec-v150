# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "rspec/v150/version"

Gem::Specification.new do |s|
  s.name     = 'rspec-v150'
  s.version  = RSpec::V150::VERSION
  s.author   = 'Ægir Örn Símonarson'
  s.email    = 'agirorn@gmail.com'
  s.homepage = 'https://github.com/agirorn/rspec-v150'
  s.summary  = 'Super Fast RSpec-2 for Rails-3'
  s.license  = 'MIT'
  s.platform = Gem::Platform::RUBY

  s.files        = Dir['CHANGELOG.md', 'MIT-LICENSE', 'README.rdoc', 'lib/**/*']
  s.require_path = 'lib'

  s.add_runtime_dependency 'rspec'
  s.add_runtime_dependency 'actionpack'

  s.add_development_dependency 'actionpack'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'capybara'
end
