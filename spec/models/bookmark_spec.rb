require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { create(:bookmark) }

  describe "バリデーションの検証" do
    context "有効な場合" do
      it "URL・動画IDがあれば有効であること" do
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
    let(:video_id) { Faker::Alphanumeric.alphanumeric(number: 11) }
    describe "extract_video_urlの検証" do
      it "URLが正しい場合はURLをそのまま返すこと" do
        urls = [
          "https://www.youtube.com/watch?v=#{video_id}",
          "https://youtu.be/#{video_id}",
          "https://m.youtube.com/watch?v=#{video_id}",
        ]
        aggregate_failures do
          urls.each do |url|
            expect(bookmark.extract_video_url(url)).to eq url
          end
        end
      end

      it "動画URLの末尾に余分な文字列がある場合は削除してURLを返すこと" do
        urls = [
          "https://www.youtube.com/watch?v=#{video_id}extra_characters",
          "https://youtu.be/#{video_id}extra_characters",
          "https://m.youtube.com/watch?v=#{video_id}extra_characters",
        ]
        aggregate_failures do
          urls.each do |url|
            expect(bookmark.extract_video_url(url)).to eq url.gsub(/extra_characters/, "")
          end
        end
      end

      it "動画URLの動画ID部分が11桁より短い場合はnilを返すこと" do
        urls = [
          "https://www.youtube.com/watch?v=#{video_id.chop}",
          "https://youtu.be/#{video_id.chop}",
          "https://m.youtube.com/watch?v=#{video_id.chop}",
        ]
        aggregate_failures do
          urls.each do |url|
            expect(bookmark.extract_video_url(url)).to eq nil
          end
        end
      end
    end

    describe "extract_video_idの検証" do
      it "URLが正しい場合は動画IDをそのまま返すこと" do
        urls = [
          "https://www.youtube.com/watch?v=#{video_id}",
          "https://youtu.be/#{video_id}",
          "https://m.youtube.com/watch?v=#{video_id}",
        ]
        aggregate_failures do
          urls.each do |url|
            expect(bookmark.extract_video_id(url)).to eq video_id
          end
        end
      end

      it "動画URLの末尾に余分な文字列がある場合は削除して動画IDを返すこと" do
        urls = [
          "https://www.youtube.com/watch?v=#{video_id}extra_characters",
          "https://youtu.be/#{video_id}extra_characters",
          "https://m.youtube.com/watch?v=#{video_id}extra_characters",
        ]
        aggregate_failures do
          urls.each do |url|
            expect(bookmark.extract_video_id(url)).to eq video_id.gsub(/extra_characters/, "")
          end
        end
      end

      it "動画URLの動画ID部分が11桁より短い場合はnilを返すこと" do
        urls = [
          "https://www.youtube.com/watch?v=#{video_id.chop}",
          "https://youtu.be/#{video_id.chop}",
          "https://m.youtube.com/watch?v=#{video_id.chop}",
        ]
        aggregate_failures do
          urls.each do |url|
            expect(bookmark.extract_video_id(url)).to eq nil
          end
        end
      end
    end
  end
end
