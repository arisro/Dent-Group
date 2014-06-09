Drs::Application.routes.draw do
  # ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  
  post 'user/upload_profile_picture', to: "users#upload_profile_picture"
  post 'user/save_profile_picture', to: "users#save_profile_picture"

  put 'user/pay', to: "users#set_payed"
  put 'user/cancel_reset', to: "users#cancel_reset_password"
  
  devise_for :user, controllers: { registrations: "registrations", passwords: "passwords", omniauth_callbacks: "omniauth_callbacks" }
  as :user do
    post "/sessions" => "sessions#create"
    delete "/sessions" => "sessions#destroy"
  end

  scope '(:country)', country: /int|ro|de/ do
    root 'dashboard#index'
    resources :news do
      resources :news_comments, only: [:create, :destroy]
    end
    resources :jobs
    resources :bad_customers do
      resources :bad_customer_comments, only: [:create, :destroy]
    end

    get 'offers/buying', to: 'offers#index', type: 2
    get 'offers/selling', to: 'offers#index', type: 1
    get 'offers/rentals', to: 'offers#index', type: 3
    resources :offers

    get 'search', to: 'dashboard#search'
    get 'privacy', to: 'static_pages#privacy'
  
    resources :suppliers do
      resources :supplier_comments, only: [:create, :destroy]
    end

    resources :statuses, only: [:create, :destroy] do
      resources :status_comments, only: [:index, :create, :destroy]
    end

    resources :users, only: [:show, :index] do
      member do
        get :following, :followers, :activity
      end
    end
    get 'feed', to: 'user_groups#feed'

    get 'language/:language', to: 'dashboard#change_language', as: :change_language, language: /en|ro/, defaults: { language: 'en' }

    get 'group/:user_group_ident/feed', to: 'user_groups#feed', as: :group_feed, :constraints => { :user_group_ident => /[^\/]*/ }

    resources :homepage_messages
  end

  resources :relationships, only: [:create, :destroy]
  resources :uploads

  get "chat/online", to: "chat#get_online_users"
  get "chat/get_user/:id", to: "chat#get_user"
  get "chat/options", to: "chat#edit_options"
  put "chat/options", to: "chat#edit_options"
  get "chat/history/:user_id", to: "chat#get_history"

  resources :chat_ignores, only: [:index, :create, :destroy]
  
end
