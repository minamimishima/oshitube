class Bookmark < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  validates :description, length: { maximum: 300 }
end
