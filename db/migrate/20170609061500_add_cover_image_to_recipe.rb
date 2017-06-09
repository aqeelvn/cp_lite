class AddCoverImageToRecipe < ActiveRecord::Migration[5.1]
  def up
    add_attachment :recipes, :cover_image
  end

  def down
    remove_attachment :recipes, :cover_image
  end
end
