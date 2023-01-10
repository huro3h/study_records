Rails.application.routes.draw do

  root 'static_pages#home'
  get  "/subjects",  to: "subjects#index"
  resources :users
  resources :subjects
end
