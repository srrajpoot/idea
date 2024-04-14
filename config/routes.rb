Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "up" => "rails/health#show", as: :rails_health_check


  resources :accounts do
    post :resources, on: :collection
  end 

  resources :logins

  # namespace :logins do
  #   namespace :v1 do
  #     post '/login', to: 'logins#create'
  #   end
  # end

end
