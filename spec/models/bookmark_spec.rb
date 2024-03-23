require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe "バリデーションの検証" do
    it "URL・動画IDがあれば有効であること" do
      bookmark = FactoryBot.build(:bookmark)
      expect(bookmark).to be_valid
    end

    it "URLがなければ無効であること" do
      bookmark = FactoryBot.build(:bookmark, url: nil)
      expect(bookmark).to be_invalid
    end

    it "動画IDがなければ無効であること" do
      bookmark = FactoryBot.build(:bookmark, video_id: nil)
      expect(bookmark).to be_invalid
    end

    it "動画IDが11文字より長ければ無効であること" do
      bookmark = FactoryBot.build(:bookmark, video_id: Faker::Alphanumeric.alphanumeric(number: 12))
      expect(bookmark).to be_invalid
    end

    it "動画IDが11文字より短ければ無効であること" do
      bookmark = FactoryBot.build(:bookmark, video_id: Faker::Alphanumeric.alphanumeric(number: 10))
      expect(bookmark).to be_invalid
    end

    it "動画のメモが300文字より長ければ無効であること" do
      bookmark = FactoryBot.build(:bookmark, description: "a" * 301)
      expect(bookmark).to be_invalid
    end

    it "動画のメモが300文字以内であれば有効であること" do
      bookmark = FactoryBot.build(:bookmark, description: "a" * 300)
      expect(bookmark).to be_valid
    end
  end
end
