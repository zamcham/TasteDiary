Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/users/:user_id/recipes/:id', to: 'recipes#show', as: 'user_recipe'
  delete '/ingredients/:id', to: 'ingredients#destroy', as: 'delete_ingredient'

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :ingredients, only: [:new, :create, :destroy] # Nested within recipes
    member do
      post 'toggle_visibility'
    end
  end

  resources :ingredients # Not nested
end
