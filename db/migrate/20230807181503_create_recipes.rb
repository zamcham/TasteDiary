class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false, limit: 50
      t.string :description, null: false, limit: 500
      t.integer :preparation_time, null: false
      t.integer :cooking_time, null: false
      t.boolean :public, null: false, default: false
      # TODO: Replace default image with a placeholder image
      t.string :photo, null: false, default: 'https://images.immediate.co.uk/production/volatile/sites/30/2013/05/Chicken-leek-and-broccoli-rice-stir-fry-ffe0df6.jpg'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
