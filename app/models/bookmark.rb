class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :category_bookmark, dependent: :destroy
  has_many :categories, through: :category_bookmark
  has_many :timestamps, dependent: :destroy

  accepts_nested_attributes_for :timestamps, allow_destroy: true
  accepts_nested_attributes_for :categories, reject_if: lambda { |attributes| attributes['name'].blank? }

  validates :url, presence: true
  validates :video_id, length: { is: 11 }
  validates :description, length: { maximum: 300 }

  VIDEO_ID_PATTERN = /((?:https:\/\/www\.youtube\.com(?:\/embed\/|\/watch\?v=)|https:\/\/youtu\.be\/|https:\/\/m\.youtube\.com\/watch\?v=)([\w-]{11}))/

  def set_new_params(params)
    new_params = params
    new_params[:url] = extract_video_url(params[:url])
    new_params[:video_id] = extract_video_id(params[:url])

    if new_params[:timestamps_attributes].present?
      (0..9).each do |i|
        if new_params[:timestamps_attributes][i.to_s].present?
          new_params[:timestamps_attributes][i.to_s][:start_time] =
            new_params[:timestamps_attributes][i.to_s][:hour].to_i * 3600 +
            new_params[:timestamps_attributes][i.to_s][:minute].to_i * 60 +
            new_params[:timestamps_attributes][i.to_s][:second].to_i
        end
      end
    end
    new_params
  end

  def extract_video_url(url)
    match = url.match(VIDEO_ID_PATTERN)
    match ? match[1] : nil
  end

  def extract_video_id(url)
    match = url&.match(VIDEO_ID_PATTERN)
    match ? match[2] : nil
  end
end
