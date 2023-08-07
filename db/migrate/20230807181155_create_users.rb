class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 50
      t.string :password_digest, null: false
      # TODO: Replace default user image with a placeholder image
      t.string :photo, null: false, default: 'https://avatars.githubusercontent.com/u/115372699?v=4'

      t.timestamps
    end
  end
end
