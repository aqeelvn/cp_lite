class AccessToken < ApplicationRecord
  belongs_to :user

  before_create :set_token
  validates :token, uniqueness: true

  private

  def set_token
    begin
      self.token = SecureRandom.hex(32)
    end while self.class.exists?(token: token)
  end
end
