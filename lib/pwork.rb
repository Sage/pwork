require 'pwork/version'
require_relative 'pwork/helpers/thread'

require_relative 'pwork/array'
require_relative 'pwork/worker'

if RUBY_PLATFORM =~ /java/
  require_relative 'pwork/jruby/thread_pool'
else
  require_relative 'pwork/mri/thread_pool'
end