# spec/controllers/recipes_controller_spec.rb
require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    it "assigns user's recipes to @recipes" do
      # Create a user for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')

      # Create some recipes for the user
      recipe1 = Recipe.create(name: 'Recipe 1', description: 'Delicious recipe', preparation_time: 20,
                              cooking_time: 10, user: user)
      recipe2 = Recipe.create(name: 'Recipe 2', description: 'Another great recipe', preparation_time: 30,
                              cooking_time: 10, user: user)

      # Sign in the user using Devise test helper
      sign_in user

      # Call the index action
      get :index

      # Check that the @recipes variable is assigned correctly
      expect(assigns(:recipes)).to eq([recipe1, recipe2])
    end
  end

  describe 'GET #new' do
    it 'assigns a new recipe' do
      # Create a user for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')

      # Sign in the user using Devise test helper
      sign_in user

      # Get the new action
      get :new

      # Check if @recipe is a new Recipe instance
      expect(assigns(:recipe)).to be_a_new(Recipe)
      expect(response).to render_template('new')
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the recipe' do
      # Create a user for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')

      # Create a recipe for the user
      recipe_to_delete = Recipe.create(name: 'Recipe to Delete', description: 'A recipe to be deleted',
                                       preparation_time: 20, cooking_time: 10, user: user)

      # Sign in the user using Devise test helper
      sign_in user

      # Call the destroy action
      delete :destroy, params: { id: recipe_to_delete.id }

      # Check that the recipe was deleted
      expect(Recipe.exists?(recipe_to_delete.id)).to be_falsey
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe' do
      # Create a user for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')

      # Sign in the user using Devise test helper
      sign_in user

      # Post the create action with recipe parameters
      post :create,
           params: { recipe: { name: 'New Recipe', description: 'A new recipe', preparation_time: '30', cooking_time: '45',
                               public: true } }

      # Check for successful redirect and a flash message
      expect(response).to redirect_to(recipes_path)
      expect(flash[:notice]).to eq('Recipe was successfully created!')

      # Check if the recipe is created
      new_recipe = Recipe.find_by(name: 'New Recipe')
      expect(new_recipe).not_to be_nil
    end
  end

  describe 'GET #show' do
    it "renders the recipe's show page" do
      # Create a user and a recipe for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')
      recipe = Recipe.create(name: 'Test Recipe', description: 'A delicious test recipe', preparation_time: 30,
                             cooking_time: 45, user: user)

      # Get the show action for the recipe
      get :show, params: { user_id: user.id, id: recipe.id }

      # Check if the show template is rendered
      expect(response).to render_template('show')
    end

    it 'renders a 404 page for non-existing recipes' do
      # Create a user for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')

      # Get the show action for a non-existing recipe
      get :show, params: { user_id: user.id, id: 999 }

      # Check if a 404 page is rendered
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PATCH #toggle_visibility' do
    it "toggles the recipe's public visibility" do
      # Create a user and a recipe for testing
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')
      recipe = Recipe.create(name: 'Test Recipe', description: 'A delicious test recipe', preparation_time: 30,
                             cooking_time: 45, user: user, public: false)

      # Sign in the user using Devise test helper
      sign_in user

      # Get the toggle_visibility action
      patch :toggle_visibility, params: { id: recipe.id }

      # Reload the recipe from the database
      recipe.reload

      # Check if the recipe's public attribute is toggled
      expect(recipe.public).to eq(true) # Make sure it's toggled to true
      expect(response).to redirect_to(user_recipe_path(user_id: recipe.user_id, id: recipe.id))
    end
  end
end
