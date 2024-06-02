module BookmarksHelper
  def get_video_data(video_id)
    require 'google/apis/youtube_v3'

    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['YOUTUBE_API_KEY']
    if video_id.present?
      Rails.cache.fetch("bookmark_#{video_id}", expires_in: 1.days) do
        youtube.list_videos(['snippet', 'content_details'], id: video_id)
      end.items.first
    end
  end

  def video_title(video_id)
    if get_video_data(video_id).present?
      get_video_data(video_id).snippet.title
    else
      "Video Not Found"
    end
  end

  def video_description(video_id)
    if get_video_data(video_id).present?
      get_video_data(video_id).snippet.description
    else
      "Video Not Found"
    end
  end

  def video_thumbnail(video_id)
    if get_video_data(video_id).present?
      thumbnails = get_video_data(video_id).snippet.thumbnails
      thumbnails_resolutions = [:standard, :high, :medium, :default]
      thumbnails_resolutions.each do |resolution|
        return thumbnails.send(resolution).url if thumbnails.send(resolution)
      end
    else
      "not_found.png"
    end
  end

  ISO8601_PATTERN = /PT(?:(?<hour>\d+)H)?(?:(?<minute>\d+)M)?(?<second>\d+)S/
  def get_video_duration(video_id)
    video_data = get_video_data(video_id)
    return if video_data.blank?

    duration = get_video_data(video_id).content_details.duration.match(ISO8601_PATTERN)
    hour = duration[:hour].to_i
    minute = duration[:minute].to_i
    second = duration[:second].to_i

    hour * 3600 + minute * 60 + second
  end
end
