FactoryBot.define do
  factory :bookmark do
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    url { "https://www.youtube.com/watch?v=#{video_id}" }
    association :user
  end

  factory :bookmark_with_short_url, class: "Bookmark" do
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    url { "https://youtu.be/#{video_id}" }
  end

  factory :bookmark_with_mobile_url, class: "Bookmark" do
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    url { "https://m.youtube.com/watch?v=#{video_id}" }
  end

  trait :video_id_with_12_characters do
    params = Faker::Alphanumeric.alphanumeric(number: 12) # rubocop:disable all
    url { "https://youtu.be/#{params}" }
    video_id { params.slice(0, 11) }
  end

  trait :video_id_with_10_characters do
    params = Faker::Alphanumeric.alphanumeric(number: 10) # rubocop:disable all
    url { "https://youtu.be/#{params}" }
    video_id { nil }
  end
end
