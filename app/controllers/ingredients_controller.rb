class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:new, :create]

  def index
    @ingredients = current_user.user_ingredients.map(&:ingredient)
  end

  def new
    @ingredient = Ingredient.new
  end

  def show
    user_id = params[:user_id]
    recipe_id = params[:id]

    @recipe = Recipe.find_by(id: recipe_id, user_id: user_id)
    @user = User.find_by(id: user_id)

    if @recipe.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end

  def create
    ingredient_name = params[:ingredient][:name]
    ingredient = Ingredient.find_by(name: ingredient_name)
  
    if ingredient && current_user.user_ingredients.exists?(ingredient_id: ingredient.id)
      if params[:ingredient][:recipe_id].present?
        @recipe = Recipe.find(params[:ingredient][:recipe_id])
        @recipe.ingredients << ingredient
        flash[:success] = "#{ingredient_name} added to recipe!"
        redirect_to user_recipe_path(user_id: @recipe.user_id, id: @recipe.id)
      else
        flash[:error] = "Cannot add ingredient directly to user"
        redirect_to ingredients_path
      end
    else
      @ingredient = Ingredient.create(
        name: ingredient_name,
        measurement_unit: params[:ingredient][:measurement_unit],
        price: params[:ingredient][:price],
        quantity: params[:ingredient][:quantity],
        user: current_user
      )
      if params[:ingredient][:recipe_id].present?
        @recipe = Recipe.find(params[:ingredient][:recipe_id])
        @recipe.ingredients << @ingredient
        flash[:success] = "#{ingredient_name} added to recipe as a new ingredient!"
        redirect_to user_recipe_path(user_id: @recipe.user_id, id: @recipe.id)
      else
        UserIngredient.create(user: current_user, ingredient: @ingredient)
        flash[:success] = "#{ingredient_name} added to your ingredients!"
        redirect_to ingredients_path
      end
    end
  end
  
  

  # def create
  #   @ingredient = current_user.ingredients.new(ingredient_params)
  #   if @ingredient.save
  #     flash[:notice] = 'Ingredient successfully created!'
  #   else
  #     render :new
  #   end
  #   redirect_to @ingredient
  # end

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

  def destroy
    @ingredient = current_user.ingredients.find(params[:id])
    if @ingredient.destroy
      flash[:notice] = 'Ingredient successfully deleted!'
    else
      flash[:error] = 'Error deleting ingredient'
    end
    redirect_to ingredients_path
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
  end
end
