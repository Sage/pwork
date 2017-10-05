class Array

  #This method is called to loop over each item in this array in parallel threads
  def peach(thread_count = 5, &block)
    @mutex = Mutex.new
    @index_count = -1
    threads = []

    thread_vars = PWork::Helpers::Threads.get_thread_vars

    thread_count.times.each do
      thread = Thread.new do
        PWork::Helpers::Threads.set_thread_vars(thread_vars)
        thread_process(&block)
      end
      threads.push(thread)
    end
    #wait for all threads to exit
    threads.each { |thr| thr.join }
  end

  #This method is used to recursively process an item on a thread
  def thread_process(&block)

    item = nil

    #use a mutex to get the next item from the array to ensure thread safety
    @mutex.synchronize do
      @index_count += 1

      if @index_count <= self.length - 1
        item = self[@index_count]
      end
    end

    if item == nil
      return
    end

    #execute the block for the current item
    yield item

    #recursively attempt to process another item from the array opn this thread
    thread_process(&block)
  end

end