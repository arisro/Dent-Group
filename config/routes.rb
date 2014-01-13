Drs::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'dashboard#index'
  
  #devise_for :users, skip: [:sessions]
  devise_for :user, controllers: { registrations: "registrations" }
  as :user do
    post "/sessions" => "sessions#create"
    delete "/sessions" => "sessions#destroy"
  end

  resources :jobs
  resources :users, only: :show
end
