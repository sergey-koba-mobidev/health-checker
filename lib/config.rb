# frozen_string_literal: true

require 'yaml'

class Config
  def initialize(config_path = './config.yml')
    @config =  YAML.load_file(config_path)
  end

  def monitors
    @config['monitors']
  end
end
