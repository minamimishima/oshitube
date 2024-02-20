module BookmarksHelper
  def video_attribute(video_id, attribute)
    require 'google/apis/youtube_v3'

    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['YOUTUBE_API_KEY']
    bookmark_video = Rails.cache.fetch("bookmark_#{video_id}", expires_in: 12.hours) do
      youtube.list_videos('snippet', id: video_id)
    end.items.first
    bookmark_video.snippet.send(attribute)
  end

  def video_title(video_id)
    video_attribute(video_id, :title)
  end

  def video_description(video_id)
    video_attribute(video_id, :description)
  end

  def video_thumbnail(video_id)
    thumbnails = video_attribute(video_id, :thumbnails)
    thumbnails_resolutions = [:maxres, :high, :standard, :medium, :default]
    thumbnails_resolutions.each do |resolution|
      return thumbnails.send(resolution).url if thumbnails.send(resolution)
    end
  end
end
