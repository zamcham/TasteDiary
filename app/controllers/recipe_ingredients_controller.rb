class RecipeIngredientsController < ApplicationController
  before_action :set_recipe

  def new
    @ingredient = Ingredient.new
  end

  def create
    ingredient_name = params[:ingredient][:name]
    measurement_unit = params[:ingredient][:measurement_unit]
    price = params[:ingredient][:price]
    quantity = params[:ingredient][:recipe_quantity]
    ingredient = Ingredient.find_or_create_by(name: ingredient_name, measurement_unit: measurement_unit, price: price)

    # Checks if ingredient exists in ingredient ownership table and has a user id
    if IngredientOwnership.find_by(ingredient_id: ingredient.id, user_id: current_user.id)
      # handle existing ingredient
      handle_existing_ingredient(ingredient, quantity)
    else
      # handle new ingredient
      handle_new_ingredient(ingredient, quantity)
    end
  end

  private

  def handle_new_ingredient(ingredient, recipe_quantity)
    recipe = Recipe.find(@recipe.id)
    add_ingredient_to_recipe(ingredient, recipe, recipe_quantity)
    flash[:success] = "#{ingredient.name} added to recipe as a new ingredient!"
    redirect_to_recipe(recipe)
  end

  def handle_existing_ingredient(ingredient, recipe_quantity)
    ingredient_ownership = IngredientOwnership.find_by(ingredient_id: ingredient.id, user_id: current_user.id)
    recipe = Recipe.find(@recipe.id)

    if ingredient_ownership && ingredient_ownership.user_id == current_user.id
      # Update recipe id and quantity in ingredient ownership
      ingredient_ownership.recipe_id = recipe.id
      ingredient_ownership.recipe_quantity = recipe_quantity

      if ingredient_ownership.save
        puts 'Successfully updated ingredient ownership'
      else
        puts 'Failed to save ingredient ownership changes'
      end
    else
      # Create new ingredient ownership
      add_ingredient_to_recipe(ingredient, recipe, recipe_quantity)
    end

    flash[:success] = "#{ingredient.name} added to recipe as a new ingredient!"
    redirect_to_recipe(recipe)
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

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
