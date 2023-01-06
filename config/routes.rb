Rails.application.routes.draw do
  resources :subjects

  root 'static_pages#home'
  get  "/subjects",  to: "subjects#index"
end
