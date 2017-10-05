# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

version = ''
if ENV['TRAVIS_TAG'] != nil
  puts "CI Branch - '#{ENV['TRAVIS_TAG']}'"
  version = ENV['TRAVIS_TAG']
end

# if the tag version starts with v (e.g. vx.x.x)
if version.downcase.match(/^v/)
  #trim the v and set the version to x.x.x
  version = version.dup
  version.slice!(0)
elsif ENV['TRAVIS_TAG'] != nil && ENV['TRAVIS_TAG'] != ''
  #allow none release tags to build alpha, beta, dev versions of the gem.
  version = "0.0.0.#{ENV['TRAVIS_TAG']}"
else
  #otherwise it is not a valid release tag so set the version 0.0.0 as it not being released.
  version = '0.0.0'
end

Gem::Specification.new do |spec|
  spec.name          = 'pwork'
  spec.version       = version
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

  if RUBY_PLATFORM =~ /java/
    spec.platform = 'java'
  end
end
