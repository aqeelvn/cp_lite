class FeedItem < ApplicationRecord
  belongs_to :user
  belongs_to :user_activity
end
