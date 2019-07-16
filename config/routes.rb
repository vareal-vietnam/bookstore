Rails.application.routes.draw do
  resources :users
  resources :sessions, only: %i[new create destroy]
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  root to: 'books#index'
  resources :books, concerns: :paginatable
  delete 'logout', to: 'sessions#destroy'
end
