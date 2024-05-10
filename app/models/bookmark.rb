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
    calculate_start_time(params)
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

  def calculate_start_time(params)
    if params[:timestamps_attributes].present?
      (0..9).each do |i|
        if params[:timestamps_attributes][i.to_s].present?
          params[:timestamps_attributes][i.to_s][:start_time] =
            params[:timestamps_attributes][i.to_s][:hour].to_i * 3600 +
            params[:timestamps_attributes][i.to_s][:minute].to_i * 60 +
            params[:timestamps_attributes][i.to_s][:second].to_i
        end
      end
    end
    params
  end
end
