require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { build(:bookmark) }

  describe "バリデーションの検証" do
    context "有効な場合" do
      it "URL・動画IDがあれば有効であること" do
        expect(bookmark).to be_valid
      end

      it "動画のメモが300文字以内であれば有効であること" do
        bookmark1 = build(:bookmark, description: "a" * 299)
        bookmark2 = build(:bookmark, description: "a" * 300)
        aggregate_failures do
          expect(bookmark1).to be_valid
          expect(bookmark2).to be_valid
        end
      end
    end

    context "無効な場合" do
      it "URLがなければ無効であること" do
        bookmark = build(:bookmark, url: nil)
        expect(bookmark).to be_invalid
      end

      it "動画のメモが300文字より長ければ無効であること" do
        bookmark = build(:bookmark, description: "a" * 301)
        expect(bookmark).to be_invalid
      end

      # allow_blankを設定したためvideo_idがnilの場合はエラーを返さないので「動画IDがなければ無効である」ことを確認するテストはなし
      # ただし、ブックマーク登録の際はvideo_idを直接入力せず、入力したURLを基にextract_video_idメソッドを使用してvideo_idを取得するため
      # video_idだけがnilになることはなく、テストを実施しなくても問題ないと思われます
    end
  end

  describe "インスタンスメソッドの検証" do
    let(:video_id) { "ABCDEFGHIJK" }
    describe "extract_video_urlの検証" do
      it "URLが正しい場合はURLをそのまま返すこと" do
        urls = [
          "https://www.youtube.com/watch?v=#{video_id}",
          "https://youtu.be/#{video_id}",
          "https://m.youtube.com/watch?v=#{video_id}",
          "https://www.youtube.com/embed/#{video_id}",
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
          "https://www.youtube.com/embed/#{video_id}extra_characters",
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
          "https://www.youtube.com/embed/#{video_id.chop}",
        ]
        aggregate_failures do
          urls.each do |url|
            expect(bookmark.extract_video_url(url)).to eq nil
          end
        end
      end

      it "正規表現と一致しないURLの場合はnilを返すこと" do
        url = Faker::Internet.url
        expect(bookmark.extract_video_url(url)).to eq nil
      end
    end

    describe "extract_video_idの検証" do
      it "URLが正しい場合は動画IDをそのまま返すこと" do
        urls = [
          "https://www.youtube.com/watch?v=#{video_id}",
          "https://youtu.be/#{video_id}",
          "https://m.youtube.com/watch?v=#{video_id}",
          "https://www.youtube.com/embed/#{video_id}",
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
          "https://www.youtube.com/embed/#{video_id}extra_characters",
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
          "https://www.youtube.com/embed/#{video_id.chop}",
        ]
        aggregate_failures do
          urls.each do |url|
            expect(bookmark.extract_video_id(url)).to eq nil
          end
        end
      end

      it "正規表現と一致しないURLの場合はnilを返すこと" do
        url = Faker::Internet.url
        expect(bookmark.extract_video_id(url)).to eq nil
      end
    end

    describe "calculate_start_timeの検証" do
      it "timestamps_attributesからstart_timeを計算して返すこと" do
        params = {
          url: "https://www.youtube.com/watch?v=#{video_id}",
          video_id: "#{video_id}",
          timestamps_attributes: {
            "0" => { hour: 1, minute: 1, second: 1 },
          },
        }
        new_params = bookmark.calculate_start_time(params)
        expect(new_params[:timestamps_attributes]["0"][:start_time]).to eq 3661
      end
    end
  end
end
