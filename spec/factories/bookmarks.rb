FactoryBot.define do
  factory :bookmark do
    video_id { Faker::Alphanumeric.alphanumeric(number: 11) }
    url { "https://www.youtube.com/watch?v=#{video_id}" }
    association :user
  end
end
