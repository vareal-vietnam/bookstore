Rails.application.routes.draw do
  resources :users, only: %i[new create show edit update] do
    resources :book_requests, controller: 'users/book_requests'
  end
  resources :sessions, only: %i[new create]
  resource :sessions, only: [:destroy]
  root to: 'books#index'
  resources :books
  resources :book_requests
end
