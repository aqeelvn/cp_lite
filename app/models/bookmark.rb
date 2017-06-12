class Bookmark < ApplicationRecord
  validates :recipe_id, uniqueness: {scope: :user_id}
  belongs_to :user
  belongs_to :recipe, counter_cache: true
end
