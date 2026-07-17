Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: [:new, :create]

  resources :email_varifications
end
