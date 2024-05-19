require 'rails_helper'

RSpec.describe "Timestamps", type: :system do
  let(:bookmark) { create(:bookmark, is_public: true) }

  it "タイムスタンプが正常に作動すること", js: true do
    create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
    visit bookmark_path(bookmark)
    find("#timestamp-0").click
    video = find(".youtube-video-player")
    expect(video['src']).to include "3661"
  end

  context "ログインしている状態" do
    let(:user) { bookmark.user }

    before do
      login_as(user, :scope => :user)
    end

    context "ユーザー自身のデータに関する処理" do
      it "ブックマークの詳細ページにタイムスタンプ登録フォームが表示されること" do
        visit bookmark_path(bookmark)
        expect(page).to have_selector ".timestamps-new"
      end

      it "タイムスタンプを作成できること" do
        expect do
          visit bookmark_path(bookmark)
          fill_in "時間", with: 0
          fill_in "分", with: 0
          fill_in "秒", with: 0
          fill_in "メモ", with: "タイムスタンプ作成"
          click_on "登録"
        end.to change { bookmark.timestamps.count }.by(1)
      end

      it "タイムスタンプが表示されること" do
        create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
        visit bookmark_path(bookmark)
        expect(page).to have_selector "#timestamp-0"
      end

      it "タイムスタンプを編集できること" do
        timestamp = create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
        visit bookmark_path(bookmark)
        within ".timestamps-table-0" do
          find(".timestamp__edit-link").click
        end
        within ".timestamps-edit" do
          fill_in "時間", with: 2
          fill_in "分", with: 2
          fill_in "秒", with: 2
          click_on "登録"
        end
        aggregate_failures do
          expect(timestamp.reload.hour).to eq 2
          expect(timestamp.reload.minute).to eq 2
          expect(timestamp.reload.second).to eq 2
          expect(timestamp.reload.start_time).to eq 7322
        end
      end

      it "タイムスタンプを削除できること", js: true do
        create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
        expect do
          visit bookmark_path(bookmark)
          within ".timestamps-table-0" do
            page.accept_confirm do
              find("i[aria-label='タイムスタンプの削除']").click
            end
          end
          find ".notice", text: "タイムスタンプを削除しました"
        end.to change { bookmark.timestamps.count }.by(-1)
      end
    end

    context "自分以外のユーザーのデータに関する処理" do
      let(:user) { create(:user) }

      before do
        login_as(user, :scope => :user)
      end

      it "ブックマークの詳細ページにタイムスタンプ登録フォームが表示されないこと" do
        visit bookmark_path(bookmark)
        expect(page).to_not have_selector ".timestamps-new"
      end

      it "タイムスタンプが表示されること" do
        create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
        visit bookmark_path(bookmark)
        expect(page).to have_selector "#timestamp-0"
      end

      it "タイムスタンプの編集リンクが表示されないこと" do
        create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
        visit bookmark_path(bookmark)
        expect(page).to_not have_content "編集"
      end

      it "タイムスタンプの削除リンクが表示されないこと" do
        create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
        visit bookmark_path(bookmark)
        expect(page).to_not have_content "削除"
      end
    end
  end

  context "ログインしていない状態" do
    it "ブックマークの詳細ページにタイムスタンプ登録フォームが表示されないこと" do
      visit bookmark_path(bookmark)
      expect(page).to_not have_selector ".timestamps-new"
    end

    it "タイムスタンプが表示されること" do
      create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
      visit bookmark_path(bookmark)
      expect(page).to have_selector "#timestamp-0"
    end

    it "タイムスタンプの編集リンクが表示されないこと" do
      create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
      visit bookmark_path(bookmark)
      expect(page).to_not have_content "編集"
    end

    it "タイムスタンプの削除リンクが表示されないこと" do
      create(:timestamp, hour: 1, minute: 1, second: 1, start_time: 3661, bookmark: bookmark)
      visit bookmark_path(bookmark)
      expect(page).to_not have_content "削除"
    end
  end
end
