# Create users
user_one = User.create!(name: 'Naan', email: '123email@gmail.com', password: '123456', photo: 'defaultUser.jpg')
user_two = User.create!(name: 'Cristian', email: '456email@gmail.com', password: '123456', photo: 'defaultUser.jpg')

# Create ingredients owned by users
ingredient_one = Ingredient.create!(name: 'Pepper', measurement_unit: 'g', price: 0.99)
ingredient_two = Ingredient.create!(name: 'Salt', measurement_unit: 'lb', price: 0.50)
ingredient_three = Ingredient.create!(name: 'Chicken Breast', measurement_unit: 'lb', price: 1)

# Create recipes with ingredients
recipe_one = user_one.recipes.create!(
  name: 'Pulled BBQ chicken',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
  preparation_time: 35,
  cooking_time: 15,
  public: true,
  photo: 'defaultRecipe.jpg'
)
  
recipe_two = user_two.recipes.create!(
  name: 'Orange chicken',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquam nulla facilisi cras fermentum. Nunc sed id semper risus in.',
  preparation_time: 35,
  cooking_time: 15,
  public: true,
  photo: 'defaultRecipe.jpg'
)

# Ingredient ownerships
ownership1 = IngredientOwnership.create(user: user_one, ingredient: ingredient_one, user_quantity: 50)
ownership2 = IngredientOwnership.create(user: user_two, ingredient: ingredient_two, user_quantity: 5)
ownership3 = IngredientOwnership.create(user: user_two, recipe: recipe_one ,ingredient: ingredient_three, user_quantity: 2, recipe_quantity: 1)

