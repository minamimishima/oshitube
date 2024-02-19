module BookmarksHelper
  def youtube_data(video_id)
    require 'google/apis/youtube_v3'

    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['YOUTUBE_API_KEY']
    Rails.cache.fetch("bookmark_#{video_id}", expires_in: 12.hours) do
      youtube.list_videos('snippet', id: video_id)
    end.items.first
  end
end
