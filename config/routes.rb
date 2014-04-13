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
    get 'offers/rentals', to: 'offers#index', type: 3
    resources :offers
  
    resources :suppliers do
      resources :supplier_comments, only: [:create, :destroy]
    end

    resources :statuses, only: [:create, :destroy] do
      resources :status_comments, only: [:create, :destroy]
    end

    resources :users, only: [:show, :index] do
      member do
        get :following, :followers
      end
    end
    get 'feed', to: 'users#feed' 

    get 'language/:language', to: 'dashboard#change_language', as: :change_language, language: /en|ro/, defaults: { language: 'en' }

    resources :homepage_messages
  end

  resources :relationships, only: [:create, :destroy]
  resources :uploads
end
