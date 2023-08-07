# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_07_182006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "measurement_unit", limit: 50, null: false
    t.integer "price", null: false
    t.integer "quantity", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_meals_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "description", limit: 500, null: false
    t.integer "preparation_time", null: false
    t.integer "cooking_time", null: false
    t.boolean "public", default: false, null: false
    t.string "photo", default: "https://i.imgur.com/2xW3Y2W.png", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "email", limit: 50, null: false
    t.string "password_digest", null: false
    t.string "photo", default: "https://i.imgur.com/2xW3Y2W.png", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ingredients", "users"
  add_foreign_key "meals", "recipes"
  add_foreign_key "recipes", "users"
end
