require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "バリデーションの検証" do
    it "カテゴリー名があれば有効であること" do
      category = build(:category)
      expect(category).to be_valid
    end

    it "カテゴリー名がない場合は無効であること" do
      category = build(:category, name: nil)
      expect(category).to be_invalid
    end
  end
end
