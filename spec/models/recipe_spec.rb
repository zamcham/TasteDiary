require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      user = User.create(email: 'user@example.com', password: 'password')
      recipe = user.recipes.build

      expect(recipe.user).to eq(user)
    end

    it 'has many ingredient_ownerships' do
      recipe = Recipe.create
      ownership = recipe.ingredient_ownerships.build

      expect(recipe.ingredient_ownerships).to include(ownership)
    end
  end
end
