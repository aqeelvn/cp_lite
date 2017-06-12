class AddBookmarksCountToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :bookmarks_count, :integer, null: false, default: 0
  end
end
