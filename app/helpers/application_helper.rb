module ApplicationHelper

  def add_user_to_event(user_id)
    p "Event_id-->#{params[:event_id]}"
    p "User_id-->#{user_id}"
    EventList.create({event_id:params[:event_id],user_id:[user_id]})
  end
end
