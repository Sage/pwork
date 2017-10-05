require 'java'
java_import java.util.concurrent.Executors
module PWork
  class ThreadPool

    def initialize(size: 5)
      @processes = []
      @executor = java.util.concurrent.Executors::newFixedThreadPool size
    end

    #This method is called to pass a block to be ran on a thread within the thread pool
    def execute(&block)
      thread_vars = PWork::Helpers::Threads.get_thread_vars
      @executor.execute do
        PWork::Helpers::Threads.set_thread_vars(thread_vars)
        block.call
      end
    end

    def shutdown
      @executor.shutdown
    end

  end
end