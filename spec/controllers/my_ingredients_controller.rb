# spec/controllers/my_ingredients_controller_spec.rb
require 'rails_helper'

RSpec.describe MyIngredientsController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  describe 'POST #create' do
    it "adds a new ingredient to the user's list" do
      # Create a user for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')

      # Sign in the user using Devise test helper
      sign_in user

      # Define ingredient parameters
      ingredient_params = {
        name: 'New Ingredient',
        measurement_unit: 'grams',
        price: 1.99,
        recipe_quantity: 2
      }

      # Post the create action with ingredient parameters
      post :create, params: { ingredient: ingredient_params }

      # Check for successful redirect and a flash message
      expect(response).to redirect_to(my_ingredients_path)
      expect(flash[:success]).to eq('New Ingredient added to your ingredients!')

      # Check if the ingredient ownership was created
      new_ingredient = Ingredient.find_by(name: 'New Ingredient')
      expect(new_ingredient).not_to be_nil
      expect(IngredientOwnership.find_by(user: user, ingredient: new_ingredient, user_quantity: 2)).not_to be_nil
    end
  end
end
