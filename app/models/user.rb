class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :recipes, dependent: :destroy
  has_many :follows, foreign_key: :follower_id
  has_many :followed_users, through: :follows

  def owns?(object)
    object.user_id == id
  end

  def follow(user)
    if user != self
      followed_users << user
    end
  end

  def follows?(user)
    followed_users.include?(user)
  end

  def unfollow(user)
    followed_users.delete(user)
  end
end
