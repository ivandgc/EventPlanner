Rails.application.routes.draw do
  resources :terms
  resources :user_occasions
  get '/occassions/new', to: 'occasions#new', as: 'new_occasion'
  get '/occasions/:occasion_id', to: 'occasions#show', as: 'occasion'
  resources :occasions do
    resources :events
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static#index'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  post '/occasions/:occasion_id/add_friend', to: 'occasions#add_friend', as: 'add_friend'

  post '/occasions/:occasion_id/event/:id/vote', to: 'occasions#vote', as: 'vote'

end
