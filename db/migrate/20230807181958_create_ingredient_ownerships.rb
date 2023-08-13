class CreateIngredientOwnerships < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_ownerships do |t|
      t.references :user, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.references :recipe, foreign_key: true
      t.decimal :user_quantity, precision: 10, scale: 2
      t.decimal :recipe_quantity, precision: 10, scale: 2

      t.timestamps
    end
  end
end
