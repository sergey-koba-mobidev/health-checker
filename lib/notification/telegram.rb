# frozen_string_literal: true

require 'telegram/bot'
require './lib/logger'

class Notification 
  class Telegram
    def initialize(notification)
      @message = notification['data']['message']
      @token = notification['data']['token']
      @chat_id = notification['data']['chat_id']
    end

    def run
      bot = ::Telegram::Bot::Client.new(@token)
      bot.send_message(chat_id: @chat_id, text: @message)
      Logger.log "Sent Telegram message '#{@message}' to #{@chat_id}"
    end
  end
end
