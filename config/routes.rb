Rails.application.routes.draw do
  get 'public_recipes/index'
  get 'shopping_list/index'
  devise_for :users
  root 'home#index'
  get '/users/:user_id/recipes/:id', to: 'recipes#show', as: 'user_recipe'
  get '/shopping_list', to: 'shopping_list#index', as: 'shopping_list'


  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :ingredients, only: [:new, :create, :edit, :update, :destroy] # Nested within recipes
    member do
      post 'toggle_visibility'
    end

    resources :recipe_ingredients, only: [:new, :create] # Nested for adding ingredients from recipe details
  end

  resources :ingredients # Not nested

  resources :my_ingredients, only: [:index, :new, :create] # Routes for MyIngredientsController
  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
end
