class AgendasController < ApplicationController
  def index
    if @account_type == 'host'
      @agendas = Event.get_upcoming_events_by_host(current_user)
    else
      @agendas = Event.get_upcoming_public_events_and_user(current_user)
    end
  end
end
