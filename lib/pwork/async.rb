require_relative 'async/task'
require_relative 'async/exceptions'
require_relative 'async/manager'

module PWork
  module Async
    def async(options = nil, &block)
      if block_given?
        raise PWork::Async::Exceptions::InvalidOptionsError.new(
          'Async options must be a Hash.'
        ) if options != nil && !options.is_a?(Hash)
        PWork::Async.add_task(options, &block)
      else
        raise PWork::Async::Exceptions::InvalidOptionsError.new(
          'Unknown async option.'
        ) unless options == :wait
        PWork::Async.wait_for_tasks
      end
    end

    def self.manager
      @manager ||= PWork::Async::Manager.new
    end

    def self.add_task(options, &block)
      manager.start unless manager.running

      options = {} if options == nil
      task = PWork::Async::Task.new.tap do |e|
        e.block = block
      end

      unless options[:wait] == false
        tasks << task
      end

      manager.add_task(task)

      task.id
    end

    def self.tasks
      Thread.current[:pwork_async_tasks] ||= []
    end

    def self.wait_for_tasks
      until tasks.detect { |t| t.state == :pending || t.state == :active }.nil?
        sleep(0.01)
      end
      Thread.current[:pwork_async_tasks] = []
    end
  end
end
