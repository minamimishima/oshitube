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
      timestamp_params = {
        bookmark_id: bookmark.id,
        hour: 9,
        minute: 9,
        second: 9,
        comment: "メモ",
      }
      patch bookmark_path(bookmark), params: { bookmark: timestamp_params }
      aggregate_failures do
        expect(timestamp.reload.hour).to_not eq 9
        expect(timestamp.reload.second).to_not eq 9
        expect(timestamp.reload.minute).to_not eq 9
        expect(timestamp.reload.comment).to_not eq "メモ"
      end
    end

    it "他のユーザーのタイムスタンプは削除できないこと" do
      expect do
        delete bookmark_path(bookmark)
      end.to change { bookmark.timestamps.count }.by(0)
    end
  end

  context "ログインしていない状態" do
    let(:bookmark) { create(:bookmark) }
    let(:timestamp) { create(:timestamp, bookmark: bookmark) }

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
      timestamp_params = {
        bookmark_id: bookmark.id,
        hour: 9,
        minute: 9,
        second: 9,
        comment: "メモ",
      }
      patch bookmark_path(bookmark), params: { bookmark: timestamp_params }
      aggregate_failures do
        expect(timestamp.reload.hour).to_not eq 9
        expect(timestamp.reload.second).to_not eq 9
        expect(timestamp.reload.minute).to_not eq 9
        expect(timestamp.reload.comment).to_not eq "メモ"
      end
    end

    it "他のユーザーのタイムスタンプは削除できないこと" do
      expect do
        delete bookmark_path(bookmark)
      end.to change { bookmark.timestamps.count }.by(0)
    end
  end
end
