Rails.application.routes.draw do
  root 'opinions#index'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#delete'
  
  resources :users, only: %i[show new create]
  resources :opinions, only: %i[index show new create ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
