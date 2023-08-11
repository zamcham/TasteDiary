# Create users
user_one = User.create!(name: 'Naan', email: '123email@gmail.com', password: '123456', photo: 'defaultUser.jpg')
user_two = User.create!(name: 'Cristian', email: '456email@gmail.com', password: '123456', photo: 'defaultUser.jpg')

# Create ingredients owned by users
ingredient_one = Ingredient.create!(name: 'pepper', measurement_unit: 'g', price: 1, quantity: 1)
ingredient_two = Ingredient.create!(name: 'salt', measurement_unit: 'g', price: 1, quantity: 1)

# Create recipes with ingredients
recipe_one = user_one.recipes.create!(
  name: 'Pulled BBQ chicken',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
  preparation_time: 35,
  cooking_time: 15,
  public: true,
  photo: 'defaultRecipe.jpg'
)
recipe_one.ingredients << ingredient_one
  
recipe_two = user_two.recipes.create!(
  name: 'Orange chicken',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquam nulla facilisi cras fermentum. Nunc sed id semper risus in.',
  preparation_time: 35,
  cooking_time: 15,
  public: true,
  photo: 'defaultRecipe.jpg'
)
recipe_two.ingredients << ingredient_two

# Not owned by any user
ingredient_five = Ingredient.create!(name: 'Chicken Breast', measurement_unit: 'Lb', price: 2, quantity: 2)
recipe_two.ingredients << ingredient_five

# Create additional ingredients and recipes
ingredient_three = Ingredient.create!(name: 'corn', measurement_unit: 'g', price: 2, quantity: 2)
ingredient_four = Ingredient.create!(name: 'apple', measurement_unit: 'pieces', price: 0.5, quantity: 3)

recipe_three = user_one.recipes.create!(
  name: 'Garlic Shrimp',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Laoreet suspendisse interdum consectetur libero id faucibus nisl. Pretium quam vulputate dignissim suspendisse in est ante in.',
  preparation_time: 25,
  cooking_time: 10,
  public: false,
  photo: 'shrimpRecipe.jpg'
)
recipe_three.ingredients << ingredient_four
