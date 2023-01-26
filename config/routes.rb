Rails.application.routes.draw do
  
  root 'static_pages#home'
  resources :tops, only: :index
  resources :users, only: [:new, :create, :show]
  resources :subjects, only: [:index, :new, :create, :show]
  resources :study_records, only: [:new, :create, :destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
