$LOAD_PATH << File.dirname(__FILE__)

require './version'

Gem::Specification.new do |s|
  s.name          = 'rails_roots'
  s.version       = Roots::VERSION
  s.summary       = %q{Display and search capabilities for Ruby on Rails routes}
  s.description   = %q{Rails Engine to make internal routes searchable and discoverable for more than just the name of the route. All aspects of a route are searchable from the HTTP verb to the paramters a route supports.}
  s.authors       = ['Jake Yesbeck']
  s.email         = 'yesbeckjs@gmail.com'
  s.homepage      = 'https://github.com/yez/roots'
  s.license       = 'MIT'

  s.require_paths = %w(lib app)
  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(/^spec\//)

  s.required_ruby_version = '>= 2.0.0'
  s.add_dependency 'rails', '~> 4.0'

  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'pry', '~> 0.10'
end
