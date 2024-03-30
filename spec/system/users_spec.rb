require 'rails_helper'

RSpec.describe "Users", type: :system do
  it "新規登録する" do
    user = build(:user)
    visit new_user_registration_path
    fill_in "名前", with: user.name
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    fill_in "パスワード（確認）", with: user.password
    click_button "登録"
    expect(page).to have_selector ".notice", text: "アカウント登録が完了しました。"
  end

  it "退会する" do
  end

  it "ログインする" do
  end

  it "ログアウトする" do
  end

  it "プロフィールを表示する" do
  end

  it "プロフィールを編集する" do
  end

  it "ゲストユーザーのプロフィールは編集できないこと" do
  end

  it "ゲストユーザーは退会できないこと" do
  end
end
