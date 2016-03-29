require "pwork/version"

module Pwork

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


class Array

  #This method is called to loop over each item in this array in parallel threads
  def peach(thread_count = 5, &block)
    mutex = Mutex.new
    index_count = -1
    threads = []
    thread_count.times.each do
      thread = Thread.new do
        thread_process(index_count, mutex, &block)
      end
      threads.push(thread)
    end
    #wait for all threads to exit
    threads.each { |thr| thr.join }
  end

  #This method is used to recursively process an item on a thread
  def thread_process(index_count, mutex, &block)

    item = nil

    #use a mutex to get the next item from the array to ensure thread safety
    mutex.synchronize do
      index_count += 1

      if index_count > self.length - 1
        return
      end

      item = self[index_count]
    end

    #execute the block for the current item
    yield item

    #recursively attempt to process another item from the array opn this thread
    thread_process(index_count, mutex, &block)
  end

end