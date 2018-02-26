module PWork
  module Async
    module Exceptions
      class InvalidOptionsError < StandardError
        def initialize(message)
          super(message)
        end
      end
    end
  end
end
