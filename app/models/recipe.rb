class Recipe < ApplicationRecord
  validates :title, presence: true
  belongs_to :user

  delegate :username, to: :user
end
