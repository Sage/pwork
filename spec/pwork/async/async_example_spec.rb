class ExampleClient
  include PWork::Async

  def http_method
    # sleep for 200ms to simulate a blocking http call
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
    async do
      http_method
    end
    async wait: false do
      http_method
    end
  end

  def wait
    async :wait
  end
end

RSpec.describe ExampleClient do
  before do
    PWork::Async.reset
  end
  context 'when async mode is :thread' do
    before do
      ENV['PWORK_ASYNC_MODE'] = 'thread'
    end
    it 'makes multiple http calls asyncronously' do
      subject.multi_call_async
      expect(PWork::Async.tasks.length).to eq 9
      subject.wait
      expect(PWork::Async.tasks.length).to eq 0
    end
    after do
      ENV['PWORK_ASYNC_MODE'] = nil
    end
  end
  unless RUBY_PLATFORM =~ /java/
    context 'when async mode is :fork' do
      before do
        ENV['PWORK_ASYNC_MODE'] = 'fork'
      end
      it 'makes multiple http calls asyncronously' do
        subject.multi_call_async
        expect(PWork::Async.tasks.length).to eq 9
        subject.wait
        expect(PWork::Async.tasks.length).to eq 0
      end
      after do
        ENV['PWORK_ASYNC_MODE'] = nil
      end
    end
  end
end
