RSpec.describe 'ThreadPool' do
  it 'should execute all blocks when more blocks of code than threads' do
    thread_pool = PWork::ThreadPool.new(threads: 5)
    completed = Queue.new

    15.times do
      thread_pool.execute do
        completed << true
      end
    end

    sleep 1

    thread_pool.shutdown

    expect(completed.length).to eq 15

  end
  it 'should execute all blocks when less blocks of code than threads' do
    thread_pool = PWork::ThreadPool.new(threads: 10)
    completed = Queue.new

    5.times do
      thread_pool.execute do
        completed << true
      end
    end

    sleep 1

    thread_pool.shutdown

    expect(completed.length).to eq 5

  end
  it 'should pass thread variables from parent thread to child threads' do
    thread_pool = PWork::ThreadPool.new
    completed = Queue.new
    Thread.current[:foo] = 'bar'

    5.times do
      thread_pool.execute do
        completed << true if Thread.current[:foo] == 'bar'
      end
    end

    sleep 1

    thread_pool.shutdown

    expect(completed.length).to eq 5

  end
end