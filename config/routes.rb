Rails.application.routes.draw do
  root 'manuscripts#index'
  resources :manuscripts do
    resources :quires, except: [:index]
  end
  resources :quires do
    resources :leaves, except: [:index]
  end
  devise_for :accounts
end
