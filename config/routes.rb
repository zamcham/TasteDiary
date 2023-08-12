Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/users/:user_id/recipes/:id', to: 'recipes#show', as: 'user_recipe'

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :ingredients, only: [:new, :create, :destroy] # Nested within recipes
    member do
      post 'toggle_visibility'
    end

    resources :recipe_ingredients, only: [:new, :create] # Nested for adding ingredients from recipe details
  end

  resources :ingredients # Not nested
end
