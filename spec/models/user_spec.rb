require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  let(:user_with_no_name) { FactoryBot.build(:user, name: nil) }
  let(:user_with_over_300_characters_profile) { FactoryBot.build(:user, profile: "a" * 301) }
  let(:user_with_300_charactets_profile) { FactoryBot.build(:user, profile: "a" * 300) }

  describe "バリデーションの検証" do
    it "メールアドレス・パスワード・名前があれば有効であること" do
      expect(user).to be_valid
    end

    it "名前がなければ無効であること" do
      expect(user_with_no_name).to be_invalid
    end

    it "プロフィールが300文字より長ければ無効であること" do
      expect(user_with_over_300_characters_profile).to be_invalid
    end

    it "プロフィールが300文字以内であれば有効であること" do
      expect(user_with_300_charactets_profile).to be_valid
    end
  end
end
