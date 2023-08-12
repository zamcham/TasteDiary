class IngredientOwnership < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :ingredient
    belongs_to :recipe, optional: true
end
  