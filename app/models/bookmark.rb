class Bookmark < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  validates :video_id, length: { is: 11 }
  validates :description, length: { maximum: 300 }
end
