class Timestamp < ApplicationRecord
  belongs_to :bookmark

  with_options numericality: { greater_than_or_equal_to: 0 } do
    validates :hour
    validates :minute
    validates :second
  end
  validates :comment, length: { maximum: 150 }
  validates :start_time, uniqueness: { scope: :bookmark_id, message: "指定した時間のタイムスタンプはすでに登録されています" } # rubocop:disable Rails/UniqueValidationWithoutIndex
  validate :bookmark_has_ten_or_less_timestamps_create, on: :create
  validate :bookmark_has_ten_or_less_timestamps_update, on: :update
  validate :start_time_within_duration

  def calculate_start_time(params)
    params[:start_time] =
      params[:hour].to_i * 3600 +
      params[:minute].to_i * 60 +
      params[:second].to_i
  end

  private

  def bookmark_has_ten_or_less_timestamps_create
    if bookmark.timestamps.count >= 10
      errors.add(:base, "登録できるタイムスタンプは10件までです")
    end
  end

  def bookmark_has_ten_or_less_timestamps_update
    if bookmark.timestamps.count > 10
      errors.add(:base, "登録できるタイムスタンプは10件までです")
    end
  end
  # タイムスタンプの数が10件より多い場合をエラーとするとcreateの際に11件目のタイムスタンプが作成できてしまうため、
  # createとupdateでバリデーションメソッドを分けて設定

  def start_time_within_duration
    if start_time > bookmark.duration
      errors.add(:base, "動画の終了時間より後の時間にタイムスタンプは作成できません")
    end
  end
end
