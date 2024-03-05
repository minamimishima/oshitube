class ChangeHourMinuteSecondDefaultToTimestamps < ActiveRecord::Migration[7.1]
  def change
    change_column_default :timestamps, :hour, from: nil, to: 0
    change_column_default :timestamps, :minute, from: nil, to: 0
    change_column_default :timestamps, :second, from: nil, to: 0
  end
end
