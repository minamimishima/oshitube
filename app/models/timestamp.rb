class Timestamp < ApplicationRecord
  belongs_to :bookmark

  with_options numericality: { greater_than_or_equal_to: 0 } do
    validates :hour
    validates :minute
    validates :second
  end
  validates :comment, length: { maximum: 150 }
  validate :bookmark_has_ten_or_less_timestamps_create, on: :create
  validate :bookmark_has_ten_or_less_timestamps_update, on: :update

  def calculate_start_time
    hour * 3600 + minute * 60 + second
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
end
