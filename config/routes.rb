Rails.application.routes.draw do
  resources :terms
  resources :user_occasions
  resources :occasions do
    resources :events
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static#index'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  post '/occasions/:id/add_friend', to: 'occasions#add_friend', as: 'add_friend'

  post '/occasions/:id/event/:id/vote', to: 'events#vote', as: 'vote'

end
