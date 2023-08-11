class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[new create]

  def index
    @ingredients = current_user.user_ingredients.map(&:ingredient)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    ingredient_name = params[:ingredient][:name]
    ingredient = Ingredient.find_by(name: ingredient_name)

    if ingredient && user_has_ingredient?(ingredient)
      handle_existing_ingredient(ingredient)
    else
      handle_new_ingredient(ingredient_name)
    end
  end

  def show
    user_id = params[:user_id]
    recipe_id = params[:id]

    @recipe = Recipe.find_by(id: recipe_id, user_id: user_id)
    @user = User.find_by(id: user_id)

    return unless @recipe.nil?

    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  def destroy
    @ingredient = current_user.user_ingredients.find_by(id: params[:id])
  
    if @ingredient && @ingredient.destroy
      flash[:notice] = 'Ingredient successfully deleted from your list!'
    else
      flash[:error] = 'Error deleting ingredient'
    end
  
    redirect_to ingredients_path
  end

  private

  def user_has_ingredient?(ingredient)
    current_user.user_ingredients.exists?(ingredient_id: ingredient.id)
  end

  def handle_existing_ingredient(ingredient)
    if params[:ingredient][:recipe_id].present?
      @recipe = Recipe.find(params[:ingredient][:recipe_id])
      add_ingredient_to_recipe(ingredient)
      flash[:success] = "#{ingredient.name} added to recipe!"
      redirect_to_recipe
    else
      handle_direct_user_addition
    end
  end

  def handle_direct_user_addition
    flash[:error] = 'Cannot add ingredient directly to user'
    redirect_to ingredients_path
  end

  def add_ingredient_to_recipe(ingredient)
    @recipe.ingredients << ingredient
  end

  def redirect_to_recipe
    redirect_to user_recipe_path(user_id: @recipe.user_id, id: @recipe.id)
  end

  def handle_new_ingredient(ingredient_name)
    @ingredient = Ingredient.create(
      name: ingredient_name,
      measurement_unit: params[:ingredient][:measurement_unit],
      price: params[:ingredient][:price],
      quantity: params[:ingredient][:quantity],
      user: current_user
    )
  
    if params[:ingredient][:recipe_id].present?
      @recipe = Recipe.find(params[:ingredient][:recipe_id])
      add_ingredient_to_recipe(@ingredient)
      flash[:success] = "#{ingredient_name} added to recipe as a new ingredient!"
      redirect_to_recipe
    else
      add_ingredient_to_user(ingredient_name)  # Pass ingredient_name here
    end
  end

  def add_ingredient_to_user(ingredient_name)
    UserIngredient.create(user: current_user, ingredient: @ingredient)
    flash[:success] = "#{ingredient_name} added to your ingredients!"
    redirect_to ingredients_path
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient
    else
      render :edit
    end
  end
  

  # def destroy
  #   @ingredient = current_user.ingredients.find(params[:id])
  #   if @ingredient.destroy
  #     flash[:notice] = 'Ingredient successfully deleted!'
  #   else
  #     flash[:error] = 'Error deleting ingredient'
  #   end
  #   redirect_to ingredients_path
  # end

  def ingredient_params
    params.require(:ingredient).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
  end
end
