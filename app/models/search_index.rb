class SearchIndex < ApplicationRecord
  validates :recipe, uniqueness: true
  validates :index, presence: true

  belongs_to :recipe
end
