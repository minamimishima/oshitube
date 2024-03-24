require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe "バリデーションの検証" do
    context "有効な場合" do
      it "URL・動画IDがあれば有効であること" do
        bookmark = build(:bookmark)
        expect(bookmark).to be_valid
      end

      it "動画のメモが300文字以内であれば有効であること" do
        bookmark = build(:bookmark, description: "a" * 300)
        expect(bookmark).to be_valid
      end
    end

    context "無効な場合" do
      it "URLがなければ無効であること" do
        bookmark = build(:bookmark, url: nil)
        expect(bookmark).to be_invalid
      end

      it "動画IDがなければ無効であること" do
        bookmark = build(:bookmark, video_id: nil)
        expect(bookmark).to be_invalid
      end

      it "動画のメモが300文字より長ければ無効であること" do
        bookmark = build(:bookmark, description: "a" * 301)
        expect(bookmark).to be_invalid
      end
    end
  end

  describe "インスタンスメソッドの検証" do
    context "extract_video_urlの検証" do
      context "通常のURLの場合" do
        it "通常のURLをそのまま返すこと" do
          bookmark = build(:bookmark)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq bookmark.url
        end

        it "動画IDの後に余分な文字列がある場合は削除してURLを返すこと" do
          bookmark = build(:bookmark_with_12_characters_video_id)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq bookmark.url.chop
        end

        it "動画IDが11桁より短い場合はnilを返すこと" do
          bookmark = build(:bookmark_with_10_characters_video_id)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq nil
        end
      end

      context "短縮URLの場合" do
        it "短縮URLをそのまま返すこと" do
          bookmark = build(:short_url_bookmark)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq bookmark.url
        end

        it "動画IDの後に余分な文字列がある場合は削除してURLを返すこと" do
          bookmark = build(:short_url_bookmark_with_12_characters_video_id)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq bookmark.url.chop
        end

        it "動画IDが11桁より短い場合はnilを返すこと" do
          bookmark = build(:short_url_bookmark_with_10_characters_video_id)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq nil
        end
      end

      context "モバイル版URLの場合" do
        it "モバイル版URLをそのまま返すこと" do
          bookmark = build(:mobile_url_bookmark)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq bookmark.url
        end

        it "動画IDの後に余分な文字列がある場合は削除してURLを返すこと" do
          bookmark = build(:mobile_url_bookmark_with_12_characters_video_id)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq bookmark.url.chop
        end

        it "動画IDが11桁より短い場合はnilを返すこと" do
          bookmark = build(:mobile_url_bookmark_with_10_characters_video_id)
          url = bookmark.extract_video_url(bookmark.url)
          expect(url).to eq nil
        end
      end
    end

    context "extract_video_idの検証" do
      context "通常のURLの場合" do
        it "通常のURLから動画IDが取得できること" do
          bookmark = build(:bookmark)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDの後に余分な文字列がある場合は削除して11桁の動画IDを取得できること" do
          bookmark = build(:bookmark_with_12_characters_video_id)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDが11桁より短い場合はnilを返すこと" do
          bookmark = build(:bookmark_with_10_characters_video_id)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq nil
        end
      end

      context "短縮URLの場合" do
        it "短縮URLから動画IDが取得できること" do
          bookmark = build(:short_url_bookmark)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDの後に余分な文字列がある場合は削除して11桁の動画IDを取得できること" do
          bookmark = build(:short_url_bookmark_with_12_characters_video_id)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDが11桁より短い場合はnilを返すこと" do
          bookmark = build(:short_url_bookmark_with_10_characters_video_id)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq nil
        end
      end

      context "モバイル版URLの場合" do
        it "モバイル版URLから動画IDが取得できること" do
          bookmark = build(:mobile_url_bookmark)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDの後に余分な文字列がある場合は削除して11桁の動画IDを取得できること" do
          bookmark = build(:mobile_url_bookmark_with_12_characters_video_id)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq bookmark.video_id
        end

        it "動画IDが11桁より短い場合はnilを返すこと" do
          bookmark = build(:mobile_url_bookmark_with_10_characters_video_id)
          video_id = bookmark.extract_video_id(bookmark.url)
          expect(video_id).to eq nil
        end
      end
    end
  end
end
