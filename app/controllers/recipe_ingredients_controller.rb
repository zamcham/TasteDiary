class RecipeIngredientsController < ApplicationController
  before_action :set_recipe

  def new
    @ingredient = Ingredient.new
  end

  def create
    ingredient_name = params[:ingredient][:name]
    measurement_unit = params[:ingredient][:measurement_unit]
    price = params[:ingredient][:price]
    quantity = params[:ingredient][:quantity]
    ingredient = Ingredient.find_or_create_by(name: ingredient_name, measurement_unit: measurement_unit, price: price)
  
    if params[:ingredient][:recipe_quantity].present?
      handle_new_ingredient(ingredient, params[:ingredient][:recipe_quantity])
    else
      handle_user_ingredient(ingredient)
    end
  end
  
  private
  
  def handle_new_ingredient(ingredient, recipe_quantity)
    if params[:ingredient][:recipe_id].present?
      recipe = Recipe.find(params[:ingredient][:recipe_id])
      add_ingredient_to_recipe(ingredient, recipe, recipe_quantity)
      flash[:success] = "#{ingredient.name} added to recipe as a new ingredient!"
      redirect_to_recipe(recipe)
    else
      add_ingredient_to_user(ingredient)
    end
  end
  
  def add_ingredient_to_recipe(ingredient, recipe, recipe_quantity)
    IngredientOwnership.create(
      ingredient: ingredient,
      recipe: recipe,
      recipe_quantity: recipe_quantity
    )
  end
  
  def redirect_to_recipe(recipe)
    redirect_to user_recipe_path(user_id: recipe.user_id, id: recipe.id)
  end
  
  def user_has_ingredient?(ingredient)
    current_user.user_ingredients.exists?(ingredient: ingredient)
  end
  

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
  