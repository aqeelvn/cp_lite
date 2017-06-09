class CreateSearchIndices < ActiveRecord::Migration[5.1]
  def change
    create_table :search_indices do |t|
      t.references :recipe, foreign_key: true, index: { unique: true }
      t.text :index, null: false

      t.timestamps
    end

    #add_index :search_indices, :recipe_id, unique: true
  end
end
