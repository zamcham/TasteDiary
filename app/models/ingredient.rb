class Ingredient < ApplicationRecord
  has_many :ingredient_ownerships, dependent: :destroy
  has_many :recipes, through: :ingredient_ownerships
end
