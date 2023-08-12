class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[new create]

  def index
    @ingredients = current_user.ingredients
  end

  def new
    @ingredient = Ingredient.new
  end

  def destroy
    @ingredient = current_user.user_ingredients.find_by(id: params[:id])

    if @ingredient&.destroy
      flash[:notice] = 'Ingredient successfully deleted from your list!'
    else
      flash[:error] = 'Error deleting ingredient'
    end

    redirect_to ingredients_path
  end

  def create
    ingredient_name = params[:ingredient][:name]
    measurement_unit = params[:ingredient][:measurement_unit]
    price = params[:ingredient][:price]
    quantity = params[:ingredient][:quantity]

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
    )

    flash[:success] = "#{ingredient.name} added to your ingredients!"
    redirect_to ingredients_path
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
  end
end
