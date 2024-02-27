class Timestamp < ApplicationRecord
  belongs_to :bookmark

  validate :bookmark_has_ten_or_less_timestamps

  def bookmark_has_ten_or_less_timestamps
    if bookmark.timestamps.count >= 10
      errors.add(:base, "登録できるタイムスタンプは10件までです")
    end
  end
end
