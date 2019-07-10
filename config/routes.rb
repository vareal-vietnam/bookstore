Rails.application.routes.draw do
  root to: 'homepage#new'
  resources :books
end
