# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require './lib/monitor/runner'

Monitor::Runner.new.run
