require 'rails_helper'

RSpec.describe IngredientOwnership, type: :model do
  # Test associations
  it 'belongs to an ingredient' do
    # Create a valid Ingredient with a measurement unit and price (if applicable)
    ingredient = Ingredient.create(name: 'Test Ingredient', measurement_unit: 'grams', price: 1.99)

    # Create an IngredientOwnership associated with the created ingredient
    ownership = IngredientOwnership.new(ingredient: ingredient)

    expect(ownership.ingredient).to eq(ingredient)
  end

  it 'belongs to a user (optional)' do
    ownership = IngredientOwnership.new(user_id: nil) # Optional user association

    expect(ownership.user).to be_nil
  end

  it 'belongs to a recipe (optional)' do
    ownership = IngredientOwnership.new(recipe_id: nil) # Optional recipe association

    expect(ownership.recipe).to be_nil
  end

  # Test validations
  it 'requires an ingredient' do
    ownership = IngredientOwnership.new
    ownership.valid?
    expect(ownership.errors[:ingredient]).to include('must exist')
  end
end
