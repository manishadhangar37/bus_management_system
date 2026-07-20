Rails.application.routes.draw do
   
  get "up" => "rails/health#show", as: :rails_health_check
 
  resources :users, only: [:new, :create]

 get "email_verify", to:"email_verifications#email_verify",as: :email_verify
 
 get "/login", to:"sessions#new"
 post "/login", to:"sessions#create"
 
 delete "/logout", to:"sessions#destroy"
 resources :buses

end
