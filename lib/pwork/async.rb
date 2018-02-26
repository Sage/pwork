require_relative 'async/task'
require_relative 'async/exceptions'
require_relative 'async/manager'

module PWork
  module Async
    def async(options = nil, &block)
      if block_given?
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
        sleep(async_wait_sleep_iteration)
      end
      handle_errors
      ensure
        Thread.current[:pwork_async_tasks] = []
    end

    def self.handle_errors
      error_messages = []
      tasks.select { |t| t.state == :error }.each do |t|
        error_messages << "Error: #{t.error.message}, #{t.error.backtrace}"
      end
      raise PWork::Async::Exceptions::TaskError.new("1 or more async errors occurred. #{error_messages.join(' | ')}") if error_messages.length > 0
      true
    end

    def self.async_wait_sleep_iteration
      Integer(ENV.fetch('PWORK_ASYNC_WAIT_SLEEP_ITERATION', 0.01))
    end
  end
end
