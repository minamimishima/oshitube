require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションの検証" do
    context "有効な場合" do
      it "メールアドレス・パスワード・名前があれば有効であること" do
        user = build(:user, profile: nil)
        expect(user).to be_valid
      end

      it "パスワードが8文字以上、30文字以下であれば有効であること" do
        user1 = build(:user, password: Faker::Internet.password(min_length: 8, max_length: 8))
        user2 = build(:user, password: Faker::Internet.password(min_length: 9, max_length: 29))
        user3 = build(:user, password: Faker::Internet.password(min_length: 30, max_length: 30))
        aggregate_failures do
          expect(user1). to be_valid
          expect(user2). to be_valid
          expect(user3). to be_valid
        end
      end

      it "プロフィールが300文字以内であれば有効であること" do
        user = build(:user, profile: "a" * 300)
        expect(user).to be_valid
      end

      it "アイコン画像の拡張子がjpg, jpeg, gif, pngであれば有効であること" do
        extensions = ["jpg", "jpeg", "gif", "png"]
        aggregate_failures do
          extensions.each do |ext|
            user = build(:user, icon: fixture_file_upload("spec/fixtures/test.#{ext}"))
            expect(user).to be_valid
          end
        end
      end
    end

    context "無効な場合" do
      it "メールアドレスがなければ無効であること" do
        user = build(:user, email: nil)
        expect(user).to be_invalid
      end

      it "パスワードがなければ無効であること" do
        user = build(:user, password: nil)
        expect(user).to be_invalid
      end

      it "パスワードが7文字以下であれば無効であること" do
        user = build(:user, password: Faker::Internet.password(min_length: 7, max_length: 7))
        expect(user).to be_invalid
      end

      it "パスワードが31文字以上であれば無効であること" do
        user = build(:user, password: Faker::Internet.password(min_length: 31, max_length: 31))
        expect(user).to be_invalid
      end

      it "名前がなければ無効であること" do
        user = build(:user, name: nil)
        expect(user).to be_invalid
      end

      it "プロフィールが300文字以上であれば無効であること" do
        user = build(:user, profile: "a" * 301)
        expect(user).to be_invalid
      end

      it "アイコン画像の拡張子がjpg, jpeg, gif, png以外であれば無効であること" do
        user = build(:user, icon: fixture_file_upload("spec/fixtures/test.bmp"))
        expect(user).to be_invalid
      end
    end
  end
end
