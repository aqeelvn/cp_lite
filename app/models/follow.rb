class Follow < ApplicationRecord
  validate :ensure_not_following_self
  validates :follower_id, uniqueness: {scope: :followed_user_id}

  belongs_to :follower, class_name: "User"
  belongs_to :followed_user, class_name: "User"

  private

  def ensure_not_following_self
    if follower_id == followed_user_id
      errors.add(:follower_id, "Can not follow self")
    end
  end
end
