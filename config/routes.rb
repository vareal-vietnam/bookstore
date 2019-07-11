Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'session#create'
  delete '/logout',  to: 'sessions#destroy'

  post '/signup',  to: 'users#create'

  resources :users
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  root to: 'books#index'
  resources :books, concerns: :paginatable
end
