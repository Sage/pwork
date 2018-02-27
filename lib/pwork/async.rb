require_relative 'async/task'
require_relative 'async/exceptions'
require_relative 'async/manager'

module PWork
  module Async
    def async(options = {}, &block)
      if PWork::Async.mode == :fork
        PWork::Async.async_forked(options, &block)
      else
        PWork::Async.async_threaded(options, &block)
      end
    end

    def self.async_forked(options = {}, &block)
      if block_given?
        pid = fork do
          block.call
        end
        PWork::Async.tasks << pid unless options[:wait] == false
      else
        PWork::Async.tasks.each do |pid|
          Process.wait(pid)
        end
        reset
      end
    end

    def self.async_threaded(options = {}, &block)
      if block_given?
        options[:caller] = self
        PWork::Async.add_task(options, &block)
      else
        PWork::Async.wait_for_tasks({ caller: self, command: options })
      end
    end

    def self.manager
      @manager ||= PWork::Async::Manager.new
    end

    def self.add_task(options, &block)
      manager.start unless manager.running

      task = PWork::Async::Task.new.tap do |e|
        e.block = block
        e.caller = options[:caller]
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

    def self.wait_for_tasks(options)
      case options[:command]
        when :wait
          task_list = tasks
        when :wait_local
          task_list = tasks.select { |t| t.caller == options[:caller] }
      end

      until task_list.detect { |t| t.state == :pending || t.state == :active }.nil?
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
      raise PWork::Async::Exceptions::TaskError.new(
        "1 or more async errors occurred. #{error_messages.join(' | ')}"
      ) if error_messages.length > 0
      true
    end

    def self.async_wait_sleep_iteration
      Float(ENV.fetch('PWORK_ASYNC_WAIT_SLEEP_ITERATION', '0.02'))
    end

    def self.mode
      if ENV['PWORK_ASYNC_MODE'].to_s.downcase == 'fork'
        :fork
      else
        :thread
      end
    end

    def self.reset
      Thread.current[:pwork_async_tasks] = []
    end
  end
end
