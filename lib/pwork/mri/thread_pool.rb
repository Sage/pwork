module PWork
  class ThreadPool
    def initialize(size: 5)
      @size = size
      @jobs = Queue.new
      @pool = Array.new(size) do
        Thread.new do
          catch(:exit) do
            loop do
              job, thread_vars = @jobs.pop
              PWork::Helpers::Threads.set_thread_vars(thread_vars)
              job.call
            end
          end
        end
      end
    end

    def execute(&block)
      @jobs << [block, PWork::Helpers::Threads.get_thread_vars]
    end

    def shutdown
      @size.times do
        execute { throw :exit }
      end

      @pool.map(&:join)
    end
  end
end