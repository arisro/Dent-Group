Drs::Application.routes.draw do
  devise_for :users
  root 'dashboard#index'
end
