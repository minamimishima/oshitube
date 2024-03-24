require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe "バリデーションの検証" do
    context "有効な場合" do
      it "URL・動画IDがあれば有効であること" do
        bookmark = FactoryBot.build(:bookmark)
        expect(bookmark).to be_valid
      end

      it "動画のメモが300文字以内であれば有効であること" do
        bookmark = FactoryBot.build(:bookmark, description: "a" * 300)
        expect(bookmark).to be_valid
      end
    end

    context "無効な場合" do
      it "URLがなければ無効であること" do
        bookmark = FactoryBot.build(:bookmark, url: nil)
        expect(bookmark).to be_invalid
      end

      it "動画IDがなければ無効であること" do
        bookmark = FactoryBot.build(:bookmark, video_id: nil)
        expect(bookmark).to be_invalid
      end

      it "動画のメモが300文字より長ければ無効であること" do
        bookmark = FactoryBot.build(:bookmark, description: "a" * 301)
        expect(bookmark).to be_invalid
      end
    end
  end

  describe "インスタンスメソッドの検証" do
    context "extract_video_idの検証" do
      context "通常のURLの場合" do
        it "通常のURLから動画IDが取得できること" do
          bookmark = FactoryBot.build(:bookmark)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDの後に余分な文字列があっても11桁の動画IDを取得できること" do
          bookmark = FactoryBot.build(:bookmark, :video_id_with_12_characters)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDが11桁より短ければnilを返すこと" do
          bookmark = FactoryBot.build(:bookmark, :video_id_with_10_characters)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq nil
        end
      end

      context "短縮URLの場合" do
        it "短縮URLから動画IDが取得できること" do
          bookmark = FactoryBot.build(:bookmark_with_short_url)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDの後に余分な文字列があっても11桁の動画IDを取得できること" do
          bookmark = FactoryBot.build(:bookmark_with_short_url, :video_id_with_12_characters)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDが11桁より短ければnilを返すこと" do
          bookmark = FactoryBot.build(:bookmark_with_short_url, :video_id_with_10_characters)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq nil
        end
      end

      context "モバイル版URLの場合" do
        it "モバイル版URLから動画IDが取得できること" do
          bookmark = FactoryBot.build(:bookmark_with_mobile_url)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDの後に余分な文字列があっても11桁の動画IDを取得できること" do
          bookmark = FactoryBot.build(:bookmark_with_mobile_url, :video_id_with_12_characters)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDが11桁より短ければnilを返すこと" do
          bookmark = FactoryBot.build(:bookmark_with_mobile_url, :video_id_with_10_characters)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq nil
        end
      end
    end
  end
end
