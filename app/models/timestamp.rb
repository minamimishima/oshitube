class Timestamp < ApplicationRecord
  belongs_to :bookmark

  with_options numericality: { greater_than_or_equal_to: 0 } do
    validates :hour
    validates :minute
    validates :second
  end
  validate :bookmark_has_ten_or_less_timestamps

  def bookmark_has_ten_or_less_timestamps
    if bookmark.timestamps.count > 10
      errors.add(:base, "登録できるタイムスタンプは10件までです")
    end
  end
end
