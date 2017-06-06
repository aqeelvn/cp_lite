class Recipe < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients,
    allow_destroy: true,
    reject_if: :all_blank

  delegate :username, to: :user

  scope :latest, -> { order(created_at: :desc) }

  # def self.latest
  #   order(created_at: :desc)
  # end
end
