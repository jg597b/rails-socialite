json.extract! event_list, :id, :user, :event, :created_at, :updated_at
json.url event_list_url(event_list, format: :json)
