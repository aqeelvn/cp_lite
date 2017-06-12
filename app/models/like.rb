class Like < ApplicationRecord
  validates :recipe_id, uniqueness: {scope: :user_id}
  belongs_to :recipe, counter_cache: true
  belongs_to :user
end
