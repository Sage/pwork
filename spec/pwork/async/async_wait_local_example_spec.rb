class ExampleClient2
  include PWork::Async

  def http_method
    # sleep for 20s to simulate avery long blocking http call
    sleep(20)
  end

  def multi_call_async
    async do
      http_method
    end
    async do
      http_method
    end
  end
end

class ExampleClient3
  include PWork::Async

  def http_method
    # sleep for 20s to simulate avery long blocking http call
    sleep(0.2)
  end

  def multi_call_async
    async do
      http_method
    end
    async do
      http_method
    end
    async do
      http_method
    end
    async do
      http_method
    end
  end

  def wait
    async :wait_local
  end
end

RSpec.describe ExampleClient3 do
  before do
    PWork::Async.reset
  end
  it 'makes multiple http calls asyncronously' do
    ExampleClient2.new.multi_call_async
    subject.multi_call_async
    expect(PWork::Async.tasks.length).to eq 6
    subject.wait
    expect(PWork::Async.tasks.length).to eq 0
  end
end
