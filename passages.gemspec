$LOAD_PATH << File.dirname(__FILE__) + '/lib'
$LOAD_PATH << File.dirname(__FILE__) + '/app'

require './version'

Gem::Specification.new do |s|
  s.name          = 'passages'
  s.version       = Passages::VERSION
  s.summary       = 'Display and search capabilities for Ruby on Rails routes'
  s.description   = 'Rails Engine to make internal routes searchable and
                      discoverable for more than just the name of the route.
                      All aspects of a route are searchable from the HTTP
                      verb to the paramters a route supports.'
  s.authors       = ['Jake Yesbeck']
  s.email         = 'yesbeckjs@gmail.com'
  s.homepage      = 'https://github.com/yez/passages'
  s.license       = 'MIT'

  s.require_paths = %w[lib app]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(%r{^spec/})

  s.required_ruby_version = '>= 2.2.2'
  s.add_dependency 'rails', '~> 6.0'

  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'rubocop', '0.49.0'
end
