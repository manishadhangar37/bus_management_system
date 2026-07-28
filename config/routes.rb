Rails.application.routes.draw do
  
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  get "home", to: "home#index"

  resources :users

 get "email_verify", to: "email_verifications#email_varify"

 get "/login", to: "sessions#new"
 post "/login", to: "sessions#create"
 delete "/logout", to: "sessions#destroy"
 
get "/search", to:"buses#search"
 
 
 resources :buses
 
 resources :buses do
   resources :bookings
 end
resources :bookings, only: [:index]
 get "/admins", to: "admins_dashboard#admin"
 get "/admins/buses", to: "admins_dashboard#index"
end
