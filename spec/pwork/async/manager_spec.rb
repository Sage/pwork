RSpec.describe PWork::Async::Manager do
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
      it 'passes the task for processing' do
        expect(subject).to receive(:process_task).with(task).once
        subject.add_task(task)
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
        subject.process_task(task)
        task.thread.join
        expect(task.state).to eq :complete
      end
    end
    context 'when a task processes without error' do
      before do
        allow(task.block).to receive(:call).and_raise(StandardError)
      end
      it 'sets the task status to :error' do
        subject.process_task(task)
        task.thread.join
        expect(task.state).to eq :error
        expect(task.error).to be_a(StandardError)
      end
    end
  end
end
