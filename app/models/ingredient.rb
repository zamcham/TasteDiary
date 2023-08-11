class Ingredient < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :recipe, optional: true
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :user_ingredients
end
