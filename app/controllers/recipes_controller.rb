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
      redirect_to recipes_path
    else
      render :new
    end
  end

  def show
    user_id = params[:user_id]
    recipe_id = params[:id]

    @recipe = Recipe.find_by(id: recipe_id, user_id: user_id)
    @user = User.find_by(id: user_id)

    if @recipe.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    else
      render 'show'
    end
  end

  def toggle_visibility
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to user_recipe_path(user_id: @recipe.user_id, id: @recipe.id)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
