# frozen_string_literal: true

require 'io/console'

class Logger
  def self.log(msg)
    puts "[#{Time.now.strftime("%d/%m/%Y %H:%M:%S")}] #{msg}"
  end
end
