require 'rails_helper'

RSpec.describe Timestamp, type: :model do
  let(:bookmark) { create(:bookmark) }

  describe "バリデーションの検証" do
    it "既存のタイムスタンプが9件以下の場合正常に登録できること" do
      create_list(:timestamp, 9, bookmark: bookmark)
      timestamp = build(:timestamp, hour: 1, minute: 1, second: 1, bookmark_id: bookmark.id)
      expect(timestamp).to be_valid
    end

    it "既存のタイムスタンプが10件存在する場合は登録できないこと" do
      create_list(:timestamp, 10, bookmark: bookmark)
      timestamp = build(:timestamp, hour: 1, minute: 1, second: 1, bookmark_id: bookmark.id)
      expect(timestamp).to be_invalid
    end

    it "動画の長さ以内の時間であればタイムスタンプを作成できること" do
      bookmark = create(:bookmark, duration: 60)
      timestamp1 = build(:timestamp, hour: 0, minute: 1, second: 0, start_time: 60, bookmark_id: bookmark.id)
      timestamp2 = build(:timestamp, hour: 0, minute: 0, second: 59, start_time: 59, bookmark_id: bookmark.id)
      aggregate_failures do
        expect(timestamp1).to be_valid
        expect(timestamp2).to be_valid
      end
    end

    it "動画の長さを超える時間のタイムスタンプは作成できないこと" do
      bookmark = create(:bookmark, duration: 60)
      timestamp = build(:timestamp, hour: 0, minute: 1, second: 1, start_time: 61, bookmark_id: bookmark.id)
      expect(timestamp).to be_invalid
    end
  end

  describe "インスタンスメソッドの検証" do
    describe "calculate_start_timeの検証" do
      it "hour, minute, secondの値からstart_timeを正しく計算できること" do
        timestamp = build(:timestamp)
        timestamp_params = { hour: 1, minute: 1, second: 1 }
        expect(timestamp.calculate_start_time(timestamp_params)).to eq 3661
      end
    end
  end
end
