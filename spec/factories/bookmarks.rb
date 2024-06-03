FactoryBot.define do
  factory :bookmark do
    video_id { "ABCDEFGHIJK" }
    url { "https://www.youtube.com/watch?v=#{video_id}" }
    description { Faker::JapaneseMedia::StudioGhibli.quote }
    duration { 10980 }
    association :user
  end
end
