class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false, limit: 50
      t.string :measurement_unit, null: false, limit: 50
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
