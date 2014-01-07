Drs::Application.routes.draw do
  root 'dashboard#index'
  
  #devise_for :users, skip: [:sessions]
  devise_for :user
  as :user do
    post "/sessions" => "sessions#create"
    delete "/sessions" => "sessions#destroy"
  end
end
