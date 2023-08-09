class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = current_user.ingredients
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = current_user.ingredients.new(ingredient_params)
    if @ingredient.save
      flash[:notice] = "Ingredient successfully created!"
    else
      render :new
    end
    redirect_to @ingredient
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

  def destroy
    @ingredient = current_user.ingredients.find(params[:id])
    if @ingredient.destroy
      flash[:notice] = "Ingredient successfully deleted!"
    else
      flash[:error] = "Error deleting ingredient"
    end
    redirect_to ingredients_path
  end


  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end

end
