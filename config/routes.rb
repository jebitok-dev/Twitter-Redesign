Rails.application.routes.draw do
  get '/login'  , to: 'sessions#new'
  get '/home', to: 'opinions#index'
  get '/signup', to: 'users#new'
  root 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'
  get '/follow_user/:id' , to: 'users#follow_user', as: :follow_user

  resources :users, except: [:new]
  resources :opinions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
