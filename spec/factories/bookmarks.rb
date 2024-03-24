FactoryBot.define do
  factory :bookmark do
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    url { "https://www.youtube.com/watch?v=#{video_id}" }
    association :user
  end

  factory :bookmark_with_12_characters_video_id, class: "Bookmark" do
    params = Faker::Alphanumeric.alphanumeric(number: 12) # rubocop:disable all
    url { "https://www.youtube.com/watch?v=#{params}" }
    video_id { params.slice(0, 11) }
  end

  factory :bookmark_with_10_characters_video_id, class: "Bookmark" do
    params = Faker::Alphanumeric.alphanumeric(number: 10) # rubocop:disable all
    url { "https://www.youtube.com/watch?v=#{params}" }
    video_id { nil }
  end

  factory :short_url_bookmark, class: "Bookmark" do
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    url { "https://youtu.be/#{video_id}" }
  end

  factory :short_url_bookmark_with_12_characters_video_id, class: "Bookmark" do
    params = Faker::Alphanumeric.alphanumeric(number: 12) # rubocop:disable all
    url { "https://youtu.be/#{params}" }
    video_id { params.slice(0, 11) }
  end

  factory :short_url_bookmark_with_10_characters_video_id, class: "Bookmark" do
    params = Faker::Alphanumeric.alphanumeric(number: 10) # rubocop:disable all
    url { "https://youtu.be/#{params}" }
    video_id { nil }
  end

  factory :mobile_url_bookmark, class: "Bookmark" do
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    url { "https://m.youtube.com/watch?v=#{video_id}" }
  end

  factory :mobile_url_bookmark_with_12_characters_video_id, class: "Bookmark" do
    params = Faker::Alphanumeric.alphanumeric(number: 12) # rubocop:disable all
    url { "https://m.youtube.com/watch?v=#{params}" }
    video_id { params.slice(0, 11) }
  end

  factory :mobile_url_bookmark_with_10_characters_video_id, class: "Bookmark" do
    params = Faker::Alphanumeric.alphanumeric(number: 10) # rubocop:disable all
    url { "https://m.youtube.com/watch?v=#{params}" }
    video_id { nil }
  end
end
