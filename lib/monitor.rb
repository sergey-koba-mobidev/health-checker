# frozen_string_literal: true

require 'net/http'
require 'date'
require './lib/logger'
require './lib/notification/resolver'

class Monitor
  STATE_UP = 'up'
  STATE_DOWN = 'down'

  def initialize(config)
    @name = config['name']
    @url = config['url']
    @notifications = config['notifications']
    dt = DateTime.parse(config['period'])
    @period = dt.hour * 3600 + dt.min * 60 + dt.sec
    @state = STATE_UP
    @max_retries = config['retries']&.to_i || 0
    @current_retries = 0
    Logger.log "New monitor registered #{@name} with period #{@period}"
  end

  def run
    loop do
      check_url
      sleep @period
    end
  end

  private

  def check_url
    Logger.log "Checking url: #{@url}"
    state_from = @state
    @state = STATE_DOWN
    url = URI.parse(@url)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = true
    res = req.get(url.path)
    Logger.log "Response code for #{@url}: #{res.code}"
    @state = STATE_UP if res.code == '200' || res.code == '201'
  rescue
    @state = STATE_DOWN
    Logger.log "Failed to ping #{@url}"
  ensure
    if @state == STATE_DOWN && @current_retries < @max_retries
      @state = state_from
      @current_retries += 1
      Logger.log "Retrying #{@url} count #{@current_retries}"
    else
      @current_retries = 0
    end
    Notification::Resolver.new(@notifications, state_from, @state).run
  end
end
