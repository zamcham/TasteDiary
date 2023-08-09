class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def new
    @recipe = Recipe.new
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path, notice: 'Recipe deleted!'
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    @recipe.preparation_time = recipe_params[:preparation_time].to_i
    @recipe.cooking_time = recipe_params[:cooking_time].to_i

    if @recipe.save
      flash[:notice] = 'Recipe was successfully created!'
      redirect_to @recipe
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description) # add attributes
  end
end
