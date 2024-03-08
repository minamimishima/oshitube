class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :timestamps, dependent: :destroy
  has_many :category_bookmark, dependent: :destroy
  has_many :categories, through: :category_bookmark
  accepts_nested_attributes_for :timestamps, allow_destroy: true
  accepts_nested_attributes_for :categories

  validates :url, presence: true
  validates :video_id, length: { is: 11 }
  validates :description, length: { maximum: 300 }

  VIDEO_ID_PATTERN = /((?:https:\/\/www\.youtube\.com(?:\/embed\/|\/watch\?v=)|https:\/\/youtu\.be\/|https:\/\/m\.youtube\.com\/watch\?v=)([\w-]{11}))/

  def extract_video_url(url)
    match = url.match(VIDEO_ID_PATTERN)
    match ? match[1] : nil
  end

  def extract_video_id(url)
    match = url.match(VIDEO_ID_PATTERN)
    match ? match[2] : nil
  end
end
