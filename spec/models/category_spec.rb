require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "バリデーションの検証" do
    context "有効な場合" do
      it "カテゴリー名がある場合は有効であること" do
        category = build(:category)
        expect(category).to be_valid
      end

      it "カテゴリー名が20文字以内であれば有効であること" do
        category1 = build(:category, name: "a" * 19)
        category2 = build(:category, name: "a" * 20)
        aggregate_failures do
          expect(category1).to be_valid
          expect(category2).to be_valid
        end
      end
    end

    context "無効な場合" do
      it "カテゴリー名がない場合は無効であること" do
        category = build(:category, name: nil)
        expect(category).to be_invalid
      end

      it "カテゴリー名が20文字より長ければ無効であること" do
        category = build(:category, name: "a" * 21)
        expect(category).to be_invalid
      end
    end
  end
end
