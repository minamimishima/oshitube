require 'rails_helper'

RSpec.describe BookmarksHelper, type: :helper do
  let(:valid_id) { "HIgvP7B3Hg8" }
  let(:invalid_id) { "ABCDEFGHIJK" }

  describe "video_titleの検証" do
    it "渡されたIDを持つ動画が存在する場合にタイトルを返すこと", :vcr => "youtube_success" do
      expect(helper.video_title(valid_id)).to include "Runaway Baby"
    end

    it "渡されたIDを持つ動画が存在しない場合にVideo Not Foundを返すこと", :vcr => "youtube_failure" do
      expect(helper.video_title(invalid_id)).to eq "Video Not Found"
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
