Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'session#create'
  delete '/logout',  to: 'sessions#destroy'

  root to: 'homepage#new'
  post '/signup',  to: 'users#create'

  resources :books
  resources :users
end
