module PWork
  class Worker

    def initialize(thread_count = 5)
      @processes = []
      @thread_count = thread_count
    end

    #This method is called to add a process to this worker
    def add(&block)
      @processes.push(block)
    end

    #This method is called to execute all processes attached to this worker in parallel on the specified number of threads.
    def execute
      @processes.peach(@thread_count) do |item|
        item.call
      end
    end

  end
end