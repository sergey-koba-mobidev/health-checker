# frozen_string_literal: true

require 'async'

require './lib/config'
require './lib/monitor'

class Monitor
  class Runner
    def initialize
      @config = Config.new
    end

    def run
      Async do |task|
        @config.monitors.each do |monitor|
          task.async do |subtask|
            Monitor.new(monitor).run
          end
        end
      end
    end
  end
end
