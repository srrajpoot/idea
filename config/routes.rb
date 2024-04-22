Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "up" => "rails/health#show", as: :rails_health_check


post '/fedbacks_create', to: 'feedbacks#create'
post '/fedbacks', to: 'feedbacks#create'


  resources :accounts do
    post :resources, on: :collection
  end 

  resources :logins
  resources :addresses, only: [:create]
  resources :feedbacks, only: [:create, :update, :destroy]
  resources :settings, only: [:index, :show, :create, :update, :destroy]
  resources :add_ideas, only: [:index,:create, :show, :update, :destroy]
  resources :likes, only: [:index, :show, :create, :update, :destroy]
  resources :posts, only: [:index, :show, :create, :update, :destroy]




end
