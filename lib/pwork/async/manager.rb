require 'thread'

module PWork
  module Async
    class Manager
      def initialize
        @queue = Queue.new
        @threads = []
        @running = false
      end
      # This method is called to determine if this manager is running or not
      def running
        @running
      end
      # This method is called to start the async manager
      def start
        @running = true
        pool_size.times do
          @threads << Thread.new do
            until @running == false
              process_task
            end
          end
        end
      end
      # This method is called to stop the async manager
      def stop
        @running = false
        @threads = []
      end
      # This method is called to determine the size of the async thread pool
      def pool_size
        Integer(ENV.fetch('PWORK_ASYNC_POOL_SIZE', 10))
      end
      # This method is called to process an async task from the queue
      def process_task
        task = @queue.pop
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
      # This method is called to expose the thread helper
      def thread_helper
        PWork::Helpers::Threads
      end
      # This method is called to determine the number of tasks in the queue
      def queue_count
        @queue.length
      end
      # This method is called to add a task to the queue
      def add_task(task)
        raise PWork::Async::Exceptions::InvalidOptionsError.new(
          'A valid async task must be specified.'
        ) unless task.is_a?(PWork::Async::Task)
        task.thread_local_storage = PWork::Helpers::Threads.get_thread_vars
        @queue.push(task)
      end
    end
  end
end
