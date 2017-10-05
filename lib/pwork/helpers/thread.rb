module PWork
  module Helpers
    class Threads
      def self.get_thread_vars
        vars = {}
        Thread.current.keys.each do |k|
          vars[k] = Thread.current[k]
        end
        vars
      end

      def self.set_thread_vars(vars)
        PWork::Helpers::Threads.reset_thread_vars
        vars.keys.each do |k|
          Thread.current[k] = vars[k]
        end
      end

      def self.reset_thread_vars
        Thread.current.keys.each do |k|
          Thread.current[k] = nil
        end
      end
    end
  end
end