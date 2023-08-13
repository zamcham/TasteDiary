class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_ownerships, dependent: :destroy
  has_many :ingredients, through: :ingredient_ownerships
end
