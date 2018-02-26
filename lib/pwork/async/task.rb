require 'securerandom'
module PWork
  module Async
    class Task
      attr_accessor :id
      attr_accessor :state
      attr_accessor :thread_local_storage
      attr_accessor :error
      attr_accessor :block
      attr_accessor :caller
      def initialize
        self.id = SecureRandom.uuid
        self.state = :pending
        self.thread_local_storage = []
      end
    end
  end
end
