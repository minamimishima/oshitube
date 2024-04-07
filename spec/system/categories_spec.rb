require 'rails_helper'

RSpec.describe "Categories", type: :system do
  context "ログインしている状態" do
    context "ユーザー自身のデータに関する処理" do
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
