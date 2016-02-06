# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'demo_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'demo_logger'
  spec.version       = DemoLogger::VERSION
  spec.authors       = ['john-crimmins']
  spec.email         = ['john.crimmins@gmail.com']

  spec.summary       = 'An example logger layered on top of the built in Ruby logger'
  spec.description   = ''
  spec.homepage      = 'http://github.com/CivJ/demo_logger'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  else
    fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  # rubocop:disable Style/RegexpLiteral
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'should_not', '~> 1.1'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'rubocop', '= 0.26.0'
end
