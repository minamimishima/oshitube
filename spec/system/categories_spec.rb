require 'rails_helper'

RSpec.describe "Categories", type: :system do
  context "ログインしている状態" do
    context "ユーザー自身のデータに関する処理" do
      let(:category) { create(:category) }
      let(:user) { category.user }

      before do
        login_as(user, :scope => :user)
      end

      it "カテゴリーを作成できること" do
        visit bookmarks_path
        expect do
          fill_in "カテゴリー名", with: "新しいカテゴリー"
          click_on "作成"
        end.to change { user.categories.count }.by(1)
      end

      it "カテゴリーページを表示できること" do
        visit category_path(category)
        expect(current_path).to eq category_path(category)
      end

      it "カテゴリーに属するブックマークが表示されること" do
        bookmark = create(:bookmark)
        category.bookmarks << bookmark
        visit category_path(category)
        expect(page).to have_css ".bookmark-#{bookmark.id}"
      end

      it "カテゴリーに属さないブックマークは表示されないこと" do
        bookmark = create(:bookmark)
        visit category_path(category)
        expect(page).to_not have_css ".bookmark-#{bookmark.id}"
      end

      it "カテゴリー名を編集できること" do
        category = create(:category, name: "元のカテゴリー名", user: user)
        visit category_path(category)
        fill_in "カテゴリー名", with: "新しいカテゴリー名"
        click_on "編集"
        expect(page).to have_selector "h1", text: "新しいカテゴリー名"
      end

      it "カテゴリーを削除できること", js: true do
        expect do
          visit category_path(category)
          page.accept_confirm do
            click_on "削除"
          end
          find ".notice", text: "カテゴリーを削除しました"
        end.to change { user.categories.count }.by(-1)
      end

      it "ブックマーク作成時に新しいカテゴリーを作成できること" do
        expect do
          visit new_bookmark_path
          fill_in "URL", with: "https://www.youtube.com/watch?v=ABCDEFGHIJK"
          fill_in "動画メモ", with: "動画メモ"
          fill_in "カテゴリーを作成する", with: "新しいカテゴリー"
          click_on "登録"
        end.to change { user.categories.count }.by(1)
      end

      it "ブックマーク作成時に既存のカテゴリーの中から選んで登録できること" do
        expect do
          visit new_bookmark_path
          fill_in "URL", with: "https://www.youtube.com/watch?v=ABCDEFGHIJK"
          fill_in "動画メモ", with: "動画メモ"
          check category.name
          click_on "登録"
        end.to change { category.bookmarks.count }.by(1)
      end

      it "ブックマーク編集時に新しいカテゴリーを作成できること" do
        bookmark = create(:bookmark, user: user)
        expect do
          visit edit_bookmark_path(bookmark)
          fill_in "カテゴリーを作成する", with: "新しいカテゴリー"
          click_on "登録"
        end.to change { user.categories.count }.by(1)
      end

      it "ブックマーク編集時に既存のカテゴリーの中から選んで登録できること" do
        bookmark = create(:bookmark, user: user)
        visit edit_bookmark_path(bookmark)
        expect do
          check "bookmark_category_ids_#{category.id}"
          click_on "登録"
        end.to change { category.bookmarks.count }.by(1)
      end

      it "ブックマーク編集時にカテゴリーを登録解除できること" do
        bookmark = create(:bookmark, user: user)
        category.bookmarks << bookmark
        visit edit_bookmark_path(bookmark)
        expect do
          uncheck "bookmark_category_ids_#{category.id}"
          click_on "登録"
        end.to change { category.bookmarks.count }.by(-1)
      end
    end

    context "自分以外のユーザーのデータに関する処理" do
      let(:category) { create(:category) }
      let(:user) { create(:user) }

      before do
        login_as(user, :scope => :user)
      end

      it "他のユーザーのカテゴリーページは表示できないこと" do
        visit category_path(category)
        expect(current_path).to eq root_path
      end
    end
  end

  context "ログインしていない状態" do
    let(:category) { create(:category) }

    it "カテゴリーページは表示できないこと" do
      visit category_path(category)
      expect(current_path).to eq new_user_session_path
    end
  end
end
