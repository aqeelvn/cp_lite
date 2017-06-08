class UserActivity < ApplicationRecord
  validates :action, presence: true

  belongs_to :user
  belongs_to :target, polymorphic: true
end
