Rails.application.routes.draw do
  root 'manuscripts#index'
  resources :manuscripts do
    resources :quires, except: [:index]
  end
  devise_for :accounts
end
