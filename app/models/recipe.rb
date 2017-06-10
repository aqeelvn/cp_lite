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

  has_one :search_index, dependent: :destroy

  has_attached_file :cover_image,
    styles: {
      large:"1024x1024",
      medium: "300x300>",
      thumb: "100x100>"
    },
    default_url: "/system/recipes/cover_images/missing-image.png"

  validates_attachment_content_type :cover_image, content_type: /\Aimage\/.*\z/

  accepts_nested_attributes_for :ingredients,
    allow_destroy: true,
    reject_if: :all_blank

  accepts_nested_attributes_for :steps,
    allow_destroy: true,
    reject_if: :all_blank

  delegate :username, to: :user

  scope :latest, -> { order(created_at: :desc) }

  scope :search, -> (query:) {
    joins(:ingredients)
    .distinct
    .where("recipes.title LIKE ? OR ingredients.name LIKE ?", "%#{query}%", "%#{query}%") }
end
