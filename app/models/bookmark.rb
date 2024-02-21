class Bookmark < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :url
    validates :video_id
  end
  validates :description, length: { maximum: 300 }
end
