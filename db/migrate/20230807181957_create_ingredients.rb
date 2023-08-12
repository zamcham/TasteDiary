class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false, limit: 50
      t.string :measurement_unit, null: false, limit: 50
      t.decimal :price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
