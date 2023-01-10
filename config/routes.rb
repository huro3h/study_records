Rails.application.routes.draw do
  root 'static_pages#home'
  resources :tops, only: :index
  resources :users
end
