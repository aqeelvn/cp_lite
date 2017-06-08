class Recipe < ApplicationRecord
  validates :title, presence: true

  validates :ingredients, length: { minimum: 1 }
  validates :steps, length: { minimum: 1 }

  belongs_to :user

  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :user_activities, as: :target, dependent: :destroy

  accepts_nested_attributes_for :ingredients,
    allow_destroy: true,
    reject_if: :all_blank

  accepts_nested_attributes_for :steps,
    allow_destroy: true,
    reject_if: :all_blank

  delegate :username, to: :user

  scope :latest, -> { order(created_at: :desc) }
end
