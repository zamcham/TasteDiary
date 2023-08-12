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
    puts "Params: #{params.inspect}" # Debugging line

    ingredient_name = params[:ingredient][:name]
    Ingredient.find_by(name: ingredient_name)

    if params[:ingredient][:from_recipe].present?
      # Rest of your code
    elsif params[:ingredient][:from_user].present?
      # Rest of your code
    else
      flash[:error] = 'Invalid ingredient creation context'
      redirect_to ingredients_path
    end
  end

  private

  def handle_recipe_ingredient(ingredient, ingredient_name)
    if ingredient && user_has_ingredient?(ingredient)
      handle_existing_ingredient(ingredient)
    else
      handle_new_ingredient(ingredient_name)
    end
  end

  def handle_user_ingredient(_ingredient, ingredient_name)
    handle_new_user_ingredient(ingredient_name)
  end

  def handle_new_user_ingredient(ingredient_name)
    @ingredient = current_user.ingredients.create(
      name: ingredient_name,
      measurement_unit: params[:ingredient][:measurement_unit],
      price: params[:ingredient][:price],
      quantity: params[:ingredient][:quantity]
    )

    flash[:success] = "#{ingredient_name} added to your ingredients!"
    redirect_to ingredients_path
  end

  # Other methods...

  def ingredient_params
    params.require(:ingredient).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
  end
end
