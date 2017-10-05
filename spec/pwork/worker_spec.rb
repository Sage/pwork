RSpec.describe PWork::Worker do
  it 'should execute all processes added to the worker in the default number of parallel threads when thread_count is not specified' do

    results = []
    completed = []

    worker = PWork::Worker.new
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end

    worker.execute

    expect(results.count).to be > 0
    expect(completed.length).to eq 10

  end

  it 'should execute all processes added to the worker in the specified number of parallel threads when thread_count is specified' do

    results = []
    completed = []

    worker = PWork::Worker.new(10)
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end
    worker.add do

      thread_details = Thread.current.inspect

      r = results.select { |i| i[:thread_details] == thread_details }

      if r.length == 0
        results.push({ :thread_details => thread_details, :count => 1})
      elsif
      r[0][:count] += 1
      end

      sleep(0.5)

      completed << true

    end

    worker.execute

    expect(results.count).to be > 0
    expect(completed.length).to eq 10

  end

  it 'should pass thread variables from parent thread to child threads' do
    completed = Queue.new
    Thread.current[:foo] = 'bar'

    worker = PWork::Worker.new
    worker.add do
      completed << true if Thread.current[:foo] == 'bar'
    end
    worker.add do
      completed << true if Thread.current[:foo] == 'bar'
    end

    worker.execute

    expect(completed.length).to eq 2

  end
end