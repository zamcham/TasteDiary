# spec/controllers/recipe_ingredients_controller_spec.rb
require 'rails_helper'

RSpec.describe RecipeIngredientsController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  describe 'GET #new' do
    it 'assigns a new ingredient for a recipe' do
      # Create a user for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')

      # Create a recipe with a description, preparation time, and cooking time for testing
      recipe = Recipe.create(
        name: 'Test Recipe',
        description: 'A delicious test recipe',
        preparation_time: 30, # Provide a value for preparation_time
        cooking_time: 45, # Provide a value for cooking_time
        user: user
      )

      # Sign in the user using Devise test helper
      sign_in user

      get :new, params: { recipe_id: recipe.id }

      expect(assigns(:ingredient)).to be_a_new(Ingredient)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it "adds a new ingredient to the recipe's ingredient list" do
      # Create a user for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')

      # Create a recipe with a description, preparation time, and cooking time for testing
      recipe = Recipe.create(
        name: 'Test Recipe',
        description: 'A delicious test recipe',
        preparation_time: 30, # Provide a value for preparation_time
        cooking_time: 45, # Provide a value for cooking_time
        user: user
      )

      # Create an ingredient for testing
      ingredient_params = {
        name: 'New Ingredient',
        measurement_unit: 'grams',
        price: 1.99,
        recipe_quantity: 2
      }

      # Sign in the user using Devise test helper
      sign_in user

      # Post the create action with ingredient parameters
      post :create, params: { recipe_id: recipe.id, ingredient: ingredient_params }

      # Check for successful redirect and a flash message
      expect(response).to redirect_to(user_recipe_path(user_id: recipe.user_id, id: recipe.id))
      expect(flash[:success]).to eq('New Ingredient added to recipe as a new ingredient!')

      # Check if the ingredient ownership was created
      new_ingredient = Ingredient.find_by(name: 'New Ingredient')
      expect(new_ingredient).not_to be_nil
      expect(IngredientOwnership.find_by(ingredient: new_ingredient, recipe: recipe, recipe_quantity: 2)).not_to be_nil
    end
  end
end
