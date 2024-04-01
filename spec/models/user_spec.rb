require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションの検証" do
    context "有効な場合" do
      it "メールアドレス・パスワード・名前があれば有効であること" do
        user = build(:user, profile: nil)
        expect(user).to be_valid
      end

      it "プロフィールが300文字以内であれば有効であること" do
        user = build(:user, profile: "a" * 300)
        expect(user).to be_valid
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

      it "名前がなければ無効であること" do
        user = build(:user, name: nil)
        expect(user).to be_invalid
      end

      it "プロフィールが300文字より長ければ無効であること" do
        user = build(:user, profile: "a" * 301)
        expect(user).to be_invalid
      end
    end
  end
end
