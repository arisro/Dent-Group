Drs::Application.routes.draw do
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  
  post 'user/upload_profile_picture', to: "users#upload_profile_picture"
  post 'user/save_profile_picture', to: "users#save_profile_picture"
  
  devise_for :user, controllers: { registrations: "registrations" }
  as :user do
    post "/sessions" => "sessions#create"
    delete "/sessions" => "sessions#destroy"
  end

  scope '(:country)', country: /int|ro|de/ do
    root 'dashboard#index'
    resources :news
    resources :jobs
    resources :bad_customers do
      resources :bad_customer_comments, only: [:create, :destroy]
    end

    get 'offers/buying', to: 'offers#index', type: 2
    get 'offers/selling', to: 'offers#index', type: 1
    resources :offers
  
    resources :suppliers do
      resources :supplier_comments, only: [:create, :destroy]
    end

    resources :users, only: [:show, :index]

    get 'about', to: 'static_pages#about'
    get 'subscriptions', to: 'static_pages#subscriptions'

    get 'language/:language', to: 'dashboard#change_language', as: :change_language, language: /en|ro/
  end
end
