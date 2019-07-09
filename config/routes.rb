Rails.application.routes.draw do
  get 'books/home'
  root to: 'homepage#new'
end
