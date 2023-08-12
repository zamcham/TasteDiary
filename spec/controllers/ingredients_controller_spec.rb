require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #index" do
    it "assigns @ingredients with user's ingredients" do
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')
      ingredient = Ingredient.create(name: 'Test Ingredient', measurement_unit: 'grams', price: 1.99)
      ingredient_ownership = IngredientOwnership.create(user: user, ingredient: ingredient, user_quantity: 2)

      sign_in user

      get :index

      expect(assigns(:ingredients)).to eq([ingredient])
    end
  end
end
