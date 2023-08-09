Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :ingredients
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
end
