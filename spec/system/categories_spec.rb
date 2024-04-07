require 'rails_helper'

RSpec.describe "Categories", type: :system do
  context "ログインしている状態" do
    context "ユーザー自身のデータに関する処理" do
      it "カテゴリーを作成できること" do
      end

      it "カテゴリーを表示できること" do
      end

      it "カテゴリー名を編集できること" do
      end

      it "カテゴリーを削除できること" do
      end

      it "ブックマーク作成時にカテゴリーを作成できること" do
      end

      it "ブックマーク作成時にカテゴリーを登録できること" do
      end

      it "ブックマーク編集時にカテゴリーを作成できること" do
      end

      it "ブックマーク編集時にカテゴリーを登録できること" do
      end

      it "ブックマーク編集時にカテゴリーを登録解除できること" do
      end
    end

    context "自分以外のユーザーのデータに関する処理" do
    end
  end

  context "ゲストユーザーとしてログインしている状態" do
    context "ゲストユーザー自身のデータに関する処理" do
    end

    context "ゲストユーザー以外のユーザーのデータに関する処理" do
    end
  end

  context "ログインしていない状態" do
  end
end
