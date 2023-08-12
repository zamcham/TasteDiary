class MyIngredientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = current_user.ingredients
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    ingredient_name = params[:ingredient][:name]
    measurement_unit = params[:ingredient][:measurement_unit]
    price = params[:ingredient][:price]
    quantity = params[:ingredient][:recipe_quantity]
    ingredient = Ingredient.find_or_create_by(
      name: ingredient_name,
      measurement_unit: measurement_unit,
      price: price
    )

    handle_user_ingredient(ingredient, quantity)
  end

  private

  def handle_user_ingredient(ingredient, quantity)
    IngredientOwnership.create(
      user: current_user,
      ingredient: ingredient,
      user_quantity: quantity,
      recipe_quantity: nil
    )

    flash[:success] = "#{ingredient.name} added to your ingredients!"
    redirect_to my_ingredients_path
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :measurement_unit, :price, :quantity)
  end
end
