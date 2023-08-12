class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[new create]
  before_action :set_ingredient_ownership, only: %i[destroy]

  def index
    @ingredients = current_user.ingredients
  end

  def new
    @ingredient = Ingredient.new
  end

  def destroy
    @ingredient_ownership = IngredientOwnership.find_by(user_id: current_user.id)
  
    if @ingredient_ownership
      @ingredient_ownership.user_id = nil
      @ingredient_ownership.user_quantity = nil
      if @ingredient_ownership.save
        flash[:notice] = 'Ingredient successfully removed from your list!'
      else
        flash[:error] = 'Error removing ingredient'
      end
    else
      flash[:error] = 'Ingredient ownership not found'
      puts 'Ingredient ownership not found'
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

  def set_ingredient_ownership
    @ingredient_ownership = current_user.ingredient_ownerships.find_by(ingredient_id: params[:id])
  end
  
end
