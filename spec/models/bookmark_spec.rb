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
    describe "extract_video_urlの検証" do
      context "動画IDが11桁の場合" do
        let(:video_id_params) { Faker::Alphanumeric.alphanumeric(number: 11) }
        it "通常のURLの場合はURLをそのまま返すこと" do
          extracted_url = bookmark.extract_video_url("https://www.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_url).to eq "https://www.youtube.com/watch?v=#{video_id_params}"
        end

        it "短縮URLの場合はURLをそのまま返すこと" do
          extracted_url = bookmark.extract_video_url("https://youtu.be/#{video_id_params}")
          expect(extracted_url).to eq "https://youtu.be/#{video_id_params}"
        end

        it "モバイル版URLの場合はURLをそのまま返すこと" do
          extracted_url = bookmark.extract_video_url("https://m.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_url).to eq "https://m.youtube.com/watch?v=#{video_id_params}"
        end
      end

      context "動画URLのあとに余分な文字列がある場合" do
        let(:video_id_params) { Faker::Alphanumeric.alphanumeric(number: 12) }
        it "通常のURLの場合は余分な文字列を削除してURLを返すこと" do
          extracted_url = bookmark.extract_video_url("https://www.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_url).to eq "https://www.youtube.com/watch?v=#{video_id_params}".chop
        end

        it "短縮URLの場合は余分な文字列を削除してURLを返すこと" do
          extracted_url = bookmark.extract_video_url("https://youtu.be/#{video_id_params}")
          expect(extracted_url).to eq "https://youtu.be/#{video_id_params}".chop
        end

        it "モバイル版URLの場合は余分な文字列を削除してURLを返すこと" do
          extracted_url = bookmark.extract_video_url("https://m.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_url).to eq "https://m.youtube.com/watch?v=#{video_id_params}".chop
        end
      end

      context "動画IDが11桁より短い場合" do
        let(:video_id_params) { Faker::Alphanumeric.alphanumeric(number: 10) }
        it "通常URLの場合はnilを返すこと" do
          extracted_url = bookmark.extract_video_url("https://www.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_url).to eq nil
        end

        it "短縮URLの場合はnilを返すこと" do
          extracted_url = bookmark.extract_video_url("https://youtu.be/#{video_id_params}")
          expect(extracted_url).to eq nil
        end

        it "モバイル版URLの場合はnilを返すこと" do
          extracted_url = bookmark.extract_video_url("https://m.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_url).to eq nil
        end
      end
    end

    describe "extract_video_idの検証" do
      context "動画IDが11桁の場合" do
        let(:video_id_params) { Faker::Alphanumeric.alphanumeric(number: 11) }
        it "通常のURLの場合は動画IDを取得できること" do
          extracted_video_id = bookmark.extract_video_id("https://www.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_video_id).to eq video_id_params
        end

        it "短縮URLの場合は動画IDを取得できること" do
          extracted_video_id = bookmark.extract_video_id("https://youtu.be/#{video_id_params}")
          expect(extracted_video_id).to eq video_id_params
        end

        it "モバイル版URLの場合は動画IDを取得できること" do
          extracted_video_id = bookmark.extract_video_id("https://m.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_video_id).to eq video_id_params
        end
      end

      context "動画URLのあとに余分な文字列がある場合" do
        let(:video_id_params) { Faker::Alphanumeric.alphanumeric(number: 12) }
        it "通常のURLの場合は削除して11桁の動画IDを返すこと" do
          extracted_video_id = bookmark.extract_video_id("https://www.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_video_id).to eq video_id_params.chop
        end

        it "短縮URLの場合は削除して11桁の動画IDを返すこと" do
          extracted_video_id = bookmark.extract_video_id("https://youtu.be/#{video_id_params}")
          expect(extracted_video_id).to eq video_id_params.chop
        end

        it "モバイル版URLの場合は削除して11桁の動画IDを返すこと" do
          extracted_video_id = bookmark.extract_video_id("https://m.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_video_id).to eq video_id_params.chop
        end
      end

      context "動画IDが11桁より短い場合" do
        let(:video_id_params) { Faker::Alphanumeric.alphanumeric(number: 10) }
        it "通常のURLの場合はnilを返すこと" do
          extracted_video_id = bookmark.extract_video_id("https://www.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_video_id).to eq nil
        end

        it "短縮URLの場合はnilを返すこと" do
          extracted_video_id = bookmark.extract_video_id("https://youtu.be/#{video_id_params}")
          expect(extracted_video_id).to eq nil
        end

        it "モバイル版URLの場合はnilを返すこと" do
          extracted_video_id = bookmark.extract_video_id("https://m.youtube.com/watch?v=#{video_id_params}")
          expect(extracted_video_id).to eq nil
        end
      end
    end
  end
end
