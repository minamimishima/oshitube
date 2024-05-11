class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :category_bookmark, dependent: :destroy
  has_many :categories, through: :category_bookmark
  has_many :timestamps, dependent: :destroy

  accepts_nested_attributes_for :categories, reject_if: lambda { |attributes| attributes['name'].blank? }

  validates :url, presence: true
  validates :video_id, length: { is: 11, allow_blank: true }
  validates :description, length: { maximum: 300 }

  YOUTUBE_URL_PATTERN = /((?:https:\/\/www\.youtube\.com(?:\/embed\/|\/watch\?v=)|https:\/\/youtu\.be\/|https:\/\/m\.youtube\.com\/watch\?v=)([\w-]{11}))/

  def set_new_params(params)
    new_params = params
    new_params[:url] = extract_video_url(params[:url])
    new_params[:video_id] = extract_video_id(params[:url])
    new_params
  end

  def extract_video_url(url)
    match = url&.match(YOUTUBE_URL_PATTERN)
    match ? match[1] : nil
  end

  def extract_video_id(url)
    match = url&.match(YOUTUBE_URL_PATTERN)
    match ? match[2] : nil
  end
end
