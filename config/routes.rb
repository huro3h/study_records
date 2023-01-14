Rails.application.routes.draw do

  root 'static_pages#home'
  resources :tops, only: :index
  resources :users
  resources :subjects, only: [:index, :new, :create, :show]
  resources :study_records
end
