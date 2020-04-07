Rails.application.routes.draw do
  root 'manuscripts#index'
  resources :manuscripts do
    resources :quires, except: [:index]
  end
  resources :quires do
    resources :leaves, only: [:edit]
  end
  devise_for :accounts
end
