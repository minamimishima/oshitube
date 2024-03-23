FactoryBot.define do
  factory :bookmark do
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    url { "https://www.youtube.com/watch?v=#{video_id}" }
    association :user
  end

  trait :video_id_with_12_characters do
    video_id { Faker::Alphanumeric.alphanumeric(number: 12) }
  end

  trait :video_id_with_10_characters do
    video_id { Faker::Alphanumeric.alphanumeric(number: 10) }
  end
end
