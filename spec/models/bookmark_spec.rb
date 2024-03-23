require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:bookmark) { FactoryBot.build(:bookmark, user_id: user.id) }

  let(:bookmark_with_no_url) { FactoryBot.build(:bookmark, user_id: user.id, url: nil) }
  let(:bookmark_with_no_video_id) { FactoryBot.build(:bookmark, user_id: user.id, video_id: nil) }

  let(:bookmark_with_over_11_characters_video_id) { FactoryBot.build(:bookmark, user_id: user.id, video_id: "ABCDEFGHIJKL") }
  let(:bookmark_with_under_11_characters_video_id) { FactoryBot.build(:bookmark, user_id: user.id, video_id: "ABCDEFGHIJ") }

  let(:bookmark_with_over_300_characters_description) { FactoryBot.build(:bookmark, user_id: user.id, description: "a" * 301) }
  let(:bookmark_with_300_characters_description) { FactoryBot.build(:bookmark, user_id: user.id, description: "a" * 300) }

  describe "バリデーションの検証" do
    it "URL・動画IDがあれば有効であること" do
      expect(user).to be_valid
    end

    it "URLがなければ無効であること" do
      expect(bookmark_with_no_url).to be_invalid
    end

    it "動画IDがなければ無効であること" do
      expect(bookmark_with_no_video_id).to be_invalid
    end

    it "動画IDが11文字より長ければ無効であること" do
      expect(bookmark_with_over_11_characters_video_id).to be_invalid
    end

    it "動画IDが11文字より短ければ無効であること" do
      expect(bookmark_with_under_11_characters_video_id).to be_invalid
    end

    it "動画のメモが300文字より長ければ無効であること" do
      expect(bookmark_with_over_300_characters_description).to be_invalid
    end

    it "動画のメモが300文字以内であれば有効であること" do
      expect(bookmark_with_300_characters_description).to be_valid
    end
  end
end
