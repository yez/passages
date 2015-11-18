$LOAD_PATH << File.dirname(__FILE__)

require './version'

Gem::Specification.new do |s|
  s.name          = 'roots'
  s.version       = Roots::VERSION
  s.summary       = %q{}
  s.description   = %q{}
  s.authors       = ['Jake Yesbeck']
  s.email         = 'yesbeckjs@gmail.com'
  s.homepage      = ''
  s.license       = 'MIT'

  s.require_paths = %w(lib app)
  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(/^spec\//)

  s.required_ruby_version = '>= 2.0.0'
  s.add_dependency 'rails', '>= 4.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
end
