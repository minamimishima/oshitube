require 'rails_helper'

RSpec.describe "Timestamps", type: :request do
  context "ログインしている状態" do
    let(:user) { create(:user) }
    let(:bookmark) { create(:bookmark) }
    let(:timestamp) { create(:timestamp, bookmark: bookmark) }

    before do
      sign_in user
    end

    it "他のユーザーのデータとしてタイムスタンプを作成できないこと" do
      timestamp_params = {
        bookmark_id: bookmark.id,
        hour: 0,
        minute: 0,
        second: 0,
        comment: "メモ",
      }
      expect do
        post timestamps_path, params: { timestamp: timestamp_params }
      end.to change { bookmark.timestamps.count }.by(0)
    end

    it "他のユーザーのタイムスタンプは編集できないこと" do
      params = {
        url: bookmark.url,
        description: bookmark.description,
        timestamps_attributes: {
          "0": {
            id: timestamp.id,
            bookmark_id: bookmark.id,
            hour: 0,
            minute: 0,
            second: 0,
            comment: "コメント",
            _destroy: 0,
          },
        },
      }
      patch bookmark_path(bookmark), params: { bookmark: params }
      expect(timestamp.reload.hour).to_not eq 0
    end

    it "他のユーザーのタイムスタンプは削除できないこと" do
      params = {
        url: bookmark.url,
        description: bookmark.description,
        timestamps_attributes: {
          "0": {
            id: timestamp.id,
            bookmark_id: bookmark.id,
            hour: 0,
            minute: 0,
            second: 0,
            comment: "コメント",
            _destroy: 1,
          },
        },
      }
      expect do
        patch bookmark_path(bookmark), params: { bookmark: params }
      end.to change { bookmark.timestamps.count }.by(0)
    end
  end

  context "ログインしていない状態" do
  end
end
