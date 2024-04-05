require 'rails_helper'

RSpec.describe "Bookmarks", type: :system do
  context "ログインしている状態" do
    context "ユーザー自身のデータに関する処理" do
      it "ブックマーク作成ページが表示できること" do
      end

      it "ブックマークが作成できること" do
      end

      it "公開設定のブックマークが閲覧できること" do
      end

      it "非公開設定のブックマークが閲覧できること" do
      end

      it "編集ページへのリンクが表示されること" do
      end

      it "編集ページが表示できること" do
      end

      it "ブックマークを編集できること" do
      end

      it "削除リンクが表示されること" do
      end

      it "ブックマークを削除できること" do
      end
    end

    context "自分以外のユーザーのデータに関する処理" do
      it "公開設定のブックマークが閲覧できること" do
      end

      it "非公開設定のブックマークは閲覧できないこと" do
      end

      it "編集ページへのリンクが表示されないこと" do
      end

      it "編集ページは表示できないこと" do
      end

      it "削除リンクが表示されないこと" do
      end
    end
  end

  context "ゲストユーザーとしてログインしている状態" do
    context "ゲストユーザー自身のデータに関する処理" do
      it "ブックマーク作成ページが表示できること" do
      end

      it "ブックマークが作成できること" do
      end

      it "公開設定のブックマークが閲覧できること" do
      end

      it "非公開設定のブックマークが閲覧できること" do
      end

      it "編集ページへのリンクが表示されること" do
      end

      it "編集ページが表示できること" do
      end

      it "ブックマークを編集できること" do
      end

      it "削除リンクが表示されること" do
      end

      it "ブックマークを削除できること" do
      end
    end

    context "ゲストユーザー以外のユーザーのデータに関する処理" do
      it "公開設定のブックマークが閲覧できること" do
      end

      it "非公開設定のブックマークは閲覧できないこと" do
      end

      it "編集ページへのリンクが表示されないこと" do
      end

      it "編集ページは表示できないこと" do
      end

      it "削除リンクが表示されないこと" do
      end
    end
  end

  context "ログインしていない状態" do
    it "公開設定のブックマークが閲覧できること" do
    end

    it "非公開設定のブックマークは閲覧できないこと" do
    end

    it "編集ページへのリンクが表示されないこと" do
    end

    it "編集ページは表示できないこと" do
    end

    it "削除リンクが表示されないこと" do
    end
  end
end
