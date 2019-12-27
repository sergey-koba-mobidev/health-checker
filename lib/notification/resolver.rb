# frozen_string_literal: true

require './lib/notification/telegram'
require './lib/logger'

class Notification 
  class Resolver
    def initialize(notifications, from_state, to_state)
      @notifications = notifications
      @from_state = from_state
      @to_state = to_state
    end

    def run
      @notifications.each do |notification|
        state = notification['state']
        next if state['for'] != nil && state['for'] != @to_state
        next if state['for'] == nil && (state['from'] != @from_state || state['to'] != @to_state)

        Logger.log "Firing notification #{notification['name']}"
        Object.const_get("Notification::#{notification['type'].capitalize}").new(notification).run
      end
    end
  end
end
