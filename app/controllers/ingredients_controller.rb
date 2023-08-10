class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = current_user.ingredients
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

  def new
    @ingredient = Ingredient.new
    @recipe = Recipe.find_by(id: params[:recipe_id])
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user = current_user
    @recipe = Recipe.find_by(id: params[:recipe_id])

    if @ingredient.save
      if @recipe && !@recipe.ingredients.exists?(@ingredient)
        @recipe.ingredients << @ingredient
      end
      flash[:notice] = "Ingredient added."
      redirect_to @recipe || ingredients_path
    else
      render :new
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
end
