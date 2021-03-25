Rails.application.routes.draw do
  resources :opinions
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#delete'
  
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
