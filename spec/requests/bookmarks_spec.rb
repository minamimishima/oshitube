require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  context "ログインしている状態" do
    let(:user) { create(:user) }
    let(:bookmark) { create(:bookmark) }
    let(:other_user) { bookmark.user }

    before do
      sign_in user
    end

    it "他のユーザーのデータとしてブックマークを作成できないこと" do
      bookmark_params = {
        user_id: other_user.id,
        video_id: "abcdefghijk",
        url: "https://www.youtube.com/watch?v=abcdefghijk",
        description: "動画のメモ",
      }
      expect do
        post bookmarks_path, params: { bookmark: bookmark_params }
      end.to change { other_user.bookmarks.count }.by(0)
    end

    it "他のユーザーのブックマークは編集できないこと" do
      bookmark_params = {
        video_id: "abcdefghijk",
        url: "https://www.youtube.com/watch?v=abcdefghijk",
        description: "新しいメモ",
        is_public: true,
      }
      patch bookmark_path(bookmark), params: { bookmark: bookmark_params }
      aggregate_failures do
        expect(bookmark.reload.video_id).to_not eq "abcdefghijk"
        expect(bookmark.reload.url).to_not eq "https://www.youtube.com/watch?v=abcdefghijk"
        expect(bookmark.reload.description).to_not eq "新しいメモ"
        expect(bookmark.reload.is_public).to_not eq true
      end
    end

    it "他のユーザーのブックマークは削除できないこと" do
      expect do
        delete bookmark_path(bookmark)
      end.to change { other_user.bookmarks.count }.by(0)
    end
  end

  context "ログインしていない状態" do
    let(:bookmark) { create(:bookmark) }
    let(:user) { bookmark.user }

    it "他のユーザーのデータとしてブックマークを作成できないこと" do
      bookmark_params = {
        user_id: user.id,
        video_id: "abcdefghijk",
        url: "https://www.youtube.com/watch?v=abcdefghijk",
        description: "動画のメモ",
      }
      expect do
        post bookmarks_path, params: { bookmark: bookmark_params }
      end.to change { user.bookmarks.count }.by(0)
    end

    it "他のユーザーのブックマークは編集できないこと" do
      bookmark_params = {
        video_id: "abcdefghijk",
        url: "https://www.youtube.com/watch?v=abcdefghijk",
        description: "新しいメモ",
        is_public: true,
      }
      patch bookmark_path(bookmark), params: { bookmark: bookmark_params }
      aggregate_failures do
        expect(bookmark.reload.video_id).to_not eq "abcdefghijk"
        expect(bookmark.reload.url).to_not eq "https://www.youtube.com/watch?v=abcdefghijk"
        expect(bookmark.reload.description).to_not eq "新しいメモ"
        expect(bookmark.reload.is_public).to_not eq true
      end
    end

    it "他のユーザーのブックマークは削除できないこと" do
      expect do
        delete bookmark_path(bookmark)
      end.to change { user.bookmarks.count }.by(0)
    end
  end
end
