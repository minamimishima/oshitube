class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :timestamps

  validates :url, presence: true
  validates :video_id, length: { is: 11 }
  validates :description, length: { maximum: 300 }

  VIDEO_ID_PATTERN = /((?:https:\/\/www\.youtube\.com(?:\/embed\/|\/watch\?v=)|https:\/\/youtu\.be\/|https:\/\/m\.youtube\.com\/watch\?v=)([\w-]{11}))/

  def extract_video_url(url)
    match = url.match(VIDEO_ID_PATTERN)
    match ? self.url = match[1] : self.url = nil
  end

  def extract_video_id(url)
    match = url.match(VIDEO_ID_PATTERN)
    match ? self.video_id = match[2] : self.url = nil
  end
end
