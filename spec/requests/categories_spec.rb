require 'rails_helper'

RSpec.describe "Categories", type: :request do
  context "ログインしている状態" do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:other_user) { category.user }

    before do
      sign_in user
    end

    it "他のユーザーのデータとしてカテゴリーを作成できないこと" do
      category_params = {
        :user_id => other_user.id,
        :name => "新しいカテゴリー",
      }
      expect do
        post categories_path, params: { category: category_params }
      end.to change { other_user.categories.count }.by(0)
    end

    it "他のユーザーのカテゴリー名は編集できないこと" do
      category_params = {
        :user_id => other_user.id,
        :name => "新しいカテゴリー名",
      }
      patch category_path(category), params: { category: category_params }
      expect(category.reload.name).to_not eq "新しいカテゴリー名"
    end

    it "他のユーザーのカテゴリーを削除できないこと" do
      expect do
        delete category_path(category)
      end.to change { other_user.categories.count }.by(0)
    end
  end

  context "ログインしていない状態" do
    let(:category) { create(:category) }
    let(:user) { category.user }

    it "他のユーザーのデータとしてカテゴリーを作成できないこと" do
      category_params = {
        :user_id => user.id,
        :name => "新しいカテゴリー",
      }
      expect do
        post categories_path, params: { category: category_params }
      end.to change { user.categories.count }.by(0)
    end

    it "他のユーザーのカテゴリー名は編集できないこと" do
      category_params = {
        :user_id => user.id,
        :name => "新しいカテゴリー名",
      }
      patch category_path(category), params: { category: category_params }
      expect(category.reload.name).to_not eq "新しいカテゴリー名"
    end

    it "他のユーザーのカテゴリーを削除できないこと" do
      expect do
        delete category_path(category)
      end.to change { user.categories.count }.by(0)
    end
  end
end
