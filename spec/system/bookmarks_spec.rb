require 'rails_helper'

RSpec.describe "Bookmarks", type: :system do
  let(:bookmark) { create(:bookmark, is_public: true) }

  it "ブックマーク詳細ページに動画フレーム・概要欄・動画タイトル・メモが表示されること" do
    visit bookmark_path(bookmark)
    aggregate_failures do
      expect(page).to have_selector ".youtube-video-player"
      expect(page).to have_selector ".bookmark-show__video-title"
      expect(page).to have_selector ".bookmark-show__video-description"
      expect(page).to have_content bookmark.description
    end
  end

  context "ログインしている状態" do
    context "ユーザー自身のデータに関する処理" do
      let(:bookmark) { create(:bookmark) }
      let(:user) { bookmark.user }

      before do
        login_as(user, :scope => :user)
      end

      it "ブックマーク作成ページが表示できること" do
        visit new_bookmark_path
        expect(page). to have_content "ブックマーク登録"
      end

      it "ブックマークが作成できること" do
        visit new_bookmark_path
        expect do
          fill_in "URL", with: "https://www.youtube.com/watch?v=ABCDEFGHIJK"
          fill_in "動画メモ", with: "動画についてのメモ"
          click_on "登録"
        end.to change { user.bookmarks.count }.by(1)
      end

      it "公開設定のブックマークが閲覧できること" do
        bookmark = create(:bookmark, is_public: true, user: user)
        visit bookmark_path(bookmark)
        expect(current_path).to eq bookmark_path(bookmark)
      end

      it "非公開設定のブックマークが閲覧できること" do
        bookmark = create(:bookmark, is_public: false, user: user)
        visit bookmark_path(bookmark)
        expect(current_path).to eq bookmark_path(bookmark)
      end

      it "ブックマーク一覧ページにサムネイル・動画タイトル・メモが表示されること" do
        visit bookmarks_path
        aggregate_failures do
          expect(page).to have_selector ".bookmark__video-thumbnail"
          expect(page).to have_selector ".bookmark__video-title"
          expect(page).to have_content bookmark.description
        end
      end

      it "編集ページへのリンクが表示されること" do
        visit bookmark_path(bookmark)
        expect(page).to have_content "ブックマーク編集"
      end

      it "編集ページが表示できること" do
        visit edit_bookmark_path(bookmark)
        aggregate_failures do
          expect(current_path).to eq edit_bookmark_path(bookmark)
          expect(page).to have_content "ブックマーク編集"
        end
      end

      it "ブックマークを編集できること" do
        bookmark = create(
          :bookmark,
          url: "https://www.youtube.com/watch?v=abcdefghijk",
          description: "元の動画メモ",
          user: user,
        )
        visit edit_bookmark_path(bookmark)
        fill_in "URL", with: "https://www.youtube.com/watch?v=ABCDEFGHIJK"
        fill_in "動画メモ", with: "新しい動画メモ"
        click_on "登録"
        aggregate_failures do
          expect(bookmark.reload.url).to eq "https://www.youtube.com/watch?v=ABCDEFGHIJK"
          expect(bookmark.reload.description).to eq "新しい動画メモ"
        end
      end

      it "削除リンクが表示されること" do
        visit bookmark_path(bookmark)
        expect(page).to have_content "ブックマーク削除"
      end

      it "ブックマークを削除できること", js: true do
        expect do
          visit bookmark_path(bookmark)
          page.accept_confirm do
            click_on "ブックマーク削除"
          end
          find ".notice", text: "ブックマークを削除しました"
        end.to change { user.bookmarks.count }.by(-1)
      end
    end

    context "自分以外のユーザーのデータに関する処理" do
      let(:bookmark) { create(:bookmark, is_public: true) }
      let(:other_user) { bookmark.user }
      let(:user) { create(:user) }

      before do
        login_as(user, :scope => :user)
      end

      it "公開設定のブックマークが閲覧できること" do
        visit bookmark_path(bookmark)
        expect(current_path).to eq bookmark_path(bookmark)
      end

      it "非公開設定のブックマークは閲覧できないこと" do
        bookmark = create(:bookmark, is_public: false)
        visit bookmark_path(bookmark)
        expect(current_path).to eq root_path
      end

      it "編集ページへのリンクが表示されないこと" do
        visit bookmark_path(bookmark)
        expect(page).to_not have_content "編集"
      end

      it "編集ページは表示できないこと" do
        visit edit_bookmark_path(bookmark)
        expect(current_path).to eq root_path
      end

      it "削除リンクが表示されないこと" do
        visit bookmark_path(bookmark)
        expect(page).to_not have_content "削除"
      end
    end
  end

  context "ログインしていない状態" do
    let(:bookmark) { create(:bookmark, is_public: true) }

    it "公開設定のブックマークが閲覧できること" do
      visit bookmark_path(bookmark)
      expect(current_path).to eq bookmark_path(bookmark)
    end

    it "非公開設定のブックマークは閲覧できないこと" do
      bookmark = create(:bookmark, is_public: false)
      visit bookmark_path(bookmark)
      expect(current_path).to eq root_path
    end

    it "編集ページへのリンクが表示されないこと" do
      visit bookmark_path(bookmark)
      expect(page).to_not have_content "編集"
    end

    it "編集ページは表示できないこと" do
      visit edit_bookmark_path(bookmark)
      expect(current_path).to eq new_user_session_path
    end

    it "削除リンクが表示されないこと" do
      visit bookmark_path(bookmark)
      expect(page).to_not have_content "削除"
    end
  end
end
