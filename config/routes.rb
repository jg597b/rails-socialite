Rails.application.routes.draw do
  resources :event_lists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'events#index'

  get '/welcome' => 'application#welcome', as: :application_welcome

  get '/events/add' => 'events#add', as: :events_add
  post '/events/add' => 'events#add', as: :events_add_post
  get '/events(/:event_time)' => 'events#index', as: :events_index
  get '/events/:id/invitation_list' => 'events#invitation_list', as: :show_event
  post '/events/:id/invite_user' => 'events#invite_user', as: :invite_event
  get '/events/:id/to_csv' => 'events#to_csv', as: :csv_event


  get '/hosts/register' => 'hosts#register', as: :hosts_register
  post '/hosts/register' => 'hosts#register', as: :hosts_register_post
  get '/hosts/login' => 'hosts#login', as: :hosts_login
  post '/hosts/login' => 'hosts#login', as: :hosts_login_post
  get '/hosts/edit_profile' => 'hosts#edit_profile', as: :hosts_edit_profile
  post '/hosts/edit_profile' => 'hosts#edit_profile', as: :hosts_edit_profile_post
  get '/hosts/logout' => 'hosts#logout', as: :hosts_logout

  get '/users/register' => 'users#register', as: :users_register
  post '/users/register' => 'users#register', as: :users_register_post
  get '/users/login' => 'users#login', as: :users_login
  post '/users/login' => 'users#login', as: :users_login_post
  get '/users/edit_profile' => 'users#edit_profile', as: :users_edit_profile
  post '/users/edit_profile' => 'users#edit_profile', as: :users_edit_profile_post
  get '/users/logout' => 'users#logout', as: :users_logout
  get '/users/add_user_event/:event_id'=> 'users#index', as: :users_index
end
