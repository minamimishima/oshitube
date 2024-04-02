require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  context "ログインしている状態" do
    before do
      login_as(user, :scope => :user)
    end

    context "ユーザー自身に関する処理" do
      it "自分のプロフィールを表示できること" do
        visit user_path(user)
        aggregate_failures do
          expect(page).to have_content user.name
          expect(page).to have_content user.profile
        end
      end

      it "自分のプロフィールを編集できること" do
        user = create(:user, name: "元の名前", profile: "元のプロフィール")
        login_as(user, :scope => :user)
        visit user_path(user)
        click_on "プロフィール編集"
        fill_in "名前", with: "新しい名前"
        fill_in "プロフィール", with: "新しいプロフィール"
        attach_file "アイコン画像", "#{Rails.root}/spec/fixtures/test.png"
        click_on "変更"
        aggregate_failures do
          expect(user.reload.name).to eq "新しい名前"
          expect(user.reload.profile).to eq "新しいプロフィール"
          expect(user.reload.icon.filename.to_s).to eq "test.png"
        end
      end

      it "退会できること", js: true do
        visit users_confirm_path
        page.accept_confirm do
          click_on "退会する"
        end
        expect(page).to have_selector ".notice", text: "退会しました"
      end

      it "ログアウトできること" do
        visit root_path
        click_on "ログアウト"
        expect(page).to have_selector ".notice", text: "ログアウトしました。"
      end
    end

    context "自分以外のユーザーに関する処理" do
      it "自分以外のユーザーのプロフィールを表示できること" do
        other_user = create(:user)
        visit user_path(other_user)
        expect(page).to have_content other_user.name
      end

      it "自分以外のユーザーのプロフィール画面には編集ページへのリンクがないこと" do
        other_user = create(:user)
        visit user_path(other_user)
        expect(page).to_not have_content "プロフィール編集"
      end
    end
  end

  context "ゲストユーザーとしてログインしている状態" do
    before do
      visit root_path
      click_on "ゲストログイン"
    end

    it "ゲストユーザーのプロフィールを表示できること" do
      click_on "プロフィール"
      expect(page).to have_content "ゲスト"
    end

    it "ゲスト以外のユーザーのプロフィールを表示できること" do
      user = create(:user)
      visit user_path(user)
      expect(page).to have_content user.name
    end

    it "ゲストユーザーのプロフィールは編集できないこと" do
      click_on "プロフィール"
      click_on "プロフィール編集"
      fill_in "名前", with: "新しい名前"
      fill_in "プロフィール", with: "新しいプロフィール"
      click_on "変更"
      expect(page).to have_selector ".notice", text: "ゲストユーザーは編集できません"
    end

    it "ゲストユーザーは退会できないこと", js: true do
      click_on "メニュー"
      find "li", text: "プロフィール"
      click_on "プロフィール"
      click_on "ユーザー情報変更"
      click_on "退会する"
      visit users_confirm_path
      page.accept_confirm do
        click_on "退会する"
      end
      expect(page).to have_selector ".notice", text: "ゲストユーザーは退会できません"
    end
  end

  context "ログインしていない状態" do
    it "新規登録ができること" do
      user = build(:user)
      visit new_user_registration_path
      fill_in "名前", with: user.name
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      fill_in "パスワード（確認）", with: user.password
      click_button "登録"
      expect(page).to have_selector ".notice", text: "アカウント登録が完了しました。"
    end

    it "ログインできること" do
      visit user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      within ".actions" do
        click_on "ログイン"
      end
      expect(page).to have_selector ".notice", text: "ログインしました。"
    end

    it "ゲストユーザーとしてログインできること" do
      visit root_path
      click_on "ゲストログイン"
      expect(page).to have_selector ".notice", text: "ゲストユーザーとしてログインしました"
    end

    it "ユーザーのプロフィールを表示できること" do
      visit user_path(user)
      expect(page).to have_content user.name
    end

    it "退会済みのユーザーが元のメールアドレス・パスワードでログインできないこと" do
      user = create(:user, is_deleted: true)
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      within ".actions" do
        click_on "ログイン"
      end
      expect(page).to have_content "退会済みです。"
    end
  end
end
