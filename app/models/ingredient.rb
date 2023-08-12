class Ingredient < ApplicationRecord
  has_many :ingredient_ownerships
  has_many :recipes, through: :ingredient_ownerships
end
