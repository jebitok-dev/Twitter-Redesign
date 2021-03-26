Rails.application.routes.draw do
  root 'opinions#index'

  get '/signup', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'
  
  resources :users, only: %i[show new create]
  resources :opinions, only: %i[index show new create ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
