Rails.application.routes.draw do
  get '/', to: 'opinions#index', as: :root
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'
  
  resources :users, except: [:new]
  resources :opinions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
