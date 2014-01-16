Drs::Application.routes.draw do
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  root 'dashboard#index'

  post 'user/upload_profile_picture', to: "users#upload_profile_picture"
  post 'user/save_profile_picture', to: "users#save_profile_picture"
  
  #devise_for :users, skip: [:sessions]
  devise_for :user, controllers: { registrations: "registrations" }
  as :user do
    post "/sessions" => "sessions#create"
    delete "/sessions" => "sessions#destroy"
  end

  resources :jobs
  resources :bad_customers
  resources :offers
  resources :suppliers
  resources :users, only: :show
end
