class EventsController < ApplicationController

  before_action :only_host_action, :only => [:add, :invitation_list, :invite_user]

  def invitation_list
    @event = Event.find(params[:id])
    if params[:search].present?
      search_query = params[:search].strip
      @uninvited_users = @event.users_not_invited.where("last_name like ? OR first_name like ? OR email_addr like ?",
                                                        search_query, search_query, search_query).order("created_at DESC")
    else
      @uninvited_users = @event.users_not_invited
    end
    @pending_users = @event.pending_users_list
    @attendees = @event.attendees
  end

  def invite_user
    User.where(id: params[:user_id]).each{|user| user.get_invited_in(Event.find(params[:id]))}
    redirect_to show_event_path(params[:id])
  end

  def to_csv
    respond_to do |format|
      format.html
      format.csv { send_data Event.to_csv_user_info(Event.find(params[:id]), Event.find(params[:id]).invited_users), filename: "event-user-list-#{Date.today}.csv"  }
    end
  end

  def index
    @current_user = current_user
    @event_time = if params[:event_time].blank? || ['upcoming', 'past'].index(params[:event_time]).nil?
                    'upcoming'
                  else
                    params[:event_time]
                  end

    @events = if @account_type == 'host'
                if @event_time == 'upcoming'
                  Event.get_upcoming_events_by_host(@current_host.id)
                else
                  Event.get_past_events_by_host(@current_host.id)
                end
              else
                if @event_time == 'upcoming'
                  Event.get_upcoming_public_events_and_user(current_user)
                else
                  Event.get_past_public_events
                end
              end
  end

  def add
    if request.post?
      @event = Event.new(event_params.merge(host_id: @current_host.id))
      if @event.valid? && @event.save
        redirect_to events_index_path
      else
        flash[:error] = @event.errors.full_messages.map { |v| v }.join('<br/>')
        redirect_to events_add_path
      end
    else
      @event = Event.new
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :description, :capacity, :event_start, :event_end, :rsvp_start, :rsvp_end, :event_type, :venue_addr1, :venue_addr2, :venue_city, :venue_state, :venue_zip)
  end

end