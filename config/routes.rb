Rails.application.routes.draw do
  resources :users
  resources :sessions, only: %i[new create]
  resource :sessions, only: [:destroy]
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  root to: 'books#index'
  resources :books, concerns: :paginatable
  resources :book_requests

end
