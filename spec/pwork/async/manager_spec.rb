RSpec.describe PWork::Async::Manager do
  describe '#initialize' do
    it 'setups up the manager correctly' do
      subject
      expect(subject.instance_variable_get(:@queue)).to be_a(Queue)
      expect(subject.instance_variable_get(:@threads)).to eq []
      expect(subject.instance_variable_get(:@running)).to be false
    end
  end
  describe '#running' do
    it 'returns if the manager is running' do
      expect(subject.running).to be false
    end
  end
  describe '#pool_size' do
    context 'when the env variable is specified' do
      before do
        ENV['PWORK_ASYNC_POOL_SIZE'] = '5'
      end
      it 'returns the env variable value' do
        expect(subject.pool_size).to eq 5
      end
    end
    context 'when the env variable is NOT specified' do
      before do
        ENV['PWORK_ASYNC_POOL_SIZE'] = nil
      end
      it 'returns the default value' do
        expect(subject.pool_size).to eq 10
      end
    end
  end
  describe '#add_task' do
    context 'when an invalid task is specified' do
      let(:task) { double }
      it 'raises an error' do
        expect{ subject.add_task(task) }.to raise_error(PWork::Async::Exceptions::InvalidOptionsError)
      end
    end
    context 'when a valid task is specified' do
      let(:task) do
        PWork::Async::Task.new
      end
      it 'adds the task to the queue' do
        expect(subject.queue_count).to eq 0
        subject.add_task(task)
        expect(subject.queue_count).to eq 1
      end
    end
  end
  describe '#process_task' do
    let(:task) do
      PWork::Async::Task.new.tap do |e|
        e.block = Proc.new do
          puts 'Hello World'
        end
      end
    end
    context 'when a task processes without error' do
      it 'sets the task status to :complete' do
        subject.add_task(task)
        subject.process_task
        expect(task.state).to eq :complete
      end
    end
    context 'when a task processes without error' do
      before do
        allow(task.block).to receive(:call).and_raise(StandardError)
      end
      it 'sets the task status to :error' do
        subject.add_task(task)
        subject.process_task
        expect(task.state).to eq :error
        expect(task.error).to be_a(StandardError)
      end
    end
  end
end
