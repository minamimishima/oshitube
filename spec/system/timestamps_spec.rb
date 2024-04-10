require 'rails_helper'

RSpec.describe "Timestamps", type: :system do
  let(:bookmark) { create(:bookmark, is_public: true) }
  let!(:timestamp) { create(:timestamp, bookmark: bookmark) }

  it "タイムスタンプが正常に作動すること", js: true do
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
        visit bookmark_path(bookmark)
        expect(page).to have_selector "#timestamp-0"
      end

      it "タイムスタンプを編集できること" do
        visit edit_bookmark_path(bookmark)
        find("#bookmark_timestamps_attributes_0_hour").fill_in with: 0
        find("#bookmark_timestamps_attributes_0_minute").fill_in with: 0
        find("#bookmark_timestamps_attributes_0_second").fill_in with: 0
        click_on "登録"
        aggregate_failures do
          expect(bookmark.timestamps[0].reload.hour).to eq 0
          expect(bookmark.timestamps[0].reload.minute).to eq 0
          expect(bookmark.timestamps[0].reload.second).to eq 0
        end
      end

      it "タイムスタンプを削除できること" do
        expect do
          visit edit_bookmark_path(bookmark)
          find("#bookmark_timestamps_attributes_0__destroy").check
          click_on "登録"
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
        visit bookmark_path(bookmark)
        expect(page).to have_selector "#timestamp-0"
      end

      # タイムスタンプの編集・削除を実行するブックマーク編集ページは表示できないことをspec/system/bookmarks_spec.rbで確認しているためここでは省略
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
