# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
userOne = User.create(name: 'Naan', email: '123email@gmail.com', password_digest: '123456', photo: 'defaultUser.jpg')
ingredientOne = userOne.ingredients.create(name: 'pepper', measurement_unit: 'g', price: 1, quantity: 1)
recipeOne = userOne.recipes.create(name: 'Stuffed Peppers', description: 'peppers are yummy!', preparation_time: 35, cooking_time: 15, public: true, photo: 'defaultRecipe.jpg')
mealOne = recipeOne.meals.create(quantity: 1)

userTwo = User.create(name: 'Cristian', email: '456email@gmail.com', password_digest: '123456', photo: 'defaultUser.jpg')
ingredientTwo = userOne.ingredients.create(name: 'salt', measurement_unit: 'g', price: 1, quantity: 1)
recipeTwo = userOne.recipes.create(name: 'Popcorn with Butter', description: 'Salty popcorns with butter!', preparation_time: 35, cooking_time: 15, public: true, photo: 'defaultRecipe.jpg')
mealTwo = recipeOne.meals.create(quantity: 1)
