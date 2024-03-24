require 'rails_helper'

RSpec.describe Timestamp, type: :model do
  let(:bookmark) { create(:bookmark) }

  describe "バリデーションの検証" do
    context "bookmark_has_ten_or_less_timestamps_create/updateの検証" do
      it "既存のタイムスタンプが9件以下の場合正常に登録できること" do
        create_list(:timestamp, 9, bookmark: bookmark)
        timestamp = build(:timestamp, bookmark_id: bookmark.id)
        expect(timestamp).to be_valid
      end

      it "既存のタイムスタンプが10件存在する場合は登録できないこと" do
        create_list(:timestamp, 10, bookmark: bookmark)
        timestamp = build(:timestamp, bookmark_id: bookmark.id)
        expect(timestamp).to be_invalid
      end
    end

    context "インスタンスメソッドの検証" do
      it "calculate_start_timeの検証" do
        timestamp = build(:timestamp, bookmark: bookmark)
        expect(timestamp.calculate_start_time).to eq 3661
      end
    end
  end
end
