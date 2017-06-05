class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :recipes, dependent: :destroy

  def owns?(object)
    object.user_id == id
  end
end
