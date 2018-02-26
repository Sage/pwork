module PWork
  module Async
    module Exceptions
      class TaskError < StandardError
        def initialize(message)
          super(message)
        end
      end
    end
  end
end
