require 'thread'

module PWork
  module Async
    class Manager
      # This method is called to process an async task from the queue
      def process_task(task)
        task.thread = Thread.new do
          task.state = :active
          thread_helper.set_thread_vars(task.thread_local_storage)
          begin
            task.block.call
            task.state = :complete
          rescue => e
            task.error = e
            task.state = :error
          ensure
            thread_helper.reset_thread_vars
          end
        end
      end

      # This method is called to expose the thread helper
      def thread_helper
        PWork::Helpers::Threads
      end

      # This method is called to add a task to the queue
      def add_task(task)
        raise PWork::Async::Exceptions::InvalidOptionsError.new(
          'A valid async task must be specified.'
        ) unless task.is_a?(PWork::Async::Task)
        task.thread_local_storage = PWork::Helpers::Threads.get_thread_vars
        process_task(task)
      end
    end
  end
end
