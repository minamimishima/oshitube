require 'rails_helper'

RSpec.describe BookmarksHelper, type: :helper do
  let(:valid_id) { "HIgvP7B3Hg8" }
  let(:invalid_id) { "ABCDEFGHIJK" }

  describe "get_video_dataの検証" do
    it "渡されたIDを持つ動画が存在する場合に動画の情報を返すこと", :vcr => "youtube_success" do
      expect(helper.get_video_data(valid_id)).to be_present
    end

    it "渡されたIDを持つ動画が存在しない場合にnilを返すこと", :vcr => "youtube_failure" do
      expect(helper.get_video_data(invalid_id)).to be_nil
    end
  end

  describe "video_titleの検証" do
    it "渡されたIDを持つ動画が存在する場合にタイトルを返すこと", :vcr => "youtube_success" do
      expect(helper.video_title(valid_id)).to include "Runaway Baby"
    end

    it "渡されたIDを持つ動画が存在しない場合にVideo Not Foundを返すこと", :vcr => "youtube_failure" do
      expect(helper.video_title(invalid_id)).to eq "Video Not Found"
    end
  end

  describe "video_descriptionの検証", :vcr => "youtube_success" do
    it "渡されたIDを持つ動画が存在する場合に概要欄を返すこと" do
      expect(helper.video_description(valid_id)).to include "The official lyric video for Bruno Mars"
    end

    it "渡されたIDを持つ動画が存在しない場合にVideo Not Foundを返すこと", :vcr => "youtube_failure" do
      expect(helper.video_description(invalid_id)).to eq "Video Not Found"
    end
  end

  describe "video_thumbnailの検証" do
    it "渡されたIDを持つ動画が存在する場合に、standard以下の中で最も解像度の高いサムネイルのURLを返すこと", :vcr => "youtube_success" do
      expect(helper.video_thumbnail(valid_id)).to eq "https://i.ytimg.com/vi/HIgvP7B3Hg8/sddefault.jpg"
    end

    it "渡されたIDを持つ動画が存在しない場合にnot_found.pngを返すこと", :vcr => "youtube_failure" do
      expect(helper.video_thumbnail(invalid_id)).to eq "not_found.png"
    end
  end
end
