class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :recipe

      t.timestamps
    end
    add_index :likes, [:user_id, :recipe_id], unique: true
  end
end
