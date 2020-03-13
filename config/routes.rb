Rails.application.routes.draw do
  root 'manuscripts#index'

  resources :manuscripts do
    resources :quires
  end
  resources :quires do
    resources :leaves
  end

  devise_for :accounts
end
