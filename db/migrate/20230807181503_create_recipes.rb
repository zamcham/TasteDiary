class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false, limit: 50
      t.string :description, null: false, limit: 500
      t.integer :preparation_time, null: false
      t.integer :cooking_time, null: false
      t.boolean :public, null: false, default: false
      # TODO: Replace default image with a placeholder image
      t.string :photo, null: false, default: 'https://i.imgur.com/2xW3Y2W.png'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
