require 'rails_helper'

RSpec.describe BookmarksHelper, type: :helper do
  describe "video_titleの検証" do
    it "渡されたIDを持つ動画が存在する場合にタイトルを返すこと" do
    end

    it "渡されたIDを持つ動画が存在しない場合にVideo Not Foundを返すこと" do
    end
  end

  describe "video_descriptionの検証" do
    it "渡されたIDを持つ動画が存在する場合に概要欄を返すこと" do
    end

    it "渡されたIDを持つ動画が存在しない場合にVideo Not Foundを返すこと" do
    end
  end

  describe "video_thumbnailの検証" do
    it "渡されたIDを持つ動画が存在する場合に、最も解像度の高いサムネイルのURLを返すこと" do
    end

    it "渡されたIDを持つ動画が存在しない場合にnot_found.pngを返すこと" do
    end
  end
end
