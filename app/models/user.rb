class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :feed_items, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "Follow",
    dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships

  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: "Follow",
    dependent: :destroy
  has_many :followers, through: :follower_relationships

  has_many :likes, class_name: "Like", dependent: :destroy
  has_many :liked_recipes, through: :likes, source: :recipe

  has_many :bookmarks, class_name: "Bookmark", dependent: :destroy
  has_many :bookmarked_recipes, through: :bookmarks, source: :recipe

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

  def like(recipe)
    likes.find_or_create_by(recipe:recipe)
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  def liked?(recipe)
    liked_recipes.include?(recipe)
  end

  def unlike(recipe)
    liked_recipes.delete(recipe)
  end

  def bookmark(recipe)
    bookmarks.find_or_create_by(recipe:recipe)
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  def bookmarked?(recipe)
    bookmarked_recipes.include?(recipe)
  end

  def remove_bookmark(recipe)
    bookmarked_recipes.delete(recipe)
  end
end
