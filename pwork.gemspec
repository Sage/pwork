# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pwork/version'

Gem::Specification.new do |spec|
  spec.name          = 'pwork'
  spec.version       = PWork::VERSION
  spec.authors       = ['vaughanbrittonsage']
  spec.email         = ['vaughan.britton@sage.com']

  spec.summary       = 'This is a library to facilitate with the execution of work on parallel threads.'
  spec.description   = 'This is a library to facilitate with the execution of work on parallel threads.'
  spec.homepage      = 'https://github.com/sage/pwork'
  spec.license       = 'MIT'

  spec.files         = Dir.glob("{bin,lib}/**/**/**")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'simplecov'

  if RUBY_PLATFORM =~ /java/
    spec.platform = 'java'
  end
end
