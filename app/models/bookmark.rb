class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :category_bookmark, dependent: :destroy
  has_many :categories, through: :category_bookmark
  has_many :timestamps, dependent: :destroy

  accepts_nested_attributes_for :categories, reject_if: lambda { |attributes| attributes['name'].blank? }

  YOUTUBE_URL_PATTERN = /\A((?:https:\/\/www\.youtube\.com(?:\/embed\/|\/watch\?v=)|https:\/\/youtu\.be\/|https:\/\/m\.youtube\.com\/watch\?v=)([\w-]{11})).*\z/
  validates :url,
    presence: true,
    format: { with: YOUTUBE_URL_PATTERN, allow_blank: true }
  validates :video_id, length: { is: 11, allow_blank: true }
  validates :description, length: { maximum: 300 }

  scope :latest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }

  def self.ransackable_attributes(auth_object = nil) # rubocop:disable all
    ["description", "video_title"]
  end

  def self.ransackable_associations(auth_object = nil) # rubocop:disable all
    []
  end
  # ransackable_attributesにvideo_titleを追加するとActionView::Template::Errorが出てしまう
  # ransackable_associationsを定義するよう表示されていたため空配列で定義
  # キーワード引数にするとArgumentErrorが発生するため上記の記述にしてrubocopを無効化

  def set_new_params(params)
    new_params = params
    new_params[:url] = extract_video_url(params[:url])
    new_params[:video_id] = extract_video_id(params[:url])
    new_params
  end

  def extract_video_url(url)
    match = url&.match(YOUTUBE_URL_PATTERN)
    match ? match[1] : url
  end

  def extract_video_id(url)
    match = url&.match(YOUTUBE_URL_PATTERN)
    match ? match[2] : nil
  end
end
