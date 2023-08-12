class ShoppingListController < ApplicationController
  def index
    @user = current_user
    @missing_ingredients = find_missing_ingredients
  end

  private

  def find_missing_ingredients
    missing_ingredients = []

    Recipe.where(user_id: current_user.id).each do |recipe|
      # find ownerships for this recipe
      ownerships = IngredientOwnership.where(recipe_id: recipe.id)

      ownerships.each do |ownership|
        ingredient = Ingredient.find(ownership.ingredient_id)
        user_quantity = ownership.user_quantity
        recipe_quantity = ownership.recipe_quantity
        user_ingredient = IngredientOwnership.where(user_id: current_user.id, ingredient_id: ingredient.id).first

        next unless user_ingredient.nil? || user_quantity < recipe_quantity

        missing_quantity = recipe_quantity - (user_quantity || 0)
        missing_ingredients << {
          ingredient: ingredient,
          missing_quantity: missing_quantity
        }
      end
    end

    missing_ingredients
  end
end
