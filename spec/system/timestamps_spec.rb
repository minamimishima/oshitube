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
    context "ユーザー自身のデータに関する処理" do
      it "ブックマークの詳細ページにタイムスタンプ登録フォームが表示されること" do
      end

      it "タイムスタンプを作成できること" do
      end

      it "作成したタイムスタンプが表示されること" do
      end

      it "タイムスタンプを編集できること" do
      end

      it "タイムスタンプを削除できること" do
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
