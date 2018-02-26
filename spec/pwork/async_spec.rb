RSpec.describe PWork::Async do
  describe '#async_wait_sleep_iteration' do
    context 'when a value is NOT specified via env variable' do
      before do
        ENV['PWORK_ASYNC_WAIT_SLEEP_ITERATION'] = nil
      end
      it 'returns the default value' do
        expect(PWork::Async.async_wait_sleep_iteration).to eq 0.02
      end
    end
    context 'when a value is specified via env variable' do
      before do
        ENV['PWORK_ASYNC_WAIT_SLEEP_ITERATION'] = '0.1'
      end
      it 'returns the env var value' do
        expect(PWork::Async.async_wait_sleep_iteration).to eq 0.1
      end
    end
  end
end
