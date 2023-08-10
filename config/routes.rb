Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/users/:user_id/recipes/:id', to: 'recipes#show', as: 'user_recipe'

  resources :ingredients
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
end
